import 'package:json_annotation/json_annotation.dart';
import 'package:capture_flutter/capture_enums.dart';
part 'package:capture_flutter/capture_settings.g.dart';

/// All available settings for the Capture process.
/// Contains settings for the Capture analyzer, UX and camera configuration settings.
@JsonSerializable()
class CaptureSettings {
  /// Settings for the Capture analyzer.
  /// See [AnalyzerSettings] for more detailed information.
  AnalyzerSettings? analyzerSettings = AnalyzerSettings();

  /// Capture UX settings.
  /// See [UxSettings] for more detailed information.
  UxSettings? uxSettings = UxSettings();

  /// Capture Camera settings.
  /// See [CameraSettings] for more detailed information.
  CameraSettings? cameraSettings = CameraSettings();

  /// All available settings for the Capture process.
  /// Contains settings for the Capture analyzer, UX and camera configuration settings.
  CaptureSettings();

  factory CaptureSettings.fromJson(Map<String, dynamic> json) =>
      _$CaptureSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$CaptureSettingsToJson(this);
}

/// Settings for the Capture analyzer.
/// Used for setting capture strategies and scanning parameters.
@JsonSerializable()
class AnalyzerSettings {
  /// Defines whether to capture a single side or capture all possible sides of a
  /// document with automatic side detection.
  ///
  /// Default: `false`
  bool? captureSingleSide = false;

  /// Defines whether to return an image of a cropped and perspective-corrected document.
  ///
  /// Default: `true`
  bool? returnTransformedDocumentImage = true;

  /// Configures capture strategy used to select the best frame.
  /// See [CaptureStrategy] enum for more detailed information.
  ///
  /// Default: `CaptureStrategy.Default`
  CaptureStrategy? captureStrategy = CaptureStrategy.Default;

  /// Sets the required minimum DPI of the captured document on the transformed image.
  /// Affects how close the document needs to be to the camera in order to get captured.
  /// Allowed values are from 150 to 400 DPI.
  /// Default: `230`
  int? minimumDocumentDpi = 230;

  /// Defines whether to automatically adjust minimum document dpi.
  /// If it is enabled, the minimum dpi is adjusted to the optimal value for the provided input resolution
  /// to enable the capture of all document groups.
  ///
  /// Default: `true`
  bool? adjustMinimumDocumentDpi = true;

  /// Enables document capture with a margin defined as the percentage
  /// of the dimensions of the framed document.
  /// Both margin and document are required to be fully visible on the camera frame in order to finish capture.
  ///
  /// Allowed values are from 0 to 1. Default: `0.01`
  double? documentFramingMargin = 0.01;

  /// Defines whether to return an image of the transformed document
  /// with applied margin used during document framing.
  ///
  /// Default: `false`
  bool? keepMarginOnTransformedDocumentImage = false;

  /// Defines whether to preserve the captured document DPI in the transformed document image.
  /// If disabled, the document dpi is downscaled to 400 DPI.
  ///
  /// Default: `false`
  bool? keepDpiOnTransformedDocumentImage = false;

  /// Sets the for lighting estimation.
  /// See [LightingThresholds] class for more detailed information.
  ///
  /// Default: `tooDarkThreshold`: `0.99`, `tooBrightThreshold`: `0.99`
  LightingThresholds? lightingThresholds = LightingThresholds();

  /// Policy used to discard frames with blurred documents.
  /// See [BlurPolicy] enum for more detailed information.
  ///
  /// Default: `BlurPolicy.Normal`
  BlurPolicy? blurPolicy = BlurPolicy.Normal;

  /// Policy used to discard frames with glare detected on the document.
  /// See [GlarePolicy] enum for more detailed information.
  ///
  /// Default: `GlarePolicy.Normal`
  GlarePolicy? glarePolicy = GlarePolicy.Normal;

  /// Defines the percentage of the document area that is allowed to be
  /// occluded by hand.
  ///
  /// Allowed values are from 0 to 1. Default: `0.05`
  double? handOcclusionThreshold = 0.05;

  /// Policy used to detect tilted documents.
  /// See [TiltPolicy] enum for more detailed information.
  ///
  /// Default: `TiltPolicy.Normal`
  TiltPolicy? tiltPolicy = TiltPolicy.Normal;

  /// Enforces a specific document group, overriding the analyzer’s document classification.
  /// This setting impacts the number of sides scanned to match the enforced group,
  /// and the way document image is transformed.
  /// If set to null, the document group won't be enforced and it will be auto-detected.
  ///
  /// Default: `null`
  EnforcedDocumentGroup? enforcedDocumentGroup;

