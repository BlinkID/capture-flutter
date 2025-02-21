package com.microblink.capture.flutter

import android.app.Activity
import android.content.Context
import android.content.Intent
import com.microblink.capture.licence.exception.LicenceKeyException
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener

/** CaptureFlutterPlugin */
class CaptureFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, ActivityResultListener {
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
      val args = call.arguments as? Map<*, *>
      val licenseMap = args?.get("license") as? Map<String, Any>
      val captureSettings = args?.get("captureSettings") as? Map<String, Any>

      CaptureSerializationUtils().deserializeCaptureLicenseKey(licenseMap, activity as Context)
      activity?.let { it ->
        val intent = Intent(it, CaptureActivity::class.java).apply {
          captureSettings?.let {
            putExtra("captureSettings", it.toString())
          } ?: result?.error(CAPTURE_ANDROID_ERROR, "Incorrectly set Capture Settings!", null)
        }
        it.startActivityForResult(intent, CAPTURE_REQUEST_CODE)
      } ?: result?.error(CAPTURE_ANDROID_ERROR, "Activity is null", null)
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
      when (resultCode) {
        Activity.RESULT_OK -> {
          val jsonResult = CaptureResultHolder.analyzerResult
          CaptureResultHolder.analyzerResult = null

          if (jsonResult != null) {
            val results = CaptureSerializationUtils().serializeCaptureResult(jsonResult)
            val jsonString = results.toString()
            result?.success(jsonString)
          }
        }

        Activity.RESULT_CANCELED -> {
          val errorData = data?.getStringExtra("captureError")
          errorData?.let {
            result?.error(CAPTURE_ANDROID_ERROR, errorData.toString(), null)
          } ?: result?.error(CAPTURE_ANDROID_ERROR, "Capture canceled", null)
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
    private const val CAPTURE_REQUEST_CODE = 1001
    private const val CAPTURE_ANDROID_ERROR = "CaptureAndroidError"
    private const val CAPTURE_ANDROID_LICENSE_ERROR = "CaptureAndroidLicenseError"
  }
}
