package com.PayChoice.Member360

import android.content.Context
import android.content.Intent
import android.util.Log
import android.Manifest
import android.content.pm.PackageManager
import android.os.Build
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.openpath.mobileaccesscore.OpenpathMobileAccessCore

class OpenpathPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    private lateinit var context: Context
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel

    private val TAG = "OpenPathPlugin"

    private fun hasPermission(permission: String): Boolean {
        return ContextCompat.checkSelfPermission(context, permission) == PackageManager.PERMISSION_GRANTED
    }

    private fun canStartForegroundService(): Boolean {
        // Android 13+ requires POST_NOTIFICATIONS for foreground service notifications
        if (Build.VERSION.SDK_INT >= 33) {
            if (!hasPermission(Manifest.permission.POST_NOTIFICATIONS)) {
                Log.w(TAG, "Skipping foreground service start: POST_NOTIFICATIONS not granted")
                return false
            }
        }
        // Android 12+ Bluetooth permissions are required for scanning/connection used by the SDK
        if (Build.VERSION.SDK_INT >= 31) {
            val hasScan = hasPermission(Manifest.permission.BLUETOOTH_SCAN)
            val hasConnect = hasPermission(Manifest.permission.BLUETOOTH_CONNECT)
            if (!hasScan || !hasConnect) {
                Log.w(TAG, "Skipping foreground service start: Bluetooth permissions missing (SCAN=$hasScan, CONNECT=$hasConnect)")
                return false
            }
        }
        // Location often required for BLE scanning on many OEMs
        val hasFineLocation = hasPermission(Manifest.permission.ACCESS_FINE_LOCATION)
        if (!hasFineLocation) {
            Log.w(TAG, "Skipping foreground service start: ACCESS_FINE_LOCATION not granted")
            return false
        }
        return true
    }

    // Start SDK Foreground Service
    private fun startSdkForegroundService(): Boolean {
        try {
            if (!canStartForegroundService()) return false
            val intent = Intent(context, com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
            ContextCompat.startForegroundService(context, intent)
            Log.d(TAG, "ForegroundService started")
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

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initialize" -> {
                val started = startSdkForegroundService()
                if (started) {
                    result.success(true)
                } else {
                    result.error(
                        "permissions_missing",
                        "Required runtime permissions not granted. Request notifications, Bluetooth (scan/connect) and fine location, then retry.",
                        null
                    )
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

                val started = startSdkForegroundService()
                if (!started) {
                    result.error(
                        "permissions_missing",
                        "Required runtime permissions not granted. Request notifications, Bluetooth (scan/connect) and fine location, then retry.",
                        null
                    )
                    return
                }
                whenServiceStarted {
                    try {
                        val core = OpenpathMobileAccessCore.getInstance()
                        core.provision(jwt, opal)
                        result.success(true)
                    } catch (e: Exception) {
                        Log.e(TAG, "Provision error: ${e.message}", e)
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
        // Emit events
        sink?.success(mapOf("event" to "ready", "data" to "Openpath stream connected"))
    }

    override fun onCancel(args: Any?) {
        // Handle cancelation
    }
}
