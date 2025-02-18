import Flutter
import UIKit
import CaptureUX

public class CaptureFlutterPlugin: NSObject, FlutterPlugin {
    var result: FlutterResult?
    let iosLicenseKeyError = "CaptureiOSLicenseError"
    let iosCaptureError = "CaptureiOSError"
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "capture_flutter", binaryMessenger: registrar.messenger())
        let instance = CaptureFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "scanWithCamera":
            self.result = result
            scanWithCamera(call)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func scanWithCamera(_ call: FlutterMethodCall) {
        if let args = call.arguments as? Dictionary<String, Any> {
            if let licenseKey = args["license"] as? Dictionary<String, Any> {
                let (isKeyValid, licenseErrorString) = CaptureSerializationUtils.deserializeLicenseKey(licenseKey)
                if isKeyValid {
                    if let captureSettings = args["captureSettings"] as? Dictionary<String, Any> {
                        let captureVC = MBICCaptureViewController(captureSettings: CaptureSerializationUtils.deserializeCaptureSettings(captureSettings))
                        captureVC.delegate = self
                        captureVC.modalPresentationStyle = .fullScreen
                        let rootVc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
                        rootVc?.present(captureVC, animated: true)
                    } else {
                        self.result!(FlutterError(code: iosCaptureError, message: "Incorrectly set Capture Settings!", details: nil))
                    }
                } else {
                    self.result!(FlutterError(code: iosLicenseKeyError, message: licenseErrorString, details: nil))
                }
            } else {
                self.result!(FlutterError(code: iosLicenseKeyError, message: "Invalid license key!", details: nil))
            }
        }
    }
}

extension CaptureFlutterPlugin: MBICCaptureViewControllerDelegate {
    public func captureViewController(captureViewController: MBICCaptureViewController, didFinishCaptureWithResult analyzerResult: MBCCAnalyzerResult) {
        if let result = result {
            result(CaptureSerializationUtils.serializeResult(analyzerResult))
        }
        
        DispatchQueue.main.async {
            captureViewController.dismiss(animated: true)
        }
    }
}
