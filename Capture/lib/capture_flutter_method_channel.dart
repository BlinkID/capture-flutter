import 'package:capture_flutter/capture_settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:capture_flutter/capture_flutter_platform_interface.dart';
import 'package:capture_flutter/capture_analyzer_result.dart';

import 'dart:convert';

/// An implementation of [CaptureFlutterPlatform] that uses method channels.
///
/// MethodChannelCaptureFlutter exposes the appropriate native Capture module as a Flutter/Dart module,
/// based on detected platform: Android or iOS.
///
/// The method channel contains the function `scanWithCamera` which enables the Capture process with the default Analyzer & UX properties.
class MethodChannelCaptureFlutter extends CaptureFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const methodChannel = MethodChannel('capture_flutter');
  static const String METHOD_SCAN_WITH_CAMERA = 'scanWithCamera';

  static const String ARG_LICENSE = 'license';
  static const String ARG_LICENSE_KEY = 'licenseKey';
  static const String ARG_LICENSEE = 'licensee';

  static const String ARG_CAPTURE_SETTINGS = 'captureSettings';

  /// The `scanWithCamera` platform channel method launches the Capture process with the default Analyzer & UX properties.
  /// It takes the following two parameters: [CaptureSettings] and a base64 license key `String`.
  ///
  /// 1. Capture Settings: the class that contains all of the available settings for the Capture process. It contains settings for the Capture analyzer, UX and camera configuration settings.
  ///
  /// 2. License key `string`: It should contain a base64 license key bound to application ID for Android or iOS.
  /// To obtain valid license key, please visit https://developer.microblink.com/ or contact us directly at https://help.microblink.com
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
