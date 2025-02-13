import 'package:capture_flutter/CaptureSettings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'capture_flutter_platform_interface.dart';
import 'CaptureAnalyzerResult.dart';

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

  static Future<AnalyzerResult?> scanWithCamera(
      CaptureSettings captureSettings, String license) async {
    //final analyzerResult = await methodChannel
    //    .invokeMethod<Map<Object?, Object?>>('scanWithCamera');
    //final nativeAnalyzerResult = Map<String, dynamic>.from(analyzerResult!);
    final jsonAnalyzerResults =
        await methodChannel.invokeMethod(METHOD_SCAN_WITH_CAMERA, {
      ARG_CAPTURE_SETTINGS: jsonDecode(jsonEncode(captureSettings)),
      ARG_LICENSE: {ARG_LICENSE_KEY: license}
    });

    final nativeAnalyzerResult = Map<String, dynamic>.from(jsonAnalyzerResults);
    return AnalyzerResult(nativeAnalyzerResult);
  }
}
