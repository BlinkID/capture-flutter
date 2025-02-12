import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'capture_flutter_platform_interface.dart';
import 'CaptureAnalyzerResult.dart';

/// An implementation of [CaptureFlutterPlatform] that uses method channels.
class MethodChannelCaptureFlutter extends CaptureFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const methodChannel = const MethodChannel('capture_flutter');

  static Future<AnalyzerResult?> scanWithCamera() async {
    final analyzerResult = await methodChannel
        .invokeMethod<Map<Object?, Object?>>('scanWithCamera');
    final nativeAnalyzerResult = Map<String, dynamic>.from(analyzerResult!);
    return AnalyzerResult(nativeAnalyzerResult);
  }
}
