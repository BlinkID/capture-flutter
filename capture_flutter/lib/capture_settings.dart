import 'package:json_annotation/json_annotation.dart';
import 'package:capture_flutter/capture_enums.dart';
part 'package:capture_flutter/capture_settings.g.dart';

@JsonSerializable()
class CaptureSettings {
  /// Settings for the Capture analyzer.
  /// See [AnalyzerSettings] for more detailed information.
  AnalyzerSettings? analyzerSettings = AnalyzerSettings();

  /// Capture UX settings.
  /// See [UxSettings] for more detailed information.
  UxSettings? uxSettings = UxSettings();

  CameraSettings? cameraSettings = CameraSettings();

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
  bool? captureSingleSide;

  /// Defines whether to return an image of a cropped and perspective-corrected document.
  ///
  /// Default: `true`
  bool? returnTransformedDocumentImage;

  /// Configures capture strategy used to select the best frame.
  /// See [CaptureStrategy] enum for more detailed information.
  ///
  /// Default: `CaptureStrategy.Default`
  CaptureStrategy? captureStrategy;

  /// Sets the required minimum DPI of the captured document on transformed image.
  /// Affects how close the document needs to be to the camera in order to get captured.
  /// Allowed values are from 150 to 400 DPI.
  /// Default: `230`
  int? minimumDocumentDpi;

  /// Defines whether to automatically adjust minimum document dpi.
  /// If it is enabled, minimum dpi is adjusted to optimal value for provided input resolution
  /// to enable capture of all document groups.
  ///
  /// Default: `true`
  bool? adjustMinimumDocumentDpi;

  /// Enables document capture with a margin defined as the percentage
  /// of the dimensions of the framed document.
  /// Both margin and document are required to be fully visible on camera frame in order to finish capture.
  ///
  /// Allowed values are from 0 to 1. Default: `0.01`
  double? documentFramingMargin;

  /// Defines whether to return an image of the transformed document
  /// with applied margin used during document framing.
  ///
  /// Default: `false`
  bool? keepMarginOnTransformedDocumentImage;

  /// Defines whether to preserve the captured document DPI in transformed document image.
  /// If disabled, the document dpi is downscaled to 400 DPI.
  ///
  /// Default: `false`
  bool? keepDpiOnTransformedDocumentImage;

  /// Sets the for lighting estimation.
  /// See [LightingThresholds] class for more detailed information.
  ///
  /// Default: `tooDarkThreshold`: `0.99`, `tooBrightThreshold`: `0.99`
  LightingThresholds? lightingThresholds = LightingThresholds();

  /// Policy used to discard frames with blurred documents.
  /// See [BlurPolicy] enum for more detailed information.
  ///
  /// Default: `BlurPolicy.Normal`
  BlurPolicy? blurPolicy;

  /// Policy used to discard frames with glare detected on the document.
  /// See [GlarePolicy] enum for more detailed information.
  ///
  /// Default: `GlarePolicy.Normal`
  GlarePolicy? glarePolicy;

  /// Defines percentage of the document area that is allowed to be
  /// occluded by hand.
  ///
  /// Allowed values are from 0 to 1. Default: `0.05`
  double? handOcclusionThreshold;

  /// Policy used to detect tilted documents.
  /// See [TiltPolicy] enum for more detailed information.
  ///
  /// Default: `TiltPolicy.Normal`
  TiltPolicy? tiltPolicy;

  /// Enforces a specific document group, overriding the analyzer’s document classification.
  /// This setting impacts the number of sides scanned to match the enforced group,
  /// and the way document image is transformed.
  /// If set to null, document group won't be enforced  and it will be auto-detected.
  ///
  /// Default: `null`
  EnforcedDocumentGroup? enforcedDocumentGroup;

  AnalyzerSettings();

  factory AnalyzerSettings.fromJson(Map<String, dynamic> json) =>
      _$AnalyzerSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$AnalyzerSettingsToJson(this);
}

/// Defines the parameters for lighting estimation.
@JsonSerializable()
class LightingThresholds {
  /// Threshold used to classify the frame as too dark.
  /// If the calculated lighting score is above this threshold, frame is discarded.
  ///
  /// Allowed values are from 0 to 1. Default: `0.99`
  double? tooDarkThreshold;

  /// Threshold used to classify the frame as too bright.
  /// If the calculated lighting score is above this threshold, frame is discarded.
  ///
  /// Allowed values are from 0 to 1. Default: `0.99`
  double? tooBrightThreshold;

  LightingThresholds();

  factory LightingThresholds.fromJson(Map<String, dynamic> json) =>
      _$LightingThresholdsFromJson(json);
  Map<String, dynamic> toJson() => _$LightingThresholdsToJson(this);
}

/// Defines Capture's UX settings.
@JsonSerializable()
class UxSettings {
  /// Defines whether introduction dialog will be displayed on capture start.
  ///
  /// Default: `false`
  bool? showIntroductionDialog;

  /// Defines whether onboarding (help) screens will be displayed.
  /// If onboarding is disabled, help button and tooltip won't be displayed.
  ///
  /// Default: `true`
  bool? showOnboardingInfo;

  /// Defines whether the screen will be always ON while capture screen is in foreground.
  ///
  /// Default: `true`
  bool? keepScreenOn;

  /// Defines whether to show tooltip above help button.
  ///
  /// Default: `true`
  bool? showCaptureHelpTooltip;

  /// Sets the time in milliseconds that needs to pass before help tooltip is displayed.
  ///
  /// Default: `8000` (8 seconds)
  double? showHelpTooltipTimeIntervalMs;

  /// Duration in milliseconds that needs to pass since scanning of the current document side has begun in order to finish side capture.
  /// Timeout timer is restarted on document side flip.
  ///
  /// Please be aware that time counting does not start from the moment when capture process starts.
  /// Instead it starts from the moment when at least one valid frame candidate for the current document side has entered the analysis queue.
  /// The reason for this is the better user experience in cases when for example timeout is set to 10 seconds and user starts scanning and leaves device lying on table for 9 seconds and then points the device towards the document it wants to capture: in such case it is better to let the user to capture the document.
  /// To disable side capture timeout set it to null.
  ///
  /// Default: `15000` (15 seconds)
  double? sideCaptureTimeoutMs;

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
  /// Represents the preferred camera resolution. It does not mean that exact the same resolution will be selected, but SDK will use the nearest one possible. Actual resolution that will be chosen depends on the actual device hardware (camera resolutions available and processing power).
  ///
  /// See [AndroidCameraResolution] for all options.
  ///
  /// Default: `AndroidCameraResolution.Resolution2160P`
  AndroidCameraResolution androidCameraResolution =
      AndroidCameraResolution.Resolution2160P;

  /// Sets the camera resolution for iOS devices.
  ///
  /// Represents the preferred camera resolution. It does not mean that exact the same resolution will be selected, but SDK will use the nearest one possible. Actual resolution that will be chosen depends on the actual device hardware (camera resolutions available and processing power).
  ///
  /// See [IosCameraResolution] for all options.
  ///
  /// Default: `IosCameraResolution.Resolution1080p`
  IosCameraResolution iosCameraResolution = IosCameraResolution.Resolution1080p;

  CameraSettings();

  factory CameraSettings.fromJson(Map<String, dynamic> json) =>
      _$CameraSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$CameraSettingsToJson(this);
}
