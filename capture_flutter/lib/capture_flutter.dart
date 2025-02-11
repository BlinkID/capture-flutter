
import 'capture_flutter_platform_interface.dart';

class CaptureFlutter {
  Future<String?> getPlatformVersion() {
    return CaptureFlutterPlatform.instance.getPlatformVersion();
  }
}