  /// Settings for the Capture analyzer.
  /// Used for setting capture strategies and scanning parameters.
  AnalyzerSettings();

  factory AnalyzerSettings.fromJson(Map<String, dynamic> json) =>
      _$AnalyzerSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$AnalyzerSettingsToJson(this);
}

/// Defines the parameters for lighting estimation.
@JsonSerializable()
class LightingThresholds {
  /// Threshold used to classify the frame as too dark.
  /// If the calculated lighting score is above this threshold, the frame is discarded.
  ///
  /// Allowed values are from 0 to 1. Default: `0.99`
  double? tooDarkThreshold = 0.99;

  /// Threshold used to classify the frame as too bright.
  /// If the calculated lighting score is above this threshold, the frame is discarded.
  ///
  /// Allowed values are from 0 to 1. Default: `0.99`
  double? tooBrightThreshold = 0.99;

  /// Defines the parameters for lighting estimation.
  LightingThresholds();

  factory LightingThresholds.fromJson(Map<String, dynamic> json) =>
      _$LightingThresholdsFromJson(json);
  Map<String, dynamic> toJson() => _$LightingThresholdsToJson(this);
}

/// Various Capture UX settings.
/// Defines the presence of various UI elements, timers, and screen options.
@JsonSerializable()
class UxSettings {
  /// Defines whether the introduction dialog will be displayed on capture start.
  ///
  /// Default: `false`
  bool? showIntroductionDialog = false;

  /// Defines whether onboarding (help) screens will be displayed.
  /// If onboarding is disabled, the help button and tooltip won't be displayed.
  ///
  /// Default: `true`
  bool? showOnboardingInfo = true;

  /// Defines whether the screen will always be ON while the capture screen is in the foreground.
  ///
  /// Default: `true`
  bool? keepScreenOn = true;

  /// Defines whether to show the tooltip above the help button.
  ///
  /// Default: `true`
  bool? showCaptureHelpTooltip = true;

  /// Sets the time in milliseconds that needs to pass before the help tooltip is displayed.
  ///
  /// Default: `8000` (8 seconds)
  double? showHelpTooltipTimeIntervalMs = 8000;

  /// Duration in milliseconds that needs to pass since scanning of the current document side has begun in order to finish side capture.
  /// The timeout timer is restarted on the document side flip.
  ///
  /// Please be aware that time counting does not start from the moment when capture process starts.
  /// Instead, it starts from the moment when at least one valid frame candidate for the current document side enters the analysis queue.
  /// The reason for this is the better user experience in cases when, for example, the timeout is set to 10 seconds and the user starts scanning, leaves the device lying on the
  /// table for 9 seconds, and then points the device towards the document it wants to capture: in such a case, it is better to let the user capture the document.
  /// To disable side capture timeout set it to null.
  ///
  /// Default: `15000` (15 seconds)
  double? sideCaptureTimeoutMs = 15000;

  /// Various Capture UX settings.
  /// Defines the presence of various UI elements, timers, and screen options.
  UxSettings();

  factory UxSettings.fromJson(Map<String, dynamic> json) =>
      _$UxSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$UxSettingsToJson(this);
}

/// Defines Capture's Camera configuration options.
/// Settings for camera resolution, separately for iOS and Android devices.
@JsonSerializable()
class CameraSettings {
  /// Sets the camera resolution for Android devices.
  ///
  /// This represents the preferred camera resolution.
  /// It does not mean that the exact same resolution will be selected, but SDK will use the nearest one possible.
  /// The actual resolution that will be chosen depends on the actual device hardware (camera resolutions available and processing power).
  ///
  /// See [AndroidCameraResolution] for all options.
  ///
  /// Default: `AndroidCameraResolution.Resolution2160P`
  AndroidCameraResolution androidCameraResolution =
      AndroidCameraResolution.Resolution2160P;

  /// Sets the camera resolution for iOS devices.
  ///
  /// This represents the preferred camera resolution.
  /// It does not mean that the exact same resolution will be selected, but SDK will use the nearest one possible.
  /// The actual resolution that will be chosen depends on the actual device hardware (camera resolutions available and processing power).
  ///
  /// See [IosCameraResolution] for all options.
  ///
  /// Default: `IosCameraResolution.Resolution1080p`
  IosCameraResolution iosCameraResolution = IosCameraResolution.Resolution1080p;

  /// Defines Capture's Camera configuration options.
  /// Settings for camera resolution, separately for iOS and Android devices.
  CameraSettings();

  factory CameraSettings.fromJson(Map<String, dynamic> json) =>
      _$CameraSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$CameraSettingsToJson(this);
}
