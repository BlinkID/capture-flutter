import 'package:capture_flutter/capture_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:capture_flutter/capture_flutter_platform_interface.dart';
import 'package:capture_flutter/capture_analyzer_result.dart';

import 'dart:convert';

/// An implementation of [CaptureFlutterPlatform] that uses method channels.
class MethodChannelCaptureFlutter extends CaptureFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const methodChannel = MethodChannel('capture_flutter');
  static const String METHOD_SCAN_WITH_CAMERA = 'scanWithCamera';

  static const String ARG_LICENSE = 'license';
  static const String ARG_LICENSE_KEY = 'licenseKey';
  static const String ARG_LICENSEE = 'licensee';

  static const String ARG_CAPTURE_SETTINGS = 'captureSettings';

  @override
  Future<AnalyzerResult?> scanWithCamera(
      CaptureSettings captureSettings, String license) async {
    final jsonAnalyzerResults =
        await methodChannel.invokeMethod(METHOD_SCAN_WITH_CAMERA, {
      ARG_CAPTURE_SETTINGS: jsonDecode(jsonEncode(captureSettings)),
      ARG_LICENSE: {ARG_LICENSE_KEY: license}
    });

    final nativeAnalyzerResult = jsonDecode(jsonAnalyzerResults);
    return AnalyzerResult(Map<String, dynamic>.from(nativeAnalyzerResult));
  }
}
