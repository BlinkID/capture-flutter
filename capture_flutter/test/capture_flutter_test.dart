import 'package:flutter_test/flutter_test.dart';
import 'package:capture_flutter/capture_flutter.dart';
import 'package:capture_flutter/capture_flutter_platform_interface.dart';
import 'package:capture_flutter/capture_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCaptureFlutterPlatform
    with MockPlatformInterfaceMixin
    implements CaptureFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CaptureFlutterPlatform initialPlatform = CaptureFlutterPlatform.instance;

  test('$MethodChannelCaptureFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCaptureFlutter>());
  });

  test('getPlatformVersion', () async {
    CaptureFlutter captureFlutterPlugin = CaptureFlutter();
    MockCaptureFlutterPlatform fakePlatform = MockCaptureFlutterPlatform();
    CaptureFlutterPlatform.instance = fakePlatform;

    expect(await captureFlutterPlugin.getPlatformVersion(), '42');
  });
}
