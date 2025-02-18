import 'package:json_annotation/json_annotation.dart';
import 'package:capture_flutter/capture_enums.dart';
part 'package:capture_flutter/capture_settings.g.dart';

@JsonSerializable()
class CaptureSettings {
  AnalyzerSettings? analyzerSettings = AnalyzerSettings();
  UxSettings? uxSettings = UxSettings();
  CameraSettings? cameraSettings = CameraSettings();

  CaptureSettings();

  factory CaptureSettings.fromJson(Map<String, dynamic> json) =>
      _$CaptureSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$CaptureSettingsToJson(this);
}

@JsonSerializable()
class AnalyzerSettings {
  bool? captureSingleSide;

  bool? returnTransformedDocumentImage;

  CaptureStrategy? captureStrategy;

  int? minimumDocumentDpi;

  bool? adjustMinimumDocumentDpi;

  double? documentFramingMargin;

  bool? keepMarginOnTransformedDocumentImage;

  bool? keepDpiOnTransformedDocumentImage;

  LightingThresholds? lightingThresholds = LightingThresholds();

  BlurPolicy? blurPolicy;

  GlarePolicy? glarePolicy;

  double? handOcclusionThreshold;

  TiltPolicy? tiltPolicy;

  EnforcedDocumentGroup? enforcedDocumentGroup;

  AnalyzerSettings();

  factory AnalyzerSettings.fromJson(Map<String, dynamic> json) =>
      _$AnalyzerSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$AnalyzerSettingsToJson(this);
}

@JsonSerializable()
class LightingThresholds {
  double? tooDarkThreshold;

  double? tooBrightThreshold;

  LightingThresholds();

  factory LightingThresholds.fromJson(Map<String, dynamic> json) =>
      _$LightingThresholdsFromJson(json);
  Map<String, dynamic> toJson() => _$LightingThresholdsToJson(this);
}

@JsonSerializable()
class UxSettings {
  bool? showIntroductionDialog;
  bool? showOnboardingInfo;
  bool? keepScreenOn;
  bool? showCaptureHelpTooltip;
  double? showHelpTooltipTimeIntervalMs;
  double? sideCaptureTimeoutMs;

  UxSettings();

  factory UxSettings.fromJson(Map<String, dynamic> json) =>
      _$UxSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$UxSettingsToJson(this);
}

@JsonSerializable()
class CameraSettings {
  AndroidCameraResolution androidCameraResolution =
      AndroidCameraResolution.Resolution2160P;
  IosCameraResolution iosCameraResolution = IosCameraResolution.Resolution1080p;

  CameraSettings();

  factory CameraSettings.fromJson(Map<String, dynamic> json) =>
      _$CameraSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$CameraSettingsToJson(this);
}
