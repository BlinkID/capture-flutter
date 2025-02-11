import Flutter
import UIKit
import CaptureUX

public class CaptureFlutterPlugin: NSObject, FlutterPlugin {
    var captureSettings: MBICCaptureSettings?
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "capture_flutter", binaryMessenger: registrar.messenger())
    let instance = CaptureFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "scanWithCamera":
        scanWithCamera()
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    public func scanWithCamera() {
      setupKey()
      setupCaptureSettings()
      let captureVC = MBICCaptureViewController()
      captureVC.delegate = self
      captureVC.modalPresentationStyle = .fullScreen
      let rootVc = UIApplication.shared.keyWindow?.rootViewController
      rootVc?.present(captureVC, animated: true)
    }
    
    private func setupCaptureSettings() {
        self.captureSettings = MBICCaptureSettings()
    }
      
      private func setupKey() {
          MBCCCaptureCoreSDK.shared().setLicenseKey("license-key") { captureLicenseKeyError in
              switch captureLicenseKeyError {
              case .networkRequired:
                  print("Network required")
              case .unableToDoRemoteLicenceCheck:
                  print("unableToDoRemoteLicenceCheck")
              case .licenseIsLocked:
                  print("licenseIsLocked")
              case .licenseCheckFailed:
                  print("licenseCheckFailed")
              case .invalidLicense:
                  print("invalidLicense")
              case .permissionExpired:
                  print("permissionExpired")
              case .payloadCorrupted:
                  print("payloadCorrupted")
              case .payloadSignatureVerificationFailed:
                  print("payloadSignatureVerificationFailed")
              case .incorrectTokenState:
                  print("incorrectTokenState")
              @unknown default:
                  print("Unknown license key error")
              }
          }
      }
}

extension CaptureFlutterPlugin: MBICCaptureViewControllerDelegate {
    public func captureViewController(captureViewController: MBICCaptureViewController, didFinishCaptureWithResult analyzerResult: MBCCAnalyzerResult) {
        print(analyzerResult.description)
    }
}
