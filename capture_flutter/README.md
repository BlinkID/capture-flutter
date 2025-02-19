<p align="center" >
  <img src="https://raw.githubusercontent.com/wiki/blinkid/blinkid-android/images/logo-microblink.png" alt="Microblink" title="Microblink">
</p>

# _Capture_ SDK Flutter plugin
A Flutter plugin for Microblink's Capture SDK, an SDK used for auto-capturing high quality images of identity documents in a user-friendly way.

For maximum performance and full access to all features, it’s best to go with one of our native SDKs (for [iOS](https://github.com/BlinkID/capture-ios) and [Android](https://github.com/BlinkID/capture-android)).

## Requirements
The Capture Flutter plugin is built with Flutter v3.24.2.
All of the versions and depencies of the capture_flutter plugin can be viewed in the [pubsec.yaml](https://github.com/BlinkID/capture-flutter/blob/main/capture_flutter/pubspec.yamll) file.

The plugin has requirements on the native iOS & Android end, which can be viewed here:

|   Requirement  	|         iOS        	|          Android         	|
|:--------------:	|:------------------:	|:------------------------:	|
| OS/API version 	| iOS 13.0 and newer 	| API version 21 and newer 	|
| Camera quality 	| At least 1080p     	| At least 1080p           	|

For more detailed information about the device requirements, go to the native documention here for [iOS](https://github.com/BlinkID/capture-ios?tab=readme-ov-file#-requirements) and [Android](https://github.com/BlinkID/capture-android?tab=readme-ov-file#-device-requirements).

## Quickstart with the sample application
The sample application demonstrates how the Capture SDK is implemented, used and how to obtain the captured results.

To run it follow the steps:
1. Git clone the repository:
```bash
git clone https://github.com/BlinkID/capture-flutter.git
```
2. Position to the obtained Capture folder and run the `initCaptureFlutterSample.sh` script:
```bash
cd capture_flutter && ./initCaptureFlutterSample.sh
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

## Plugin usage

## Platform specifics

### Android

### iOS

## Licensing
