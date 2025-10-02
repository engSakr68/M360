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
import io.flutter.plugin.common.PluginRegistry
import com.openpath.mobileaccesscore.OpenpathMobileAccessCore

class OpenpathPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, EventChannel.StreamHandler, ActivityAware, PluginRegistry.RequestPermissionsResultListener {

    private lateinit var context: Context
    private lateinit var methodChannel: MethodChannel
    private lateinit var eventChannel: EventChannel
    private var eventSink: EventChannel.EventSink? = null

    private val TAG = "OpenPathPlugin"

    private var activityBinding: ActivityPluginBinding? = null
    
    // Permission request handling
    private var pendingPermissionResult: MethodChannel.Result? = null
    private val PERMISSION_REQUEST_CODE = 1001

    // Start SDK Foreground Service
    private var foregroundServiceStarted: Boolean = false
    private val mainHandler: Handler = Handler(Looper.getMainLooper())
    private val backgroundExecutor = Executors.newSingleThreadExecutor()
    
    // Service instance reference for SDK
    private var serviceInstance: com.openpath.mobileaccesscore.OpenpathForegroundService? = null
    private var serviceBound = false
    private var serviceReady = false
    private val serviceReadyCallbacks = mutableListOf<() -> Unit>()
    private val serviceReadyLock = Object()
    
