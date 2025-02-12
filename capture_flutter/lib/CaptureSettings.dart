import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';
import 'CaptureEnums.dart';

part 'CaptureSettings.g.dart';

@JsonSerializable()
class CaptureSettings {
  AnalyzerSettings? analyzerSettings = AnalyzerSettings();
  UxSettings? uxSettings = UxSettings();
  CameraSettings? cameraSettings = CameraSettings();
  //FilterSettings? filterSettings;
  //CaptureOverlayStringSettings? stringSettings;

  CaptureSettings();

  factory CaptureSettings.fromJson(Map<String, dynamic> json) =>
      _$CaptureSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$CaptureSettingsToJson(this);
}

@JsonSerializable()
class AnalyzerSettings {
  bool captureSingleSide = false;
  bool returnTransformedDocumentImage = true;
  CaptureStrategy captureStrategy = CaptureStrategy.Default;
  int minimumDocumentDpi = 230;
  bool adjustMinimumDocumentDpi = true;
  double documentFramingMargin = 0.01;
  bool keepMarginOnTransformedDocumentImage = false;
  bool keepDpiOnTransformedDocumentImage = false;
  LightingThresholds lightingThresholds = LightingThresholds();
  BlurPolicy blurPolicy = BlurPolicy.Normal;
  GlarePolicy glarePolicy = GlarePolicy.Normal;
  double handOcclusionThreshold = 0.05;
  TiltPolicy tiltPolicy = TiltPolicy.Normal;
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
  bool showIntroductionDialog = false;
  bool showOnboardingInfo = true;
  double? showHelpTooltipTimeIntervalMs;
  bool? keepScreenOn = true;
  double? sideCaptureTimeoutMs;

  UxSettings();

  factory UxSettings.fromJson(Map<String, dynamic> json) =>
      _$UxSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$UxSettingsToJson(this);
}

@JsonSerializable()
class CameraSettings {
  CameraResolution cameraResolution = CameraResolution.RESOLUTION_2160_P;

  CameraSettings();

  factory CameraSettings.fromJson(Map<String, dynamic> json) =>
      _$CameraSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$CameraSettingsToJson(this);
}

class FilterSettings {
  //TODO: Implement FilterSettings
}

class CaptureOverlayStringSettings {
  String? flashlightWarning;
  String? helpTooltip;
  /**
   * TODO: Implement the following string classes:
   * val onboardingStrings: OnboardingStrings = OnboardingStrings(), 
   * val instructionsStrings: InstructionsStrings = InstructionsStrings(), 
   * val alertStrings: AlertStrings = AlertStrings() 
   * */
}
