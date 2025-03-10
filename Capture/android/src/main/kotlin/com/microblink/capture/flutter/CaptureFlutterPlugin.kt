package com.microblink.capture.flutter

import android.app.Activity
import android.content.Intent
import com.microblink.capture.licence.exception.LicenceKeyException
import com.microblink.capture.result.CaptureResult
import com.microblink.capture.result.contract.MbCapture
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener
import org.json.JSONObject

/** CaptureFlutterPlugin */
class CaptureFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    ActivityResultListener {
    private lateinit var channel: MethodChannel
    private var activity: Activity? = null
    private var result: Result? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "capture_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "scanWithCamera") {
            this.result = result
            startCaptureActivity(call)
        } else {
            result.notImplemented()
        }
    }

    private fun startCaptureActivity(call: MethodCall) {
        try {
            val licenseMap = call.argument<Map<String, String>>("license")
            val captureSettings = call.argument<Map<String, String>>("captureSettings")

            activity?.let {
                CaptureSerializationUtils.deserializeCaptureLicenseKey(licenseMap, it)
                captureSettings?.let { settings ->
                    val intent = MbCapture().createIntent(
                        it,
                        CaptureSerializationUtils.deserializeCaptureSettings(JSONObject(settings))
                    )
                    it.startActivityForResult(intent, CAPTURE_REQUEST_CODE)
                } ?: result?.error(CAPTURE_ANDROID_ERROR, "Activity is empty", null)
            }
        } catch (error: Exception) {
            when (error) {
                is LicenceKeyException -> {
                    result?.error(CAPTURE_ANDROID_LICENSE_ERROR, error.message, null)
                }

                else -> {
                    result?.error(CAPTURE_ANDROID_ERROR, error.message, null)
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == CAPTURE_REQUEST_CODE) {

            val captureResult = MbCapture().parseResult(resultCode, data)
            when (captureResult.status) {

                CaptureResult.Status.DOCUMENT_CAPTURED -> {
                    captureResult.analyzerResult?.let { analyzerResult ->
                        val jsonAnalyzerResult =
                            CaptureSerializationUtils.serializeCaptureResult(analyzerResult)
                        result?.success(jsonAnalyzerResult.toString())
                    } ?: result?.error(
                        CAPTURE_ANDROID_ERROR,
                        "Analyzer Result is empty",
                        null
                    )
                }

                CaptureResult.Status.CANCELLED -> {
                    result?.error(CAPTURE_ANDROID_ERROR, "Capture canceled", null)
                }

                CaptureResult.Status.ERROR_LICENCE_CHECK -> {
                    result?.error(
                        CAPTURE_ANDROID_ERROR,
                        "Error with license key check",
                        null
                    )
                }

                CaptureResult.Status.ERROR_ANALYZER_SETTINGS_UNSUITABLE -> {
                    result?.error(
                        CAPTURE_ANDROID_ERROR,
                        "Error with analyzer settings",
                        null
                    )
                }
            }
        }
        return true
    }


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener { requestCode, resultCode, data ->
            onActivityResult(requestCode, resultCode, data)
            true
        }
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    companion object {
        private const val CAPTURE_REQUEST_CODE = 1430
        private const val CAPTURE_ANDROID_ERROR = "CaptureAndroidError"
        private const val CAPTURE_ANDROID_LICENSE_ERROR = "CaptureAndroidLicenseError"
    }
}
