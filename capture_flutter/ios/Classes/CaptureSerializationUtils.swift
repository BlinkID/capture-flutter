//
//  CaptureSerializationUtils.swift
//  Pods
//
//  Created by Milan Parađina on 12.02.2025..
//

import CaptureUX

class CaptureSerializationUtils {
    static func serializeResult(_ analyzerResult: MBCCAnalyzerResult) -> String?  {
        var dict = Dictionary<String, Any>()
        var captureFirstSideDict = Dictionary<String, Any>()
        captureFirstSideDict["nativeCapturedImage"] = self.encodeImage(analyzerResult.firstCapture?.capturedImage?.image)
        captureFirstSideDict["nativeTransformedImage"] = self.encodeImage(analyzerResult.firstCapture?.transformedImage?.image)
        captureFirstSideDict["nativeSide"] = analyzerResult.firstCapture?.side.rawValue
        captureFirstSideDict["nativeDpiAdjusted"] = analyzerResult.firstCapture?.dpiAdjusted
        
        dict["nativeFirstCapture"] = captureFirstSideDict
        
        var captureSecondSideDict = Dictionary<String, Any>()
        captureSecondSideDict["nativeCapturedImage"] = self.encodeImage(analyzerResult.secondCapture?.capturedImage?.image)
        captureSecondSideDict["nativeTransformedImage"] = self.encodeImage(analyzerResult.secondCapture?.transformedImage?.image)
        captureSecondSideDict["nativeSide"] = analyzerResult.secondCapture?.side.rawValue
        captureSecondSideDict["nativeDpiAdjusted"] = analyzerResult.secondCapture?.dpiAdjusted
        
        dict["nativeSecondCapture"] = captureSecondSideDict
        dict["nativeDocumentGroup"] = analyzerResult.documentGroup.rawValue
        dict["nativeCompletnessStatus"] = analyzerResult.completnessStatus.rawValue
        
        return self.encodeToJson(dict)
    }
    
    static func deserializeLicenseKey(_  licenseKeyDict: Dictionary<String, Any>) -> (Bool, String?) {
        var errorString: String?
        var isLicenseKeyValid = true
    
        if let licenseKey = licenseKeyDict["licenseKey"] as? String {
            MBCCCaptureCoreSDK.shared().setLicenseKey(licenseKey) { captureLicenseKeyError in
                isLicenseKeyValid = false
                switch captureLicenseKeyError {
                case .networkRequired:
                    errorString = "Network required!"
                case .unableToDoRemoteLicenceCheck:
                    errorString = "Unable to do remote license check!"
                case .licenseIsLocked:
                    errorString = "The license key is locked!"
                case .licenseCheckFailed:
                    errorString = "License key check failed!"
                case .invalidLicense:
                    errorString = "Invalid license key!"
                case .permissionExpired:
                    errorString = "License key permission expired!"
                case .payloadCorrupted:
                    errorString = "License key payload corrupted!"
                case .payloadSignatureVerificationFailed:
                    errorString = "License key payload signature verification failed!"
                case .incorrectTokenState:
                    errorString = "Incorrect token state!"
                @unknown default:
                    errorString = "Unknown license key error!"
                }
            }
        } else {
            isLicenseKeyValid = false
            errorString = "Invalid license key!"
        }
        
        return (isLicenseKeyValid,errorString)
    }
    
    static func deserializeCaptureSettings(_ captureSettingsDict: Dictionary<String, Any>) -> MBICCaptureSettings {
        let captureSettings = MBICCaptureSettings()
        if let analyizerSettingsDict = captureSettingsDict["analyzerSettings"] as? Dictionary<String, Any> {
            captureSettings.analyserSettings = deserializeCaptureAnalyzerSettings(analyizerSettingsDict)
        }
        if let uxSettingsDict = captureSettingsDict["uxSettings"] as? Dictionary<String, Any> {
            captureSettings.uxSettings = deserializeCaptureUxSettings(uxSettingsDict)
        }
        
        if let cameraSettingsDict = captureSettingsDict["cameraSettings"] as? Dictionary<String, Any> {
            captureSettings.cameraSettings = deserializeCaptureCameraSettings(cameraSettingsDict)
        }
        
        return captureSettings
    }
    
