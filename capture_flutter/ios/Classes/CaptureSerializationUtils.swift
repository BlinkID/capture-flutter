//
//  CaptureSerializationUtils.swift
//  Pods
//
//  Created by Milan Parađina on 12.02.2025..
//

import CaptureUX

class CaptureSerializationUtils {
    static func serializeResult(_ analyzerResult: MBCCAnalyzerResult) -> Dictionary<String, Any>  {
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
        captureSecondSideDict["ativeDpiAdjusted"] = analyzerResult.secondCapture?.dpiAdjusted
        
        dict["nativeSecondCapture"] = captureSecondSideDict
        dict["nativeDocumentGroup"] = analyzerResult.documentGroup.rawValue
        dict["nativeCompletnessStatus"] = analyzerResult.completnessStatus.rawValue
        return dict
    }
    
    static func encodeImage(_ image: UIImage?) -> String? {
        if let image = image {
            return image.jpegData(compressionQuality: 1.0)?.base64EncodedString()
        }
        return ""
    }
}
