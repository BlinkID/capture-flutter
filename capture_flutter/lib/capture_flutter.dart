import 'package:capture_flutter/CaptureAnalyzerResult.dart';
import 'package:capture_flutter/CaptureSettings.dart';
import 'package:capture_flutter/capture_flutter_method_channel.dart';
import 'package:flutter/services.dart';

import 'capture_flutter_platform_interface.dart';

class CaptureFlutter {
  Future<AnalyzerResult?> scanWithCamera(
      CaptureSettings captureSettings, String licenseKey) {
    return CaptureFlutterPlatform.instance
        .scanWithCamera(captureSettings, licenseKey);
  }
}