    static func deserializeCaptureAnalyzerSettings(_ captureAnalyzerSettingsDict: Dictionary<String, Any>) -> MBCCAnalyzerSettings {
        let analyzerSettings = MBCCAnalyzerSettings()
        if let adjustMinimumDocumentDpi = captureAnalyzerSettingsDict["adjustMinimumDocumentDpi"] as? Bool {
            analyzerSettings.adjustMinimumDocumentDpi = adjustMinimumDocumentDpi
        }
        if let blurPolicy = captureAnalyzerSettingsDict["blurPolicy"] as? Int {
            if let value = MBCCBlurPolicy(rawValue: blurPolicy) {
                analyzerSettings.blurPolicy = value
            }
        }
        if let captureSingleSide = captureAnalyzerSettingsDict["captureSingleSide"] as? Bool {
            analyzerSettings.captureSingleSide = captureSingleSide
        }
        if let captureStrategy = captureAnalyzerSettingsDict["captureStrategy"] as? Int {
            if let value = MBCCCaptureStrategy(rawValue: captureStrategy) {
                analyzerSettings.captureStrategy = value
            }
        }
        if let documentFramingMargin = captureAnalyzerSettingsDict["documentFramingMargin"] as? Double {
            analyzerSettings.documentFramingMargin = documentFramingMargin
        }
        if let enforcedDocumentGroup = captureAnalyzerSettingsDict["enforcedDocumentGroup"] as? Int {
            if let value = MBCCEnforcedDocumentGroup(rawValue: enforcedDocumentGroup) {
                analyzerSettings.enforcedDocumentGroup = value
            }
        }
        if let glarePolicy = captureAnalyzerSettingsDict["glarePolicy"] as? Int {
            if let value = MBCCGlarePolicy(rawValue: glarePolicy) {
                analyzerSettings.glarePolicy = value
            }
        }
        if let handOcclusionThreshold = captureAnalyzerSettingsDict["handOcclusionThreshold"] as? Double {
            analyzerSettings.handOcclusionThreshold = handOcclusionThreshold
        }
        if let keepDpiOnTransformedDocumentImage = captureAnalyzerSettingsDict["keepDpiOnTransformedDocumentImage"] as? Bool {
            analyzerSettings.keepDpiOnTransformedDocumentImage = keepDpiOnTransformedDocumentImage
        }
        if let keepMarginOnTransformedDocumentImage = captureAnalyzerSettingsDict["keepMarginOnTransformedDocumentImage"] as? Bool {
            analyzerSettings.keepMarginOnTransformedDocumentImage = keepMarginOnTransformedDocumentImage
        }
        if let lightingThresholds = captureAnalyzerSettingsDict["lightingThresholds"] as? Dictionary<String, Any> {
            if let tooDarkTreshold = lightingThresholds["tooDarkTreshold"] as? Double,
               let tooBrightThreshold = lightingThresholds["tooBrightThreshold"] as? Double {
                analyzerSettings.lightingThresholds = MBCCLightingThresholds(tooDarkTreshold: tooDarkTreshold, tooBrightThreshold: tooBrightThreshold)
            }
        }
        if let minimumDocumentDpi = captureAnalyzerSettingsDict["minimumDocumentDpi"] as? Int {
            analyzerSettings.minimumDocumentDpi = minimumDocumentDpi
        }
        if let returnTransformedDocumentImage = captureAnalyzerSettingsDict["returnTransformedDocumentImage"] as? Bool {
            analyzerSettings.returnTransformedDocumentImage = returnTransformedDocumentImage
        }
        if let tiltPolicy = captureAnalyzerSettingsDict["tiltPolicy"] as? Int {
            if let value = MBCCTiltPolicy(rawValue: tiltPolicy) {
                analyzerSettings.tiltPolicy = value
            }
        }
        return analyzerSettings
    }
    
    static func deserializeCaptureUxSettings(_ captureUxSettingsDict: Dictionary<String, Any>) -> MBICCaptureUXSettings {
        let uxSettings = MBICCaptureUXSettings()
        
        if let showHelpTooltipTimeIntervalMs = captureUxSettingsDict["showHelpTooltipTimeIntervalMs"] as? Double {
            uxSettings.captureHelpTooltipTimeoutInterval = showHelpTooltipTimeIntervalMs / 1000
        }
        if let showIntroductionDialog = captureUxSettingsDict["showIntroductionDialog"] as? Bool {
            uxSettings.showIntroductionDialog = showIntroductionDialog
        }
        if let showOnboardingInfo = captureUxSettingsDict["showOnboardingInfo"] as? Bool {
            uxSettings.showOnboardingInfo = showOnboardingInfo
        }
        if let sideCaptureTimeoutMs = captureUxSettingsDict["sideCaptureTimeoutMs"] as? Double {
            uxSettings.sideCaptureTimeout = sideCaptureTimeoutMs / 1000
        }
        return uxSettings
    }
    
    static func deserializeCaptureCameraSettings(_ captureCameraSettingsDict: Dictionary<String, Any>) -> MBICCameraSettings {
        let cameraSettings = MBICCameraSettings()
        if let cameraResolution = captureCameraSettingsDict["iosCameraResolution"] as? Int {
            if let value = MBICCameraSettingsCameraResolution(rawValue: cameraResolution) {
                cameraSettings.cameraResolution = value
            }
        }
        return cameraSettings
    }
    
    static func encodeImage(_ image: UIImage?) -> String? {
        if let image = image {
            return image.jpegData(compressionQuality: 1.0)?.base64EncodedString()
        }
        return ""
    }
    
    static func encodeToJson(_ resultDict: Dictionary<String, Any>) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: resultDict, options: .prettyPrinted)
            return String(data:jsonData, encoding: .utf8)
        } catch {
            return ""
        }
    }
}
