package com.PayChoice.Member360

import android.Manifest
import android.app.ActivityManager
import android.app.NotificationManager
import android.bluetooth.BluetoothAdapter
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.content.pm.PackageManager
import android.location.LocationManager
import android.os.Build
import android.os.IBinder
import android.provider.Settings
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import android.os.Handler
import android.os.Looper
import java.util.concurrent.Executors
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

    private val TAG = "OpenPathPlugin"

    private var activityBinding: ActivityPluginBinding? = null

    // Start SDK Foreground Service
    private var foregroundServiceStarted: Boolean = false
    private val mainHandler: Handler = Handler(Looper.getMainLooper())
    private val backgroundExecutor = Executors.newSingleThreadExecutor()
    
    // Service instance reference for SDK
    private var serviceInstance: com.openpath.mobileaccesscore.OpenpathForegroundService? = null
    private var serviceBound = false
    
    // Service connection for binding to the foreground service
    private val serviceConnection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            Log.d(TAG, "Service connected: $name")
            serviceBound = true
            
            // Get the service instance from the binder
            try {
                if (service is com.openpath.mobileaccesscore.OpenpathForegroundService.LocalBinder) {
                    serviceInstance = service.getService()
                    Log.d(TAG, "Got service instance from LocalBinder")
                    
                    // Initialize the SDK with the service instance
                    initializeSdkWithService()
                } else {
                    Log.w(TAG, "Service binder is not LocalBinder type: ${service?.javaClass?.simpleName}")
                    
                    // Try alternative approaches to get service reference
                    try {
                        // Some services might use different binder patterns
                        val getServiceMethod = service?.javaClass?.getMethod("getService")
                        if (getServiceMethod != null) {
                            serviceInstance = getServiceMethod.invoke(service) as? com.openpath.mobileaccesscore.OpenpathForegroundService
                            if (serviceInstance != null) {
                                Log.d(TAG, "Got service instance from generic getService method")
                                initializeSdkWithService()
                            }
                        }
                    } catch (e2: Exception) {
                        Log.w(TAG, "Failed to get service via alternative method: ${e2.message}")
                    }
                }
            } catch (e: Exception) {
                Log.w(TAG, "Failed to get service instance from binder: ${e.message}")
            }
        }
        
        override fun onServiceDisconnected(name: ComponentName?) {
            Log.d(TAG, "Service disconnected: $name")
            serviceBound = false
            serviceInstance = null
        }
    }
    
    // Initialize SDK with service reference
    private fun initializeSdkWithService() {
        try {
            val core = OpenpathMobileAccessCore.getInstance()
            
            // Try different methods to set the service reference
            if (serviceInstance != null) {
                try {
                    val setServiceMethod = core.javaClass.getMethod("setForegroundService", com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
                    setServiceMethod.invoke(core, serviceInstance)
                    Log.d(TAG, "Successfully set foreground service reference in SDK")
                } catch (e: NoSuchMethodException) {
                    // Try alternative method names
                    try {
                        val setServiceMethod = core.javaClass.getMethod("setService", com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
                        setServiceMethod.invoke(core, serviceInstance)
                        Log.d(TAG, "Successfully set service reference in SDK using setService")
                    } catch (e2: NoSuchMethodException) {
                        // Try with init method that takes service
                        try {
                            val initMethod = core.javaClass.getMethod("init", com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
                            initMethod.invoke(core, serviceInstance)
                            Log.d(TAG, "Successfully initialized SDK with service using init")
                        } catch (e3: NoSuchMethodException) {
                            Log.w(TAG, "SDK doesn't have expected service setter methods")
                        }
                    }
                }
            }
        } catch (e: Exception) {
            Log.w(TAG, "Failed to initialize SDK with service: ${e.message}")
        }
    }

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
            // Check if service is already running
            val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
            val isServiceRunning = activityManager.getRunningServices(Integer.MAX_VALUE)
                .any { it.service.className == "com.openpath.mobileaccesscore.OpenpathForegroundService" }
            
            if (isServiceRunning && foregroundServiceStarted) {
                Log.d(TAG, "ForegroundService already running; skipping")
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
            
            // Give the service a moment to start
            Thread.sleep(1000)
            
            // Bind to the service for better communication and to get service instance
            try {
                val bindResult = context.bindService(intent, serviceConnection, Context.BIND_AUTO_CREATE or Context.BIND_IMPORTANT)
                Log.d(TAG, "Service bind result: $bindResult")
                
                if (bindResult) {
                    // Wait a bit for the binding to complete
                    Thread.sleep(500)
                }
            } catch (e: Exception) {
                Log.w(TAG, "Failed to bind to service: ${e.message}")
            }
            
            // Mark as started after attempting to start
            foregroundServiceStarted = true
            return true
        } catch (e: Exception) {
            Log.e(TAG, "Failed to start ForegroundService: ${e.message}", e)
            return false
        }
    }

    // Enhanced service readiness check
    private fun whenServiceStarted(onReady: () -> Unit) {
        // Give additional time for service to fully initialize
        backgroundExecutor.execute {
            try {
                Thread.sleep(1000) // Wait for service to be fully ready
                
                // Verify service is running before proceeding
                val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
                val isServiceRunning = activityManager.getRunningServices(Integer.MAX_VALUE)
                    .any { it.service.className == "com.openpath.mobileaccesscore.OpenpathForegroundService" }
                
                if (isServiceRunning) {
                    Log.d(TAG, "Service verified as running, proceeding with operation")
                    onReady()
                } else {
                    Log.w(TAG, "Service not running when expected, attempting restart")
                    startSdkForegroundService()
                    Thread.sleep(2000) // Give more time after restart
                    onReady()
                }
            } catch (e: Exception) {
                Log.e(TAG, "Error in whenServiceStarted: ${e.message}", e)
                onReady() // Proceed anyway
            }
        }
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

                if (!startSdkForegroundService()) {
                    result.error("fgs_not_started", "Foreground service not started (likely missing notification permission)", null)
                    return
                }

                whenServiceStarted {
                    // This is already running in background executor from whenServiceStarted
                    try {
                        val backoffsMs = intArrayOf(1000, 2000, 3000, 5000, 8000)
                        var attempt = 0
                        var lastError: Exception? = null

                        while (attempt < backoffsMs.size) {
                            try {
                                // Wait before each attempt to give SDK service time to initialize
                                Thread.sleep(backoffsMs[attempt].toLong())
                                
                                val core = OpenpathMobileAccessCore.getInstance()
                                
                                // Try multiple initialization approaches
                                var sdkInitialized = false
                                
                                // Approach 1: Use service instance if available
                                if (serviceBound && serviceInstance != null) {
                                    Log.d(TAG, "Using bound service instance for SDK initialization")
                                    initializeSdkWithService()
                                    sdkInitialized = true
                                } else {
                                    Log.w(TAG, "Service not bound or instance null, trying alternative approaches")
                                }
                                
                                // Approach 2: Try to initialize with context
                                if (!sdkInitialized) {
                                    try {
                                        val initMethod = core.javaClass.getMethod("initialize", Context::class.java)
                                        initMethod.invoke(core, context.applicationContext)
                                        Log.d(TAG, "Initialized SDK with context")
                                        sdkInitialized = true
                                    } catch (e: NoSuchMethodException) {
                                        Log.d(TAG, "SDK doesn't have initialize(Context) method")
                                    } catch (e: Exception) {
                                        Log.w(TAG, "Failed to initialize SDK with context: ${e.message}")
                                    }
                                }
                                
                                // Approach 3: Try init without parameters (SDK might auto-detect service)
                                if (!sdkInitialized) {
                                    try {
                                        val initMethod = core.javaClass.getMethod("init")
                                        initMethod.invoke(core)
                                        Log.d(TAG, "Initialized SDK with parameterless init")
                                        sdkInitialized = true
                                    } catch (e: NoSuchMethodException) {
                                        Log.d(TAG, "SDK doesn't have parameterless init method")
                                    } catch (e: Exception) {
                                        Log.w(TAG, "Failed to initialize SDK with parameterless init: ${e.message}")
                                    }
                                }
                                
                                // Approach 4: Try to rebind service if still not initialized
                                if (!sdkInitialized && (!serviceBound || serviceInstance == null)) {
                                    Log.w(TAG, "Attempting to rebind service for SDK initialization")
                                    val serviceIntent = Intent(context, com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
                                    try {
                                        context.bindService(serviceIntent, serviceConnection, Context.BIND_AUTO_CREATE or Context.BIND_IMPORTANT)
                                        Thread.sleep(1500) // Wait for binding
                                        
                                        if (serviceBound && serviceInstance != null) {
                                            initializeSdkWithService()
                                            sdkInitialized = true
                                        }
                                    } catch (e: Exception) {
                                        Log.w(TAG, "Failed to rebind service: ${e.message}")
                                    }
                                }
                                
                                // Verify service is still running
                                val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
                                val isServiceRunning = activityManager.getRunningServices(Integer.MAX_VALUE)
                                    .any { it.service.className == "com.openpath.mobileaccesscore.OpenpathForegroundService" }
                                
                                if (!isServiceRunning) {
                                    Log.w(TAG, "Service not running, restarting")
                                    val serviceIntent = Intent(context, com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
                                    if (isAppInForeground()) {
                                        context.startService(serviceIntent)
                                    } else {
                                        ContextCompat.startForegroundService(context, serviceIntent)
                                    }
                                    Thread.sleep(2000)
                                }
                                
                                Log.d(TAG, "Attempting provision with JWT: ${jwt.take(20)}... and OPAL: ${opal.take(20)}...")
                                
                                // Try provision with different parameter combinations
                                try {
                                    // First try with both parameters
                                    core.provision(jwt, opal)
                                } catch (e: Exception) {
                                    Log.w(TAG, "Provision with both params failed, trying JWT only: ${e.message}")
                                    // Some SDKs might expect only JWT
                                    core.provision(jwt)
                                }
                                
                                // Success -> reply on main thread
                                mainHandler.post { result.success(true) }
                                return@whenServiceStarted
                            } catch (e: Exception) {
                                lastError = e
                                Log.w(TAG, "Provision attempt ${attempt + 1} failed: ${e.message}")
                            }
                            attempt++
                        }

                        val msg = lastError?.message ?: "Unknown provision error"
                        Log.e(TAG, "Provision error after retries: $msg", lastError)
                        mainHandler.post { result.error("provision_error", msg, null) }
                    } catch (e: Exception) {
                        Log.e(TAG, "Provision error (outer): ${e.message}", e)
                        mainHandler.post { result.error("provision_error", e.message, null) }
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
        
        // Initialize OpenPath SDK early with application context
        try {
            // Try to initialize the SDK with application context first
            val core = OpenpathMobileAccessCore.getInstance()
            
            // Try different initialization methods that might exist
            try {
                val initMethod = core.javaClass.getMethod("init", Context::class.java)
                initMethod.invoke(core, context.applicationContext)
                Log.d(TAG, "Successfully initialized OpenPath SDK with init(context)")
            } catch (e: NoSuchMethodException) {
                try {
                    val initMethod = core.javaClass.getMethod("initialize", Context::class.java)
                    initMethod.invoke(core, context.applicationContext)
                    Log.d(TAG, "Successfully initialized OpenPath SDK with initialize(context)")
                } catch (e2: NoSuchMethodException) {
                    Log.d(TAG, "OpenPath SDK doesn't require explicit context initialization")
                } catch (e2: Exception) {
                    Log.w(TAG, "Failed to initialize OpenPath SDK with context: ${e2.message}")
                }
            } catch (e: Exception) {
                Log.w(TAG, "Failed to initialize OpenPath SDK with context: ${e.message}")
            }
            
            Log.d(TAG, "OpenPath SDK core instance obtained during plugin initialization")
        } catch (e: Exception) {
            Log.w(TAG, "Failed to get OpenPath SDK core instance during initialization: ${e.message}")
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        methodChannel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
        
        // Unbind from service if bound
        try {
            if (serviceBound) {
                context.unbindService(serviceConnection)
                serviceBound = false
            }
        } catch (e: Exception) {
            Log.w(TAG, "Failed to unbind service: ${e.message}")
        }
    }

    override fun onListen(args: Any?, sink: EventChannel.EventSink?) {
        sink?.success(mapOf("event" to "ready", "data" to "Openpath stream connected"))
    }

    override fun onCancel(args: Any?) { }

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
