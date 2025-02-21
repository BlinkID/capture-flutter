<p align="center" >
  <img src="https://raw.githubusercontent.com/wiki/blinkid/blinkid-android/images/logo-microblink.png" alt="Microblink" title="Microblink">
</p>

# _Capture_ Flutter plugin
A Flutter plugin for Microblink's Capture SDK, an SDK used for auto-capturing high quality images of identity documents in a user-friendly way.

The SDK provides you with a rectified image of the document that ensures high success rate in extracting document text or verifying the document validity.

User is guided to avoid glare, blurred images, bad lighting conditions, fingers over the document or too much tilt. The SDK is able to recognize if a document is single sided (i.e. passport) or double sided (i.e. driving license) and prompt the user to scan the back side of the document when needed.

In the results, you can get a cropped, perspective-corrected image of the document, along with the original frame. Those can be processed by your app in any way required. The SDK is lightweight and can be easily integrated into your mobile app and bland in your design.

**For maximum performance and full access to all features, it’s best to go with one of our native SDKs (for [iOS](https://github.com/BlinkID/capture-ios) and [Android](https://github.com/BlinkID/capture-android)).**

# Table of contents
- [Requirements](#requirements)
- [Quickstart with the sample application](#quickstart-with-the-sample-application)
- [Integration](#integration)
- [Plugin usage](#plugin-usage)
- [Platform specifics](#platform-specifics)
  - [Capture Settings](#capture-settings)
  - [Analyzer Result](#analyzer-result)
- [Licensing](#licensing)
- [Additional information](#additional-information)

## <a name="requirements"></a> Requirements
The Capture Flutter plugin is built with Flutter v3.24.2.
All of the versions and depencies of the capture_flutter plugin can be viewed in the [pubsec.yaml](https://github.com/BlinkID/capture-flutter/blob/main/Capture/pubspec.yaml) file.

The plugin has requirements on the native iOS & Android end, which can be viewed here:

|   Requirement  	|         iOS        	|          Android         	|
|:--------------:	|:------------------:	|:------------------------:	|
| OS/API version 	| iOS 13.0 and newer 	| API version 21 and newer 	|
| Camera quality 	| At least 1080p     	| At least 1080p           	|

For more detailed information about the device requirements, go to the native documention here for [iOS](https://github.com/BlinkID/capture-ios?tab=readme-ov-file#-requirements) and [Android](https://github.com/BlinkID/capture-android?tab=readme-ov-file#-device-requirements).

## <a name="quickstart-with-the-sample-application"></a> Quickstart with the sample application
The sample application demonstrates how the Capture SDK is implemented, used and how to obtain the captured results.

To run it follow the steps:
1. Git clone the repository:
```bash
git clone https://github.com/BlinkID/capture-flutter.git
```
2. Position to the obtained Capture folder and run the `initCaptureFlutterSample.sh` script:
```bash
cd capture-flutter && ./initCaptureFlutterSample.sh
```
3. After the script finishes running, position to the `sample` folder and run the `flutter run` command:
```bash
cd sample && flutter run
```
4. Pick the platform to run the Capture SDK on.

Note: the plugin can be run directly via Xcode and Android Studio:
1. Open the `Runner.xcworkspace` in the path: `sample/ios/Runner.xcworkspace` to run the iOS sample application.
2. Open the `android` folder via Android Studio in the `sample` folder to run the Android sample application.

## Integration
To add the Capture plugin to your Flutter application, simply add the following dependency in the pubsec.yaml:
```
dependencies:
...
  capture_flutter:
```

## <a name="plugin-usage"></a> Plugin usage
1. After the dependency has been added to the project, firstly add the neccessery imports:
```dart
import 'package:capture_flutter/capture_flutter.dart';
import 'package:capture_flutter/capture_settings.dart';
import 'package:capture_flutter/capture_enums.dart';
import 'package:capture_flutter/capture_analyzer_result.dart';
```
2. Initialize the Capture plugin:
```dart
final capturePlugin = CaptureFlutter();
```
3. Set all of the neccessary Capture settings (Analyzer, UX and Camera). You do not need to modify anything from these settings:
```dart
// Create Capture settings
final settings = CaptureSettings();

// Modify Capture UX settings
settings.uxSettings?.showOnboardingInfo = true;
settings.uxSettings?.showIntroductionDialog = true;
settings.uxSettings?.showHelpTooltipTimeIntervalMs = 2000;

// Modify Capture Analyzer settings
settings.analyzerSettings?.captureStrategy = CaptureStrategy.Default;
settings.analyzerSettings?.documentFramingMargin = 0.01;
settings.analyzerSettings?.keepMarginOnTransformedDocumentImage = true;

// Modify Capture Camera settings
settings.cameraSettings?.iosCameraResolution = IosCameraResolution.Resolution4K;
```

4. Add the license key and previously configured Capture settings in the `scanWithCamera` method of the plugin, and obtain the results after the capture process has finished:
```dart
// Add the license key
var licenseKey = "";
if (Theme.of(context).platform == TargetPlatform.iOS) {
    licenseKey = "your-iOS-license-key";
} else if (Theme.of(context).platform == TargetPlatform.android) {
    licenseKey = 'your-Android-license-key';
} else {
    licenseKey = "";
}

// Add the license key and the Capture settings in the scanWithCamera method
var results = await capturePlugin.scanWithCamera(settings,licenseKey);

if (results?.completnessStatus == CompletnessStatus.Complete) {
  // handle the obtained results
  print(result?.documentGroup);
}
```

- The whole integration process can be found in the sample app `main.dart` file [here](https://github.com/BlinkID/capture-flutter/blob/main/sample_files/main.dart).
- The settings results that can be used with the Capture plugin can be found in the paragrapahs below, but also in the comments of each result in the Dart files.

## <a name="platform-specifics"></a> Platform specifics
Plugin implementation is located in the `lib` folder, while platform-specific implementation is located in the `android` and `ios` folders.

### <a name="capture-settings"></a> Capture Settings
With the `CaptureSettings` class, Capture's `AnalyzerSettings`, `UxSettings` and `CameraSettings` can be modified.

All of the settings that can be modified, along with the explanation of what each setting does, can be found in the [capture_settings.dart](https://github.com/BlinkID/capture-flutter/blob/main/Capture/lib/capture_settings.dart) file.

The native implementation of the `CaptureSettings` can be found here:
- iOS:
  - [Capture Settings](https://github.com/BlinkID/capture-flutter/blob/main/Capture/ios/Classes/CaptureSerializationUtils.swift#L72)
  - [Analyzer Settings](https://github.com/BlinkID/capture-flutter/blob/main/Capture/ios/Classes/CaptureSerializationUtils.swift#L88)
  - [UX Settings](https://github.com/BlinkID/capture-flutter/blob/develop/Capture/ios/Classes/CaptureSerializationUtils.swift#L143)
  - [Camera Settings](https://github.com/BlinkID/capture-flutter/blob/main/Capture/ios/Classes/CaptureSerializationUtils.swift#L168)
- Android:
  - [Capture Settings](https://github.com/BlinkID/capture-flutter/blob/main/Capture/android/src/main/kotlin/com/microblink/capture_flutter/CaptureSerializationUtils.kt#L45)
  - [Analyzer Settings](https://github.com/BlinkID/capture-flutter/blob/main/Capture/android/src/main/kotlin/com/microblink/capture_flutter/CaptureSerializationUtils.kt#L51)
  - [UX Settings](https://github.com/BlinkID/capture-flutter/blob/main/Capture/android/src/main/kotlin/com/microblink/capture_flutter/CaptureSerializationUtils.kt#L70)
  - [Camera Settings](https://github.com/BlinkID/capture-flutter/blob/develop/Capture/android/src/main/kotlin/com/microblink/capture_flutter/CaptureSerializationUtils.kt#L77)

For a more detailed explanation about the Capture Settings, go to the native documentation here for [iOS](https://blinkid.github.io/capture-ux-sp/documentation/captureux/mbiccapturesettings) and [Android](https://blinkid.github.io/capture-android/capture-ux/com.microblink.capture.settings/-capture-settings/index.html).

### <a name="analyzer-result"></a> Analyzer Result
The `AnalyzerResult` class represents the result of the capture process, and it is available after the scanning process finishes.

All of the results that can be obtained, along with the explanation of what each property returns, can be found in the [capture_analyzer_result.dart](https://github.com/BlinkID/capture-flutter/blob/main/Capture/lib/capture_analyzer_result.dart) file.

The native implementation of the `AnalyzerResult` can be found here:
- [iOS](https://github.com/BlinkID/capture-flutter/blob/main/Capture/ios/Classes/CaptureSerializationUtils.swift#L11)
- [Android](https://github.com/BlinkID/capture-flutter/blob/main/Capture/android/src/main/kotlin/com/microblink/capture_flutter/CaptureSerializationUtils.kt#L23)

For a more detailed explanation about the Analyzer Result, go to the native documentation here for [iOS](https://blinkid.github.io/capture-core-sp/documentation/capturecore/mbccanalyzerresult) and [Android](https://blinkid.github.io/capture-android/capture-core/com.microblink.capture.result/-analyzer-result/index.html?query=class%20AnalyzerResult).

## <a name="licensing"></a> Licensing
A valid license key is required to initialize the Capture plugin. A free trial license key can be requsted after registering at [Microblink Developer Hub](https://developer.microblink.com/).

## <a name="additional-information"></a> Additional information
For any additional questions and information, feel free to contact us [here](https://help.microblink.com).
