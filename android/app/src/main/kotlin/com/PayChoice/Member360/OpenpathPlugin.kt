package com.PayChoice.Member360

import android.Manifest
import android.app.ActivityManager
import android.app.NotificationManager
import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.location.LocationManager
import android.os.Build
import android.provider.Settings
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.openpath.mobileaccesscore.OpenpathMobileAccessCore

class OpenpathPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, EventChannel.StreamHandler, ActivityAware {

    private lateinit var context: Context
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private var eventSink: EventChannel.EventSink? = null

    private val TAG = "OpenPathPlugin"

    private var activityBinding: ActivityPluginBinding? = null

    // Start SDK Foreground Service
    private var foregroundServiceStarted: Boolean = false

    private fun hasPostNotificationsPermission(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            ContextCompat.checkSelfPermission(
                context,
                Manifest.permission.POST_NOTIFICATIONS
            ) == PackageManager.PERMISSION_GRANTED
        } else {
            true
        }
    }

    private fun isAppInForeground(): Boolean {
        return try {
            val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                val appProcesses = activityManager.runningAppProcesses ?: return false
                val myPackage = context.packageName
                appProcesses.any { it.processName == myPackage && it.importance == ActivityManager.RunningAppProcessInfo.IMPORTANCE_FOREGROUND }
            } else {
                true
            }
        } catch (_: Exception) { false }
    }

    private fun startSdkForegroundService(): Boolean {
        try {
            if (foregroundServiceStarted) {
                Log.d(TAG, "ForegroundService already started; skipping")
                return true
            }

            if (!hasPostNotificationsPermission()) {
                Log.w(TAG, "POST_NOTIFICATIONS not granted; skipping foreground service start")
                return false
            }

            val intent = Intent(context, com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)

            // If app is in foreground, prefer startService to avoid FGS timeout.
            // On background, use startForegroundService.
            if (isAppInForeground()) {
                context.startService(intent)
                Log.d(TAG, "startService invoked for OpenpathForegroundService (app in foreground)")
            } else {
                ContextCompat.startForegroundService(context, intent)
                Log.d(TAG, "startForegroundService invoked for OpenpathForegroundService (app in background)")
            }
            // Do not mark as started until service posts its notification; rely on idempotency when called again
            foregroundServiceStarted = false
            return true
        } catch (e: Exception) {
            Log.e(TAG, "Failed to start ForegroundService: ${e.message}", e)
            return false
        }
    }

    // Minimal readiness shim: call immediately after starting the service
    private fun whenServiceStarted(onReady: () -> Unit) {
        try {
            onReady()
        } catch (e: Exception) {
            Log.e(TAG, "Error executing action after service start: ${e.message}", e)
        }
    }

    private fun emitEvent(name: String, data: Any?) {
        try {
            eventSink?.success(mapOf("event" to name, "data" to data))
        } catch (e: Exception) {
            Log.w(TAG, "Failed to emit event ${name}: ${e.message}")
        }
    }

    private fun emitProvisionStatus(ok: Boolean, message: String) {
        try {
            methodChannel.invokeMethod(
                "provisionStatus",
                mapOf(
                    "ok" to ok,
                    "message" to message
                )
            )
        } catch (e: Exception) {
            Log.w(TAG, "Failed to emit provisionStatus: ${e.message}")
        }
    }

    private fun provisionWithRetries(jwt: String, opal: String): Boolean {
        val backoff = arrayOf(200L, 400L, 800L, 1600L, 2400L)
        for (i in backoff.indices) {
            try {
                if (!startSdkForegroundService()) {
                    Log.w(TAG, "provision attempt ${i}: foreground service not started")
                }
                // Give the service a moment to initialize its internal references
                Thread.sleep(150)
                val core = OpenpathMobileAccessCore.getInstance()
                core.provision(jwt, opal)
                return true
            } catch (e: Exception) {
                val msg = e.message ?: ""
                Log.w(TAG, "Provision attempt ${i} failed: ${msg}")
                // Retry on likely race condition where foreground service ref is null; otherwise still retry a few times
            }
            try { Thread.sleep(backoff[i]) } catch (_: InterruptedException) {}
        }
        return false
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initialize" -> {
                val ok = startSdkForegroundService()
                result.success(ok)
            }

            "requestPermissions" -> {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    val granted = hasPostNotificationsPermission()
                    if (!granted) {
                        val activity = activityBinding?.activity
                        if (activity != null) {
                            try {
                                ActivityCompat.requestPermissions(
                                    activity,
                                    arrayOf(Manifest.permission.POST_NOTIFICATIONS),
                                    1001
                                )
                            } catch (e: Exception) {
                                Log.w(TAG, "Failed to request notifications permission, opening settings: ${e.message}")
                                val intent = Intent().apply {
                                    action = Settings.ACTION_APP_NOTIFICATION_SETTINGS
                                    putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName)
                                    addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                                }
                                context.startActivity(intent)
                            }
                        } else {
                            val intent = Intent().apply {
                                action = Settings.ACTION_APP_NOTIFICATION_SETTINGS
                                putExtra(Settings.EXTRA_APP_PACKAGE, context.packageName)
                                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            }
                            context.startActivity(intent)
                        }
                    }
                    result.success(hasPostNotificationsPermission())
                } else {
                    result.success(true)
                }
            }

            "getPermissionStatus" -> {
                val notificationsOn = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    hasPostNotificationsPermission()
                } else {
                    val nm = ContextCompat.getSystemService(context, NotificationManager::class.java)
                    nm?.areNotificationsEnabled() ?: true
                }

                val btOn = try {
                    BluetoothAdapter.getDefaultAdapter()?.isEnabled ?: true
                } catch (_: Exception) { true }

                val locationOn = try {
                    val lm = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
                    lm.isProviderEnabled(LocationManager.GPS_PROVIDER) || lm.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
                } catch (_: Exception) { true }

                result.success(
                    mapOf(
                        "btOn" to btOn,
                        "locationOn" to locationOn,
                        "notificationsOn" to notificationsOn,
                        "baseOk" to (btOn && notificationsOn),
                        "bgOk" to true
                    )
                )
            }

            "getAvailableMethods" -> {
                result.success(listOf(
                    "initialize",
                    "provision",
                    "unprovision",
                    "requestPermissions",
                    "getPermissionStatus",
                    "getUserOpal",
                    "getAvailableMethods"
                ))
            }

            "getUserOpal" -> {
                try {
                    // Android Openpath SDK may not expose a direct user accessor. Return null for now.
                    result.success(null)
                } catch (e: Exception) {
                    Log.w(TAG, "getUserOpal failed: ${e.message}")
                    result.success(null)
                }
            }

            "provision" -> {
                var jwt = (call.argument<String>("jwt")?.trim() ?: "")
                val token = (call.argument<String>("token")?.trim() ?: "")
                if (jwt.isEmpty()) jwt = token
                val opal = (call.argument<String>("opal")?.trim() ?: "")
                if (jwt.isBlank() || opal.isBlank()) {
                    result.error("invalid_args", "Invalid JWT or OPAL", null)
                    return
                }

                emitEvent("provisioning_started", System.currentTimeMillis())
                emitProvisionStatus(true, "provisioning_started")

                whenServiceStarted {
                    try {
                        val ok = provisionWithRetries(jwt, opal)
                        if (ok) {
                            emitEvent("provision_success", mapOf("opal" to opal))
                            emitProvisionStatus(true, "Provision request accepted")
                            result.success(true)
                        } else {
                            emitEvent("provision_failed", mapOf("error" to "Provision failed after retries"))
                            emitProvisionStatus(false, "Provision failed after retries")
                            result.error("provision_error", "Provision failed after retries", null)
                        }
                    } catch (e: Exception) {
                        Log.e(TAG, "Provision error: ${e.message}", e)
                        emitEvent("provision_failed", mapOf("error" to (e.message ?: "unknown")))
                        emitProvisionStatus(false, e.message ?: "Provision error")
                        result.error("provision_error", e.message, null)
                    }
                }
            }

            "unprovision" -> {
                val opal = (call.argument<String>("opal")?.trim())
                try {
                    val core = OpenpathMobileAccessCore.getInstance()
                    if (opal != null && opal.isNotEmpty()) {
                        core.unprovision(opal)
                    } else {
                        core.unprovision(null)
                    }
                    result.success(true)
                } catch (e: Exception) {
                    result.error("unprovision_error", e.message, null)
                }
            }

            else -> result.notImplemented()
        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        methodChannel = MethodChannel(binding.binaryMessenger, "openpath")
        eventChannel = EventChannel(binding.binaryMessenger, "openpath_events")
        methodChannel.setMethodCallHandler(this)
        eventChannel.setStreamHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    override fun onListen(args: Any?, sink: EventChannel.EventSink?) {
        eventSink = sink
        sink?.success(mapOf("event" to "ready", "data" to "Openpath stream connected"))
    }

    override fun onCancel(args: Any?) { eventSink = null }

    // ActivityAware
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activityBinding = binding
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.activityBinding = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.activityBinding = binding
    }

    override fun onDetachedFromActivity() {
        this.activityBinding = null
    }
}
