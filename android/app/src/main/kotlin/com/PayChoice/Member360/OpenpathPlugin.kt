package com.PayChoice.Member360

import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.Looper
import android.util.Log
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

    // Start SDK Foreground Service
    private fun startSdkForegroundService() {
        try {
            val intent = Intent(context, com.openpath.mobileaccesscore.OpenpathForegroundService::class.java)
            ContextCompat.startForegroundService(context, intent)
            Log.d(TAG, "ForegroundService started")
        } catch (e: Exception) {
            Log.e(TAG, "Failed to start ForegroundService: ${e.message}", e)
        }
    }

    // Wait for SDK service to be ready
    private fun waitForServiceReady(onReady: () -> Unit, onTimeout: () -> Unit) {
        val handler = Handler(Looper.getMainLooper())
        var retries = 0

        fun checkServiceReady() {
            retries++
            try {
                val core = OpenpathMobileAccessCore.getInstance()
                if (core.isServiceReady()) {  // محاولة التحقق من الجاهزية
                    Log.d(TAG, "SDK service is ready (try $retries)")
                    onReady()
                    return
                }
            } catch (e: Exception) {
                Log.d(TAG, "SDK service not ready yet (try $retries): ${e.message}")
            }

            if (retries < 10) {
                handler.postDelayed({ checkServiceReady() }, 500)
            } else {
                onTimeout()
            }
        }

        checkServiceReady()
    }

    // هذه الدالة تستخدم Reflection للتحقق من وجود الدالة 'initialize'
    fun checkIfMethodExists() {
        try {
            // الوصول إلى الكائن الأساسي للـ SDK
            val core = OpenpathMobileAccessCore.getInstance()

            // محاولة الوصول إلى دالة معينة باستخدام Reflection
            val method = core::class.java.getDeclaredMethod("initialize")  // تغيير اسم الدالة حسب الحاجة
            
            // إذا كانت الدالة موجودة
            method.isAccessible = true  // التأكد من الوصول إليها
            method.invoke(core)  // استدعاء الدالة
            Log.d(TAG, "Method 'initialize' exists and was invoked successfully.")
            
        } catch (e: NoSuchMethodException) {
            Log.d(TAG, "Method 'initialize' not found, checking for alternatives.")
            // إذا كانت الدالة غير موجودة، حاول البحث عن دالة بديلة أو استخدم دالة أخرى
            try {
                val alternativeMethod = core::class.java.getDeclaredMethod("alternativeInitialize")  // حاول استخدام دالة بديلة
                alternativeMethod.isAccessible = true
                alternativeMethod.invoke(core)
                Log.d(TAG, "Alternative method 'alternativeInitialize' was invoked successfully.")
            } catch (e2: NoSuchMethodException) {
                Log.e(TAG, "Alternative method not found: ${e2.message}")
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error: ${e.message}")
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initialize" -> {
                startSdkForegroundService()

                // Polling to check if the service is ready
                waitForServiceReady(
                    onReady = { result.success(true) },
                    onTimeout = { result.success(false) }
                )

                // تحقق من وجود دالة initialize
                checkIfMethodExists()
            }

            "provision" -> {
                val jwt = (call.argument<String>("jwt")?.trim() ?: "")
                val opal = (call.argument<String>("opal")?.trim() ?: "")
                if (jwt.isBlank() || opal.isBlank()) {
                    result.error("invalid_args", "Invalid JWT or OPAL", null)
                    return
                }

                startSdkForegroundService()

                waitForServiceReady(
                    onReady = {
                        val core = OpenpathMobileAccessCore.getInstance()
                        core.provision(jwt, opal)
                        result.success(true)
                    },
                    onTimeout = { result.success(false) }
                )
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
