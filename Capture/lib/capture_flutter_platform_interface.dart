import 'package:capture_flutter/capture_analyzer_result.dart';
import 'package:capture_flutter/capture_settings.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'capture_flutter_method_channel.dart';

abstract class CaptureFlutterPlatform extends PlatformInterface {
  /// Constructs a CaptureFlutterPlatform.
  CaptureFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static CaptureFlutterPlatform _instance = MethodChannelCaptureFlutter();

  /// The default instance of [CaptureFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelCaptureFlutter].
  static CaptureFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CaptureFlutterPlatform] when
  /// they register themselves.
  static set instance(CaptureFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Returns the `scanWithCamera` method from the [MethodChannelCaptureFlutter].
  /// Takes two parameters: [CaptureSettings] and a base64 license key `String`
  /// See [MethodChannelCaptureFlutter] for more detailed information.
  Future<AnalyzerResult?> scanWithCamera(
      CaptureSettings captureSettings, String license) {
    return MethodChannelCaptureFlutter()
        .scanWithCamera(captureSettings, license);
  }
}
