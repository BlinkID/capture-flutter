import 'package:capture_flutter/capture_analyzer_result.dart';
import 'package:capture_flutter/capture_settings.dart';

import 'capture_flutter_platform_interface.dart';

class CaptureFlutter {
  Future<AnalyzerResult?> scanWithCamera(
      CaptureSettings captureSettings, String licenseKey) {
    return CaptureFlutterPlatform.instance
        .scanWithCamera(captureSettings, licenseKey);
  }
}
