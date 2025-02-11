import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'capture_flutter_platform_interface.dart';

/// An implementation of [CaptureFlutterPlatform] that uses method channels.
class MethodChannelCaptureFlutter extends CaptureFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('capture_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
