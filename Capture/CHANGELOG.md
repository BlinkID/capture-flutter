## 1.4.3

The initial release of the Capture Flutter plugin.
- The plugin is based on the native Capture SDKs for Android and iOS.
    - The plugin uses the [v1.4.3 iOS SDK](https://github.com/BlinkID/capture-ios/releases/tag/v1.4.3) ,and the [v1.4.0 Android SDK](https://github.com/BlinkID/capture-android/releases/tag/v1.4.0).

## CapturePlugin
- The `CapturePlugin` exposes the the appropriate native Capture module as a Flutter/Dart module, based on detected platform: Android or iOS.
    - The plugin currently contains the function `scanWithCamera` which enables the Capture process with the default Analyzer & UX properties.

### Plugin usage
- `scanWithCamera` platform channel method launches the Capture process with the default Analyzer & UX properties.

- It takes the following two parameters: `CaptureSettings` and a base64 license key `String`, required for unlocking the SDK:
    1. **Capture Settings**: the class that contains all of the available settings for the Capture process. It contains settings for the Capture analyzer, UX and camera configuration settings.
        - All of the Capture settings that can be modified, can be viewed [here](https://github.com/BlinkID/capture-flutter/blob/develop/capture_flutter/lib/capture_settings.dart).
    2. **License key**: A base64 license key bound to application ID for Android or iOS.
        - A valid license key can be obtained via Microblink's [Developer Hub](https://developer.microblink.com/) or contacting us directly [here](https://help.microblink.com).

- The `scanWithCamera` returns the `AnalyzerResult` object, which contains the result of the capture analysis. 
    - It contains the information about each document side, completness status of the capture process, and the document group.
    - All of the available results can be viewed [here](https://github.com/BlinkID/capture-flutter/blob/develop/capture_flutter/lib/capture_analyzer_result.dart).
- A detailed guide about the integration and usage of the plugin can be viewed [here](https://github.com/BlinkID/capture-flutter/tree/develop?tab=readme-ov-file#integration).