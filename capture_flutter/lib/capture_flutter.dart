import 'package:capture_flutter/capture_analyzer_result.dart';
import 'package:capture_flutter/capture_settings.dart';

import 'capture_flutter_platform_interface.dart';

/// CaptureFlutter plugin exposes the appropriate native Capture module as a Flutter/Dart module,
/// based on detected platform: Android or iOS.
///
/// The plugin contains the function `scanWithCamera` which enables the Capture process with the default Analyzer & UX properties.
/// These properties can be modified with the [CaptureSettings] class.
class CaptureFlutter {
  /// The `scanWithCamera` method launches the Capture process with the default Analyzer & UX properties.
  /// It takes the following two parameters: [CaptureSettings] and a base64 license key `String`.
  ///
  /// 1. Capture Settings: the class that contains all of the available settings for the Capture process. It contains settings for the Capture analyzer, UX and camera configuration settings.
  ///
  /// 2. License key `string`: It should contain a base64 license key bound to application ID for Android or iOS.
  /// To obtain valid license key, please visit https://developer.microblink.com/ or contact us directly at https://help.microblink.com
  Future<AnalyzerResult?> scanWithCamera(
      CaptureSettings captureSettings, String licenseKey) {
    return CaptureFlutterPlatform.instance
        .scanWithCamera(captureSettings, licenseKey);
  }
}
