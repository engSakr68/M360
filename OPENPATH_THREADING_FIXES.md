# OpenPath SDK Threading Fixes

## Issues Identified

Based on the Flutter logs provided, two main threading issues were identified in the OpenPath Android plugin:

1. **UI Thread Violation**: Methods marked with `@UiThread` were being called from background threads (`pool-14-thread-1`)
2. **Foreground Service Null Reference**: The SDK was attempting to access the foreground service before it was properly initialized

## Fixes Implemented

### 1. Threading Issue Resolution

**Problem**: Event emission and method channel calls were happening directly from background threads, causing UI thread violations.

**Solution**: Modified `emitEvent()` and `emitProvisionStatus()` methods to use `mainHandler.post()` to ensure all UI operations happen on the main thread:

```kotlin
private fun emitEvent(name: String, data: Any?) {
    try {
        // Ensure event emission happens on the main UI thread
        mainHandler.post {
            try {
                eventSink?.success(mapOf("event" to name, "data" to data))
            } catch (e: Exception) {
                Log.w(TAG, "Failed to emit event ${name} on UI thread: ${e.message}")
            }
        }
    } catch (e: Exception) {
        Log.w(TAG, "Failed to post event ${name} to UI thread: ${e.message}")
    }
}
```

### 2. Provision Result Callbacks

**Problem**: Result callbacks from the provision method were being called from background threads.

**Solution**: Wrapped all result callbacks in `mainHandler.post()` blocks:

```kotlin
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
```

### 3. Enhanced Service Management

**Problem**: The foreground service was null when the SDK tried to access it.

**Solution**: Improved service initialization and retry logic:

- Enhanced service readiness checks with multiple attempts
- Better service verification before provision attempts
- Automatic service restart on null reference errors
- More robust service binding and initialization

```kotlin
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
```

### 4. Service Readiness Enhancement

**Problem**: Service readiness checks were not robust enough.

**Solution**: Implemented multi-attempt service readiness verification:

```kotlin
private fun whenServiceStarted(onReady: () -> Unit) {
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
```

## Expected Results

With these fixes, the following improvements should be observed:

1. **No More UI Thread Violations**: All event emissions and method channel calls now properly execute on the main UI thread
2. **Reduced Service Null Errors**: Enhanced service management should minimize "foreground service is null" errors
3. **Better Retry Logic**: More robust retry mechanism with proper service verification
4. **Improved Logging**: Better diagnostic information for troubleshooting

## Testing

A test method was added to verify the threading fixes:

```kotlin
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
```

## Files Modified

- `/workspace/android/app/src/main/kotlin/com/PayChoice/Member360/OpenpathPlugin.kt`

## Next Steps

1. Build and test the application
2. Monitor logs for the absence of UI thread violation warnings
3. Verify that provisioning completes successfully without service null errors
4. Test the `triggerTestEvent` method to confirm threading fixes work correctly