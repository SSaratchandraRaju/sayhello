package com.vikrasoftech.sayhello

import android.app.PictureInPictureParams
import android.content.res.Configuration
import android.os.Build
import android.util.Rational
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.sayhello/pip"
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "enterPipMode" -> {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        try {
                            val params = PictureInPictureParams.Builder()
                                .setAspectRatio(Rational(9, 16)) // Portrait video ratio
                                .build()
                            enterPictureInPictureMode(params)
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("PIP_ERROR", e.message, null)
                        }
                    } else {
                        result.error("VERSION_ERROR", "PIP requires Android 8.0+", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
    
    override fun onPictureInPictureModeChanged(
        isInPictureInPictureMode: Boolean,
        newConfig: Configuration
    ) {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig)
        // You can handle UI changes here if needed
    }
}
