package com.microblink.capture.flutter

import android.content.Intent
import android.os.Bundle
import androidx.activity.ComponentActivity
import com.microblink.capture.result.AnalyzerResult
import com.microblink.capture.result.CaptureResult
import com.microblink.capture.result.contract.MbCapture
import org.json.JSONObject

class CaptureActivity : ComponentActivity() {

    private val captureLauncher =
        registerForActivityResult(MbCapture()) { captureResult ->
            when (captureResult.status) {
                CaptureResult.Status.DOCUMENT_CAPTURED -> {
                    captureResult.analyzerResult?.let { analyzerResult ->
                        CaptureResultHolder.analyzerResult = analyzerResult
                        setResult(RESULT_OK)
                        finish()
                    }
                }
                CaptureResult.Status.CANCELLED -> {
                    setResult(RESULT_CANCELED)
                    finish()
                }
                CaptureResult.Status.ERROR_LICENCE_CHECK,
                CaptureResult.Status.ERROR_ANALYZER_SETTINGS_UNSUITABLE-> {
                    setResult(RESULT_CANCELED, Intent().apply {
                        putExtra("captureError", "Capture finished with status: ${captureResult.status}")
                    })
                    finish()
                }
            }
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        startScanning(intent.getStringExtra("captureSettings"))
    }

    private fun startScanning(captureSettings: String?) {
        captureSettings?.let { settings ->
            captureLauncher.launch(CaptureSerializationUtils().deserializeCaptureSettings(JSONObject(settings)))
        }
    }
}

object CaptureResultHolder {
    var analyzerResult: AnalyzerResult? = null
}