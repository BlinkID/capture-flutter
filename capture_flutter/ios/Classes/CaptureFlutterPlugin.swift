import Flutter
import UIKit
import CaptureUX

public class CaptureFlutterPlugin: NSObject, FlutterPlugin {
    var result: FlutterResult?
    let iosLicenseKeyError = "CaptureiOSLicenseError"
    var captureSettings: MBICCaptureSettings?
    
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
                if setupKey(licenseKey) {
                    if let captureSettings = args["captureSettings"] as? Dictionary<String, Any> {
                        setupCaptureSettings(captureSettings)
                        if let settings = self.captureSettings {
                            let captureVC = MBICCaptureViewController(captureSettings: settings)
                            captureVC.delegate = self
                            captureVC.modalPresentationStyle = .fullScreen
                            let rootVc = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
                            rootVc?.present(captureVC, animated: true)
                        }
                    }
                }
            } else {
                self.result!(FlutterError(code: iosLicenseKeyError, message: "Invalid license key!", details: nil))
            }
        }
    }
    
    private func setupCaptureSettings(_ captureSettingsDict: Dictionary<String, Any>) {
        self.captureSettings = CaptureSerializationUtils.deserializeCaptureSettings(captureSettingsDict)
    }
      
    private func setupKey(_ licenseKeyDict: Dictionary<String, Any>) -> Bool {
        var isLicenseKeyValid = true
        if let licenseKey = licenseKeyDict["licenseKey"] as? String {
            MBCCCaptureCoreSDK.shared().setLicenseKey(licenseKey) { captureLicenseKeyError in
                switch captureLicenseKeyError {
                case .networkRequired:
                    self.result!(FlutterError(code: self.iosLicenseKeyError, message: "Network required!", details: nil))
                case .unableToDoRemoteLicenceCheck:
                    self.result!(FlutterError(code: self.iosLicenseKeyError, message: "Unable to do remote license check!", details: nil))
                case .licenseIsLocked:
                    self.result!(FlutterError(code: self.iosLicenseKeyError, message: "The license key is locked!", details: nil))
                case .licenseCheckFailed:
                    self.result!(FlutterError(code: self.iosLicenseKeyError, message: "License key check failed!", details: nil))
                case .invalidLicense:
                    self.result!(FlutterError(code: self.iosLicenseKeyError, message: "Invalid license key!", details: nil))
                case .permissionExpired:
                    self.result!(FlutterError(code: self.iosLicenseKeyError, message: "License key permission expired!", details: nil))
                case .payloadCorrupted:
                    self.result!(FlutterError(code: self.iosLicenseKeyError, message: "License key payload corrupted!", details: nil))
                case .payloadSignatureVerificationFailed:
                    self.result!(FlutterError(code: self.iosLicenseKeyError, message: "License key payload signature verification failed!", details: nil))
                case .incorrectTokenState:
                    self.result!(FlutterError(code: self.iosLicenseKeyError, message: "Incorrect token state!", details: nil))
                @unknown default:
                    self.result!(FlutterError(code: self.iosLicenseKeyError, message: "Unknown license key error occoured!", details: nil))
                }
                isLicenseKeyValid = false
            }
        } else {
            self.result!(FlutterError(code: "CaptureiOSLicenseError", message: "Invalid license key!", details: nil))
        }
        return isLicenseKeyValid
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