    // Service connection for binding to the foreground service
    private val serviceConnection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName?, service: IBinder?) {
            Log.d(TAG, "Service connected: $name")
            serviceBound = true
            
            // Get the service instance from the binder
            try {
                // Try to get service instance using reflection since LocalBinder may not be available
                val getServiceMethod = service?.javaClass?.getMethod("getService")
                if (getServiceMethod != null) {
                    serviceInstance = getServiceMethod.invoke(service) as? com.openpath.mobileaccesscore.OpenpathForegroundService
                    if (serviceInstance != null) {
                        Log.d(TAG, "Got service instance from binder")
                        // Initialize the SDK with the service instance
                        initializeSdkWithService()
                    } else {
                        Log.w(TAG, "Service instance is null after invoking getService")
                    }
                } else {
                    Log.w(TAG, "getService method not found on binder: ${service?.javaClass?.simpleName}")
                    // For OpenPath SDK v0.5.0, the service connection might work differently
                    // Just mark as connected and proceed without service instance
                    Log.d(TAG, "Proceeding without service instance for OpenPath SDK v0.5.0")
                }
            } catch (e: Exception) {
                Log.w(TAG, "Failed to get service instance from binder: ${e.message}")
                // For OpenPath SDK v0.5.0, service binding might not be required
                Log.d(TAG, "Proceeding without service instance - SDK may not require it")
            }
            
            // Wait a bit for service to fully initialize, then mark as ready
            backgroundExecutor.execute {
                try {
                    Thread.sleep(2000) // Give service time to fully initialize
                    
                    // Verify the service is actually ready by checking if it's running
                    val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
                    val isServiceRunning = activityManager.getRunningServices(Integer.MAX_VALUE)
                        .any { it.service.className == "com.openpath.mobileaccesscore.OpenpathForegroundService" }
                    
                    if (isServiceRunning) {
                        synchronized(serviceReadyLock) {
                            serviceReady = true
                            Log.d(TAG, "Service is now ready, executing ${serviceReadyCallbacks.size} pending callbacks")
                            
                            // Execute all pending callbacks on main thread
                            mainHandler.post {
                                val callbacksToExecute = serviceReadyCallbacks.toList()
                                serviceReadyCallbacks.clear()
                                
                                callbacksToExecute.forEach { callback ->
                                    try {
                                        callback()
                                    } catch (e: Exception) {
                                        Log.e(TAG, "Error executing service ready callback: ${e.message}", e)
                                    }
                                }
                            }
                            
                            // Emit service ready event
                            emitEvent("service_ready", mapOf(
                                "timestamp" to System.currentTimeMillis(),
                                "serviceBound" to serviceBound,
                                "hasServiceInstance" to (serviceInstance != null)
                            ))
                        }
                    } else {
                        Log.w(TAG, "Service connected but not running, will retry readiness check")
                    }
                } catch (e: Exception) {
                    Log.e(TAG, "Error in service ready check: ${e.message}", e)
                }
            }
        }
        
        override fun onServiceDisconnected(name: ComponentName?) {
            Log.d(TAG, "Service disconnected: $name")
            synchronized(serviceReadyLock) {
                serviceBound = false
                serviceInstance = null
                serviceReady = false
            }
            
            // Emit service disconnected event
            emitEvent("service_disconnected", mapOf("timestamp" to System.currentTimeMillis()))
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

    // Wait for service ready signal with proper synchronization
    private fun whenServiceReady(onReady: () -> Unit) {
        synchronized(serviceReadyLock) {
            if (serviceReady) {
                Log.d(TAG, "Service already ready, executing callback immediately")
                mainHandler.post { onReady() }
                return
            }
            
            Log.d(TAG, "Service not ready, adding callback to queue")
            serviceReadyCallbacks.add(onReady)
        }
        
        // Ensure service is started if not already
        if (!foregroundServiceStarted) {
            Log.d(TAG, "Service not started, starting now...")
            startSdkForegroundService()
        }
    }

    // Enhanced service readiness check (legacy method for compatibility)
    private fun whenServiceStarted(onReady: () -> Unit) {
        // Give additional time for service to fully initialize
        backgroundExecutor.execute {
            try {
                var attempts = 0
                val maxAttempts = 3
                var serviceReady = false
                
                while (attempts < maxAttempts && !serviceReady) {
                    attempts++
                    Log.d(TAG, "Service readiness check attempt $attempts/$maxAttempts")
                    
                    Thread.sleep(1000) // Wait for service to be fully ready
                    
                    // Verify service is running before proceeding
                    val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
                    val isServiceRunning = activityManager.getRunningServices(Integer.MAX_VALUE)
                        .any { it.service.className == "com.openpath.mobileaccesscore.OpenpathForegroundService" }
                    
                    if (isServiceRunning) {
                        Log.d(TAG, "Service verified as running on attempt $attempts, proceeding with operation")
                        serviceReady = true
                    } else {
                        Log.w(TAG, "Service not running on attempt $attempts, attempting restart")
                        foregroundServiceStarted = false
                        startSdkForegroundService()
                        Thread.sleep(2000) // Give more time after restart
                    }
                }
                
                if (serviceReady) {
                    Log.d(TAG, "Service is ready, executing callback")
                } else {
                    Log.w(TAG, "Service readiness could not be verified after $maxAttempts attempts, proceeding anyway")
                }
                
                onReady()
            } catch (e: Exception) {
                Log.e(TAG, "Error in whenServiceStarted: ${e.message}", e)
                onReady() // Proceed anyway
            }
        }
    }

    private fun emitEvent(name: String, data: Any?) {
        try {
            // Always ensure event emission happens on the main UI thread
            if (Looper.myLooper() == Looper.getMainLooper()) {
                // Already on main thread, emit directly
                try {
                    eventSink?.success(mapOf("event" to name, "data" to data))
                    Log.d(TAG, "Emitted event '$name' directly on main thread")
                } catch (e: Exception) {
                    Log.w(TAG, "Failed to emit event ${name} on main thread: ${e.message}")
                }
            } else {
                // Not on main thread, post to main thread
                mainHandler.post {
                    try {
                        eventSink?.success(mapOf("event" to name, "data" to data))
                        Log.d(TAG, "Emitted event '$name' via main thread post")
                    } catch (e: Exception) {
                        Log.w(TAG, "Failed to emit event ${name} via main thread post: ${e.message}")
                    }
                }
            }
        } catch (e: Exception) {
            Log.e(TAG, "Critical error in emitEvent for ${name}: ${e.message}", e)
        }
    }

    private fun emitProvisionStatus(ok: Boolean, message: String) {
        try {
            // Always ensure method channel calls happen on the main UI thread
            if (Looper.myLooper() == Looper.getMainLooper()) {
                // Already on main thread, call directly
                try {
                    methodChannel.invokeMethod(
                        "provisionStatus",
                        mapOf(
                            "ok" to ok,
                            "message" to message
                        )
                    )
                    Log.d(TAG, "Emitted provisionStatus directly on main thread: $message")
                } catch (e: Exception) {
                    Log.w(TAG, "Failed to emit provisionStatus on main thread: ${e.message}")
                }
            } else {
                // Not on main thread, post to main thread
                mainHandler.post {
                    try {
                        methodChannel.invokeMethod(
                            "provisionStatus",
                            mapOf(
                                "ok" to ok,
                                "message" to message
                            )
                        )
                        Log.d(TAG, "Emitted provisionStatus via main thread post: $message")
                    } catch (e: Exception) {
                        Log.w(TAG, "Failed to emit provisionStatus via main thread post: ${e.message}")
                    }
                }
            }
        } catch (e: Exception) {
            Log.e(TAG, "Critical error in emitProvisionStatus: ${e.message}", e)
        }
    }

    private fun provisionWithRetries(jwt: String, opal: String): Boolean {
        val backoff = arrayOf(200L, 400L, 800L, 1600L, 2400L)
        for (i in backoff.indices) {
            try {
                // Ensure foreground service is started and ready
                if (!startSdkForegroundService()) {
                    Log.w(TAG, "provision attempt ${i + 1}: foreground service not started")
                }
                
                // Give the service more time to initialize its internal references
                Thread.sleep(500)
                
                // Verify service is actually running before attempting provision
                val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
                val isServiceRunning = activityManager.getRunningServices(Integer.MAX_VALUE)
                    .any { it.service.className == "com.openpath.mobileaccesscore.OpenpathForegroundService" }
                
                if (!isServiceRunning) {
                    Log.w(TAG, "provision attempt ${i + 1}: service not running, retrying...")
                    continue
                }
                
                val core = OpenpathMobileAccessCore.getInstance()
                
                // Try to set service reference if we have it
                if (serviceInstance != null) {
                    try {
                        val setServiceMethod = core.javaClass.getMethod("setForegroundService", com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
                        setServiceMethod.invoke(core, serviceInstance)
                        Log.d(TAG, "Set foreground service reference before provision attempt ${i + 1}")
                    } catch (e: Exception) {
                        Log.d(TAG, "Could not set service reference, proceeding anyway: ${e.message}")
                    }
                }
                
                Log.d(TAG, "Attempting provision ${i + 1} with JWT and OPAL")
                core.provision(jwt, opal)
                Log.d(TAG, "Provision attempt ${i + 1} completed successfully")
                return true
            } catch (e: Exception) {
                val msg = e.message ?: ""
                Log.w(TAG, "Provision attempt ${i + 1} failed: $msg")
                
                // If this is a foreground service null error, try to restart the service
                if (msg.contains("foreground service is null") || msg.contains("service") && msg.contains("null")) {
                    Log.d(TAG, "Detected service null error, attempting to restart service")
                    foregroundServiceStarted = false
                    startSdkForegroundService()
                }
            }
            
            if (i < backoff.size - 1) {
                try { 
                    Log.d(TAG, "Waiting ${backoff[i]}ms before retry...")
                    Thread.sleep(backoff[i]) 
                } catch (_: InterruptedException) {}
            }
        }
        Log.e(TAG, "All ${backoff.size} provision attempts failed")
        return false
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initialize" -> {
                val ok = startSdkForegroundService()
                result.success(ok)
            }

            "requestPermissions" -> {
                val activity = activityBinding?.activity
                if (activity != null) {
                    try {
                        // Check if we already have a pending permission request
                        if (pendingPermissionResult != null) {
                            Log.w(TAG, "Permission request already in progress")
                            result.success(false)
                            return
                        }
                        
                        val permissionsToRequest = mutableListOf<String>()
                        
                        // Check and request notification permission (Android 13+)
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            if (!hasPostNotificationsPermission()) {
                                permissionsToRequest.add(Manifest.permission.POST_NOTIFICATIONS)
                            }
                        }
                        
                        // Check and request Bluetooth permissions
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                            // Android 12+ Bluetooth permissions
                            if (ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_SCAN) != PackageManager.PERMISSION_GRANTED) {
                                permissionsToRequest.add(Manifest.permission.BLUETOOTH_SCAN)
                            }
                            if (ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                                permissionsToRequest.add(Manifest.permission.BLUETOOTH_CONNECT)
                            }
                        } else {
                            // Legacy Bluetooth permissions
                            if (ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH) != PackageManager.PERMISSION_GRANTED) {
                                permissionsToRequest.add(Manifest.permission.BLUETOOTH)
                            }
                            if (ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_ADMIN) != PackageManager.PERMISSION_GRANTED) {
                                permissionsToRequest.add(Manifest.permission.BLUETOOTH_ADMIN)
                            }
                        }
                        
                        // Check and request location permissions
                        if (ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                            permissionsToRequest.add(Manifest.permission.ACCESS_FINE_LOCATION)
                        }
                        if (ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                            permissionsToRequest.add(Manifest.permission.ACCESS_COARSE_LOCATION)
                        }
                        
                        if (permissionsToRequest.isNotEmpty()) {
                            Log.d(TAG, "Requesting permissions: ${permissionsToRequest.joinToString(", ")}")
                            // Store the result callback to be called when permissions are granted/denied
                            pendingPermissionResult = result
                            ActivityCompat.requestPermissions(
                                activity,
                                permissionsToRequest.toTypedArray(),
                                PERMISSION_REQUEST_CODE
                            )
                            // Don't call result.success() here - wait for onRequestPermissionsResult
                        } else {
                            Log.d(TAG, "All required permissions already granted")
                            result.success(true)
                        }
                    } catch (e: Exception) {
                        Log.e(TAG, "Failed to request permissions: ${e.message}", e)
                        pendingPermissionResult = null
                        result.success(false)
                    }
                } else {
                    Log.w(TAG, "No activity available to request permissions")
                    result.success(false)
                }
            }

            "getPermissionStatus" -> {
                val notificationsOn = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    hasPostNotificationsPermission()
                } else {
                    val nm = ContextCompat.getSystemService(context, NotificationManager::class.java)
                    nm?.areNotificationsEnabled() ?: true
                }

                // Check if Bluetooth is enabled AND permissions are granted
                val btOn = try {
                    val bluetoothEnabled = BluetoothAdapter.getDefaultAdapter()?.isEnabled ?: false
                    val bluetoothPermissionsGranted = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                        // Android 12+ permissions
                        ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_SCAN) == PackageManager.PERMISSION_GRANTED &&
                        ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_CONNECT) == PackageManager.PERMISSION_GRANTED
                    } else {
                        // Legacy permissions
                        ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH) == PackageManager.PERMISSION_GRANTED &&
                        ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_ADMIN) == PackageManager.PERMISSION_GRANTED
                    }
                    bluetoothEnabled && bluetoothPermissionsGranted
                } catch (_: Exception) { false }

                // Check if location is enabled AND permissions are granted
                val locationOn = try {
                    val lm = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
                    val locationEnabled = lm.isProviderEnabled(LocationManager.GPS_PROVIDER) || lm.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
                    val locationPermissionsGranted = ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED ||
                                                   ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED
                    locationEnabled && locationPermissionsGranted
                } catch (_: Exception) { false }

                Log.d(TAG, "Permission status - Bluetooth: $btOn, Location: $locationOn, Notifications: $notificationsOn")

                result.success(
                    mapOf(
                        "btOn" to btOn,
                        "locationOn" to locationOn,
                        "notificationsOn" to notificationsOn,
                        "baseOk" to (btOn && locationOn && notificationsOn),
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
                    "getAvailableMethods",
                    "promptEnableBluetooth",
                    "openLocationSettings",
                    "getServiceStatus",
                    "getServiceReadiness",
                    "getSDKVersion",
                    "getBluetoothStatus",
                    "getLocationStatus",
                    "testBluetoothScanning",
                    "triggerTestEvent"
                ))
            }

            "getServiceStatus" -> {
                try {
                    val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
                    val isServiceRunning = activityManager.getRunningServices(Integer.MAX_VALUE)
                        .any { it.service.className == "com.openpath.mobileaccesscore.OpenpathForegroundService" }
                    
                    result.success(mapOf(
                        "isRunning" to isServiceRunning,
                        "isBound" to serviceBound,
                        "hasServiceInstance" to (serviceInstance != null),
                        "foregroundServiceStarted" to foregroundServiceStarted,
                        "serviceClassName" to "com.openpath.mobileaccesscore.OpenpathForegroundService"
                    ))
                } catch (e: Exception) {
                    result.success(mapOf(
                        "error" to e.message,
                        "isRunning" to false,
                        "isBound" to false,
                        "hasServiceInstance" to false
                    ))
                }
            }

            "getServiceReadiness" -> {
                try {
                    synchronized(serviceReadyLock) {
                        val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
                        val isServiceRunning = activityManager.getRunningServices(Integer.MAX_VALUE)
                            .any { it.service.className == "com.openpath.mobileaccesscore.OpenpathForegroundService" }
                        
                        result.success(mapOf(
                            "isReady" to serviceReady,
                            "isRunning" to isServiceRunning,
                            "isBound" to serviceBound,
                            "hasServiceInstance" to (serviceInstance != null),
                            "foregroundServiceStarted" to foregroundServiceStarted,
                            "pendingCallbacks" to serviceReadyCallbacks.size,
                            "timestamp" to System.currentTimeMillis()
                        ))
                    }
                } catch (e: Exception) {
                    result.success(mapOf(
                        "error" to e.message,
                        "isReady" to false,
                        "isRunning" to false,
                        "isBound" to false,
                        "hasServiceInstance" to false
                    ))
                }
            }

            "getSDKVersion" -> {
                try {
                    val core = OpenpathMobileAccessCore.getInstance()
                    
                    // Try to get version information from the SDK
                    var versionInfo = mutableMapOf<String, Any>()
                    
                    try {
                        val versionMethod = core.javaClass.getMethod("getVersion")
                        val version = versionMethod.invoke(core)
                        versionInfo["version"] = version ?: "unknown"
                    } catch (e: NoSuchMethodException) {
                        versionInfo["version"] = "method_not_available"
                    } catch (e: Exception) {
                        versionInfo["version"] = "error: ${e.message}"
                    }
                    
                    try {
                        val buildMethod = core.javaClass.getMethod("getBuildInfo")
                        val buildInfo = buildMethod.invoke(core)
                        versionInfo["buildInfo"] = buildInfo ?: "unknown"
                    } catch (e: NoSuchMethodException) {
                        versionInfo["buildInfo"] = "method_not_available"
                    } catch (e: Exception) {
                        versionInfo["buildInfo"] = "error: ${e.message}"
                    }
                    
                    // Add SDK class information
                    versionInfo["sdkClassName"] = core.javaClass.name
                    versionInfo["availableMethods"] = core.javaClass.methods.map { it.name }.distinct().sorted()
                    
                    result.success(versionInfo)
                } catch (e: Exception) {
                    result.success(mapOf(
                        "error" to e.message,
                        "sdkAvailable" to false
                    ))
                }
            }

            "getBluetoothStatus" -> {
                try {
                    val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
                    val bluetoothStatus = mutableMapOf<String, Any>()
                    
                    if (bluetoothAdapter != null) {
                        bluetoothStatus["adapterAvailable"] = true
                        bluetoothStatus["enabled"] = bluetoothAdapter.isEnabled
                        bluetoothStatus["name"] = bluetoothAdapter.name ?: "unknown"
                        bluetoothStatus["address"] = bluetoothAdapter.address ?: "unknown"
                        bluetoothStatus["state"] = bluetoothAdapter.state
                        bluetoothStatus["scanMode"] = bluetoothAdapter.scanMode
                    } else {
                        bluetoothStatus["adapterAvailable"] = false
                        bluetoothStatus["enabled"] = false
                    }
                    
                    // Check Bluetooth permissions
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                        bluetoothStatus["scanPermission"] = ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_SCAN) == PackageManager.PERMISSION_GRANTED
                        bluetoothStatus["connectPermission"] = ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_CONNECT) == PackageManager.PERMISSION_GRANTED
                    } else {
                        bluetoothStatus["bluetoothPermission"] = ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH) == PackageManager.PERMISSION_GRANTED
                        bluetoothStatus["bluetoothAdminPermission"] = ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_ADMIN) == PackageManager.PERMISSION_GRANTED
                    }
                    
                    result.success(bluetoothStatus)
                } catch (e: Exception) {
                    result.success(mapOf(
                        "error" to e.message,
                        "adapterAvailable" to false,
                        "enabled" to false
                    ))
                }
            }

            "getLocationStatus" -> {
                try {
                    val locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
                    val locationStatus = mutableMapOf<String, Any>()
                    
                    locationStatus["gpsEnabled"] = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
                    locationStatus["networkEnabled"] = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
                    locationStatus["passiveEnabled"] = locationManager.isProviderEnabled(LocationManager.PASSIVE_PROVIDER)
                    
                    val providers = locationManager.getProviders(true)
                    locationStatus["enabledProviders"] = providers
                    
                    // Check location permissions
                    locationStatus["fineLocationPermission"] = ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED
                    locationStatus["coarseLocationPermission"] = ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED
                    
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                        locationStatus["backgroundLocationPermission"] = ContextCompat.checkSelfPermission(context, Manifest.permission.ACCESS_BACKGROUND_LOCATION) == PackageManager.PERMISSION_GRANTED
                    }
                    
                    result.success(locationStatus)
                } catch (e: Exception) {
                    result.success(mapOf(
                        "error" to e.message,
                        "gpsEnabled" to false,
                        "networkEnabled" to false
                    ))
                }
            }

            "testBluetoothScanning" -> {
                try {
                    val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
                    if (bluetoothAdapter == null || !bluetoothAdapter.isEnabled) {
                        result.success(false)
                        return
                    }
                    
                    // Check if we have the required permissions for Bluetooth scanning
                    val hasPermissions = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                        ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_SCAN) == PackageManager.PERMISSION_GRANTED
                    } else {
                        ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH) == PackageManager.PERMISSION_GRANTED &&
                        ContextCompat.checkSelfPermission(context, Manifest.permission.BLUETOOTH_ADMIN) == PackageManager.PERMISSION_GRANTED
                    }
                    
                    if (!hasPermissions) {
                        result.success(false)
                        return
                    }
                    
                    // Test if we can start discovery (this is a basic capability test)
                    val canStartDiscovery = bluetoothAdapter.isDiscovering || bluetoothAdapter.startDiscovery()
                    if (bluetoothAdapter.isDiscovering) {
                        bluetoothAdapter.cancelDiscovery() // Clean up
                    }
                    
                    result.success(canStartDiscovery)
                } catch (e: Exception) {
                    Log.w(TAG, "Bluetooth scanning test failed: ${e.message}")
                    result.success(false)
                }
            }

            "triggerTestEvent" -> {
                try {
                    // Test the threading fixes by emitting events from a background thread
                    backgroundExecutor.execute {
                        Log.d(TAG, "Test event triggered from Flutter - running on background thread")
                        emitEvent("test_event", mapOf("timestamp" to System.currentTimeMillis(), "thread" to Thread.currentThread().name))
                        emitProvisionStatus(true, "Test event from background thread")
                    }
                    result.success(true)
                } catch (e: Exception) {
                    Log.e(TAG, "Test event failed: ${e.message}", e)
                    result.success(false)
                }
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

                // Use the new service ready signal instead of the legacy method
                whenServiceReady {
                    // This is already running in background executor from whenServiceStarted
                    try {
                        val ok = provisionWithRetries(jwt, opal)
                        
                        // Ensure result callbacks happen on the main UI thread
                        mainHandler.post {
                            if (ok) {
                                emitEvent("provision_success", mapOf("opal" to opal))
                                emitProvisionStatus(true, "Provision request accepted")
                                result.success(true)
                            } else {
                                emitEvent("provision_failed", mapOf("error" to "Provision failed after retries"))
                                emitProvisionStatus(false, "Provision failed after retries")
                                result.error("provision_error", "Provision failed after retries", null)
                            }
                        }
                    } catch (e: Exception) {
                        Log.e(TAG, "Provision error: ${e.message}", e)
                        
                        // Ensure error callbacks happen on the main UI thread
                        mainHandler.post {
                            emitEvent("provision_failed", mapOf("error" to (e.message ?: "unknown")))
                            emitProvisionStatus(false, e.message ?: "Provision error")
                            result.error("provision_error", e.message, null)
                        }
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

            "promptEnableBluetooth" -> {
                try {
                    val bluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
                    if (bluetoothAdapter != null && !bluetoothAdapter.isEnabled) {
                        val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                        enableBtIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        context.startActivity(enableBtIntent)
                    }
                    result.success(null)
                } catch (e: Exception) {
                    Log.w(TAG, "Failed to prompt enable Bluetooth: ${e.message}")
                    result.success(null)
                }
            }

            "openLocationSettings" -> {
                try {
                    val intent = Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    context.startActivity(intent)
                    result.success(null)
                } catch (e: Exception) {
                    Log.w(TAG, "Failed to open location settings: ${e.message}")
                    result.success(null)
                }
            }

            else -> result.notImplemented()
        }
    }

    // Handle permission request results
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ): Boolean {
        if (requestCode == PERMISSION_REQUEST_CODE && pendingPermissionResult != null) {
            try {
                // Check if all requested permissions were granted
                val allGranted = grantResults.isNotEmpty() && grantResults.all { it == PackageManager.PERMISSION_GRANTED }
                
                Log.d(TAG, "Permission result - All granted: $allGranted")
                for (i in permissions.indices) {
                    val permission = permissions[i]
                    val granted = if (i < grantResults.size) grantResults[i] == PackageManager.PERMISSION_GRANTED else false
                    Log.d(TAG, "Permission $permission: $granted")
                }
                
                // Call the pending result with the outcome
                pendingPermissionResult?.success(allGranted)
                pendingPermissionResult = null
                return true
            } catch (e: Exception) {
                Log.e(TAG, "Error handling permission result: ${e.message}", e)
                pendingPermissionResult?.success(false)
                pendingPermissionResult = null
                return false
            }
        }
        return false
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
        
        // Clear any pending permission result
        pendingPermissionResult = null
        
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
        eventSink = sink
        sink?.success(mapOf("event" to "ready", "data" to "Openpath stream connected"))
    }

    override fun onCancel(args: Any?) { eventSink = null }

    // ActivityAware
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activityBinding = binding
        binding.addRequestPermissionsResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.activityBinding?.removeRequestPermissionsResultListener(this)
        this.activityBinding = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.activityBinding = binding
        binding.addRequestPermissionsResultListener(this)
    }

    override fun onDetachedFromActivity() {
        this.activityBinding?.removeRequestPermissionsResultListener(this)
        this.activityBinding = null
        // Clear any pending permission result
        pendingPermissionResult = null
    }
}
