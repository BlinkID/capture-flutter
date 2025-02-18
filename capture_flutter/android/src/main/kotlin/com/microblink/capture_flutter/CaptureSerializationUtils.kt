package com.microblink.capture_flutter

import android.content.Context
import android.graphics.Bitmap
import com.microblink.capture.result.AnalyzerResult
import com.microblink.capture.settings.AnalyzerSettings
import com.microblink.capture.settings.CameraSettings
import com.microblink.capture.settings.CaptureSettings
import com.microblink.capture.settings.UxSettings
import org.json.JSONObject
import java.io.ByteArrayOutputStream
import android.util.Base64
import com.microblink.capture.CaptureSDK
import com.microblink.capture.licence.exception.LicenceKeyException
import com.microblink.capture.settings.BlurPolicy
import com.microblink.capture.settings.CaptureStrategy
import com.microblink.capture.settings.EnforcedDocumentGroup
import com.microblink.capture.settings.GlarePolicy
import com.microblink.capture.settings.LightingThresholds
import com.microblink.capture.settings.TiltPolicy

class CaptureSerializationUtils {
    fun serializeCaptureResult(analyzerResult: AnalyzerResult): JSONObject {
        val jsonAnalyzerResult = JSONObject()

        val jsonFirstSideResult = JSONObject()
        jsonFirstSideResult.put("nativeCapturedImage", encodeBase64Image(analyzerResult.firstCapture?.imageResult?.image?.convertToBitmap()))
        jsonFirstSideResult.put("nativeTransformedImage", encodeBase64Image(analyzerResult.firstCapture?.transformedImageResult?.image?.convertToBitmap()))
        jsonFirstSideResult.put("nativeSide", analyzerResult.firstCapture?.side?.ordinal)
        jsonFirstSideResult.put("nativeDpiAdjusted", analyzerResult.firstCapture?.dpiAdjusted)
        jsonAnalyzerResult.put("nativeFirstCapture", jsonFirstSideResult)

        val jsonSecondSideResult = JSONObject()
        jsonSecondSideResult.put("nativeCapturedImage", encodeBase64Image(analyzerResult.secondCapture?.imageResult?.image?.convertToBitmap()))
        jsonSecondSideResult.put("nativeTransformedImage", encodeBase64Image(analyzerResult.secondCapture?.transformedImageResult?.image?.convertToBitmap()))
        jsonSecondSideResult.put("nativeSide", analyzerResult.secondCapture?.side?.ordinal)
        jsonSecondSideResult.put("nativeDpiAdjusted", analyzerResult.secondCapture?.dpiAdjusted)
        jsonAnalyzerResult.put("nativeSecondCapture", jsonSecondSideResult)

        jsonAnalyzerResult.put("nativeDocumentGroup", analyzerResult.documentGroup.ordinal)
        jsonAnalyzerResult.put("nativeCompletnessStatus", analyzerResult.completenessStatus.ordinal)
        return jsonAnalyzerResult
    }

    fun deserializeCaptureSettings(jsonCaptureSettings: JSONObject): CaptureSettings {
        val jsonAnalyzerSettings = jsonCaptureSettings.getJSONObject("analyzerSettings")
        val jsonUxSettings = jsonCaptureSettings.getJSONObject("uxSettings")
        val jsonCameraSettings = jsonCaptureSettings.getJSONObject("cameraSettings")

        return CaptureSettings(
            analyzerSettings = AnalyzerSettings(
                adjustMinimumDocumentDpi = jsonAnalyzerSettings.optBoolean("adjustMinimumDocumentDpi"),
                blurPolicy = BlurPolicy.values()[jsonAnalyzerSettings.optInt("blurPolicy")],
                captureStrategy = CaptureStrategy.values()[jsonAnalyzerSettings.optInt("captureStrategy")],
                captureSingleSide = jsonAnalyzerSettings.optBoolean("captureSingleSide"),
                documentFramingMargin = jsonAnalyzerSettings.optDouble("documentFramingMargin").toFloat(),
                enforcedDocumentGroup = EnforcedDocumentGroup.values()[jsonAnalyzerSettings.optInt("enforcedDocumentGroup")],
                glarePolicy = GlarePolicy.values()[jsonAnalyzerSettings.optInt("glarePolicy")],
                handOcclusionThreshold = jsonAnalyzerSettings.optDouble("handOcclusionThreshold").toFloat(),
                keepDpiOnTransformedDocumentImage = jsonAnalyzerSettings.optBoolean("keepDpiOnTransformedDocumentImage"),
                keepMarginOnTransformedDocumentImage = jsonCaptureSettings.optBoolean("keepMarginOnTransformedDocumentImage"),
                lightingThresholds = LightingThresholds(
                    tooDarkThreshold = jsonAnalyzerSettings.optJSONObject("lightingThresholds").optDouble("tooDarkTreshold").toFloat(),
                    tooBrightThreshold = jsonAnalyzerSettings.optJSONObject("lightingThresholds").optDouble("tooBrightThreshold").toFloat(),
                ),
                minimumDocumentDpi = jsonAnalyzerSettings.optInt("minimumDocumentDpi"),
                returnTransformedDocumentImage = jsonAnalyzerSettings.optBoolean("returnTransformedDocumentImage"),
                tiltPolicy = TiltPolicy.values()[jsonAnalyzerSettings.optInt("tiltPolicy")]
            ),
            uxSettings = UxSettings(
                showHelpTooltipTimeIntervalMs = jsonUxSettings.optDouble("showHelpTooltipTimeIntervalMs").toLong(),
                showIntroductionDialog = jsonUxSettings.optBoolean("showIntroductionDialog"),
                showOnboardingInfo = jsonUxSettings.optBoolean("showOnboardingInfo"),
                sideCaptureTimeoutMs = jsonUxSettings.optDouble("sideCaptureTimeoutMs").toLong()
            ),
            cameraSettings = CameraSettings(
                resolution = CameraSettings.Resolution.values()[jsonCameraSettings.optInt("resolution")],
            )
        )
    }

    @Throws(LicenceKeyException::class)
    fun deserializeCaptureLicenseKey(jsonLicenseKey: Map<String, Any>?, context: Context) {
        val licenseKey = jsonLicenseKey?.get("licenseKey") as? String
        licenseKey?.let {
            try {
                CaptureSDK.setLicenseKey(it, context)
            } catch (error: LicenceKeyException) {
                throw error
            }
        }
    }

    private fun encodeBase64Image(image: Bitmap?): String? {
        return image?.let {
            val outputStream = ByteArrayOutputStream()
            it.compress(Bitmap.CompressFormat.JPEG, 90, outputStream)
            Base64.encodeToString(outputStream.toByteArray(), Base64.DEFAULT)
        }
    }
}