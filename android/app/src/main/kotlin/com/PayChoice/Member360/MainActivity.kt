package com.PayChoice.Member360

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import android.content.Intent

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // سجّل البلجن بتاعك هنا
        flutterEngine.plugins.add(OpenpathPlugin())
    }
}
