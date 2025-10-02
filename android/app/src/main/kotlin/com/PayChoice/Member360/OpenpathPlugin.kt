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
                        val initSuccess = initializeSdkWithService()
                        if (!initSuccess) {
                            Log.w(TAG, "Failed to initialize SDK with service instance")
                        }
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
        }
        
        override fun onServiceDisconnected(name: ComponentName?) {
            Log.d(TAG, "Service disconnected: $name")
            serviceBound = false
            serviceInstance = null
        }
    }
    
    // Initialize SDK with service reference
    private fun initializeSdkWithService(): Boolean {
        try {
            val core = OpenpathMobileAccessCore.getInstance()
            
            // Try different methods to set the service reference
            if (serviceInstance != null) {
                try {
                    // Try the most likely method first - setForegroundService
                    val setServiceMethod = core.javaClass.getMethod("setForegroundService", com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
                    setServiceMethod.invoke(core, serviceInstance)
                    Log.d(TAG, "Successfully set foreground service reference in SDK")
                    return true
                } catch (e: NoSuchMethodException) {
                    // Try alternative method names
                    try {
                        val setServiceMethod = core.javaClass.getMethod("setService", com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
                        setServiceMethod.invoke(core, serviceInstance)
                        Log.d(TAG, "Successfully set service reference in SDK using setService")
                        return true
                    } catch (e2: NoSuchMethodException) {
                        // Try with init method that takes service
                        try {
                            val initMethod = core.javaClass.getMethod("init", com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
                            initMethod.invoke(core, serviceInstance)
                            Log.d(TAG, "Successfully initialized SDK with service using init")
                            return true
                        } catch (e3: NoSuchMethodException) {
                            // Try with initialize method that takes service
                            try {
                                val initializeMethod = core.javaClass.getMethod("initialize", com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
                                initializeMethod.invoke(core, serviceInstance)
                                Log.d(TAG, "Successfully initialized SDK with service using initialize")
                                return true
                            } catch (e4: NoSuchMethodException) {
                                Log.w(TAG, "SDK doesn't have expected service setter methods")
                            }
                        }
                    }
                }
            } else {
                Log.w(TAG, "Service instance is null, cannot initialize SDK with service")
            }
        } catch (e: Exception) {
            Log.w(TAG, "Failed to initialize SDK with service: ${e.message}")
        }
        return false
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

    // Check if SDK is properly initialized with service reference
    private fun isSdkInitialized(): Boolean {
        try {
            val core = OpenpathMobileAccessCore.getInstance()
            
            // Try to check if the SDK has a service reference
            try {
                val serviceField = core.javaClass.getDeclaredField("foregroundService")
                serviceField.isAccessible = true
                val serviceRef = serviceField.get(core)
                return serviceRef != null
            } catch (e: NoSuchFieldException) {
                try {
                    val serviceField = core.javaClass.getDeclaredField("service")
                    serviceField.isAccessible = true
                    val serviceRef = serviceField.get(core)
                    return serviceRef != null
                } catch (e2: NoSuchFieldException) {
                    // If we can't check the field, assume it's initialized if we have a service instance
                    return serviceInstance != null && serviceBound
                }
            }
        } catch (e: Exception) {
            Log.w(TAG, "Failed to check SDK initialization status: ${e.message}")
            return false
        }
    }

    // Enhanced service readiness check with SDK initialization verification
    private fun whenServiceStarted(onReady: () -> Unit) {
        // Give additional time for service to fully initialize
        backgroundExecutor.execute {
            try {
                var attempts = 0
                val maxAttempts = 5
                
                while (attempts < maxAttempts) {
                    Thread.sleep(1000) // Wait for service to be fully ready
                    
                    // Verify service is running before proceeding
                    val activityManager = context.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
                    val isServiceRunning = activityManager.getRunningServices(Integer.MAX_VALUE)
                        .any { it.service.className == "com.openpath.mobileaccesscore.OpenpathForegroundService" }
                    
                    if (isServiceRunning && serviceBound) {
                        Log.d(TAG, "Service verified as running and bound, checking SDK initialization")
                        
                        // Check if SDK is properly initialized
                        if (isSdkInitialized()) {
                            Log.d(TAG, "SDK is properly initialized, proceeding with operation")
                            onReady()
                            return@execute
                        } else {
                            Log.w(TAG, "SDK not properly initialized, attempting to initialize")
                            if (serviceInstance != null) {
                                val initSuccess = initializeSdkWithService()
                                if (initSuccess) {
                                    Log.d(TAG, "Successfully initialized SDK, proceeding")
                                    onReady()
                                    return@execute
                                }
                            }
                        }
                    } else if (!isServiceRunning) {
                        Log.w(TAG, "Service not running, attempting restart")
                        startSdkForegroundService()
                        Thread.sleep(2000) // Give more time after restart
                    } else if (!serviceBound) {
                        Log.w(TAG, "Service running but not bound, attempting to bind")
                        val serviceIntent = Intent(context, com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
                        context.bindService(serviceIntent, serviceConnection, Context.BIND_AUTO_CREATE or Context.BIND_IMPORTANT)
                        Thread.sleep(1500)
                    }
                    
                    attempts++
                }
                
                Log.w(TAG, "Service readiness check completed after $maxAttempts attempts, proceeding anyway")
                onReady()
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
                    // Trigger a test event through the event channel
                    // This would normally be done through the event sink, but for testing we'll just log it
                    Log.d(TAG, "Test event triggered from Flutter")
                    result.success(true)
                } catch (e: Exception) {
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
                                
                                // Try multiple initialization approaches with proper error checking
                                var sdkInitialized = false
                                
                                // Approach 1: Use service instance if available
                                if (serviceBound && serviceInstance != null) {
                                    Log.d(TAG, "Using bound service instance for SDK initialization")
                                    sdkInitialized = initializeSdkWithService()
                                    if (sdkInitialized) {
                                        Log.d(TAG, "Successfully initialized SDK with service instance")
                                    } else {
                                        Log.w(TAG, "Failed to initialize SDK with service instance")
                                    }
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
                                        Thread.sleep(2000) // Wait longer for binding
                                        
                                        if (serviceBound && serviceInstance != null) {
                                            sdkInitialized = initializeSdkWithService()
                                            if (sdkInitialized) {
                                                Log.d(TAG, "Successfully initialized SDK after rebinding service")
                                            }
                                        }
                                    } catch (e: Exception) {
                                        Log.w(TAG, "Failed to rebind service: ${e.message}")
                                    }
                                }
                                
                                // Approach 5: Try to manually set service reference using reflection
                                if (!sdkInitialized) {
                                    Log.w(TAG, "Attempting manual service reference setup")
                                    try {
                                        // Try to find and set the service field directly
                                        val serviceField = core.javaClass.getDeclaredField("foregroundService")
                                        serviceField.isAccessible = true
                                        serviceField.set(core, serviceInstance)
                                        Log.d(TAG, "Manually set foreground service field")
                                        sdkInitialized = true
                                    } catch (e: NoSuchFieldException) {
                                        try {
                                            val serviceField = core.javaClass.getDeclaredField("service")
                                            serviceField.isAccessible = true
                                            serviceField.set(core, serviceInstance)
                                            Log.d(TAG, "Manually set service field")
                                            sdkInitialized = true
                                        } catch (e2: NoSuchFieldException) {
                                            Log.w(TAG, "Could not find service field to set manually")
                                        } catch (e2: Exception) {
                                            Log.w(TAG, "Failed to set service field manually: ${e2.message}")
                                        }
                                    } catch (e: Exception) {
                                        Log.w(TAG, "Failed to set foreground service field manually: ${e.message}")
                                    }
                                }
                                
                                if (!sdkInitialized) {
                                    Log.w(TAG, "All SDK initialization approaches failed, proceeding anyway")
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
                                
                                // Log SDK state before provision attempt
                                try {
                                    Log.d(TAG, "SDK initialization status: ${isSdkInitialized()}")
                                    Log.d(TAG, "Service bound: $serviceBound, Service instance: ${serviceInstance != null}")
                                } catch (e: Exception) {
                                    Log.w(TAG, "Failed to log SDK state: ${e.message}")
                                }
                                
                                // Try provision with different parameter combinations
                                var provisionSuccess = false
                                var lastProvisionError: Exception? = null
                                
                                try {
                                    // First try with both parameters
                                    Log.d(TAG, "Attempting provision with both JWT and OPAL parameters")
                                    core.provision(jwt, opal)
                                    provisionSuccess = true
                                    Log.d(TAG, "Provision successful with both parameters")
                                } catch (e: Exception) {
                                    lastProvisionError = e
                                    Log.w(TAG, "Provision with both params failed: ${e.message}")
                                    
                                    // Some SDKs might expect null as second parameter instead of omitting it
                                    try {
                                        Log.d(TAG, "Attempting provision with JWT and null OPAL")
                                        core.provision(jwt, null)
                                        provisionSuccess = true
                                        Log.d(TAG, "Provision successful with null OPAL")
                                    } catch (e2: Exception) {
                                        lastProvisionError = e2
                                        Log.w(TAG, "Provision with null opal failed: ${e2.message}")
                                        
                                        // Try with empty string as fallback
                                        try {
                                            Log.d(TAG, "Attempting provision with JWT and empty OPAL")
                                            core.provision(jwt, "")
                                            provisionSuccess = true
                                            Log.d(TAG, "Provision successful with empty OPAL")
                                        } catch (e3: Exception) {
                                            lastProvisionError = e3
                                            Log.w(TAG, "Provision with empty opal failed: ${e3.message}")
                                            
                                            // Try with just JWT (single parameter)
                                            try {
                                                Log.d(TAG, "Attempting provision with JWT only")
                                                val singleParamMethod = core.javaClass.getMethod("provision", String::class.java)
                                                singleParamMethod.invoke(core, jwt)
                                                provisionSuccess = true
                                                Log.d(TAG, "Provision successful with JWT only")
                                            } catch (e4: Exception) {
                                                lastProvisionError = e4
                                                Log.w(TAG, "Provision with JWT only failed: ${e4.message}")
                                            }
                                        }
                                    }
                                }
                                
                                if (!provisionSuccess) {
                                    throw lastProvisionError ?: Exception("All provision attempts failed")
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
        sink?.success(mapOf("event" to "ready", "data" to "Openpath stream connected"))
    }

    override fun onCancel(args: Any?) { }

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
