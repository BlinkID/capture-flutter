import 'dart:ffi';
import 'CaptureEnums.dart';

class CaptureSettings {
  AnalyzerSettings? analyzerSettings;
  UxSettings? uxSettings;
  CameraSettings? cameraSettings;
  FilterSettings? filterSettings;
  CaptureOverlayStringSettings? stringSettings;
}

class AnalyzerSettings {
  bool? captureSingleSide;
  bool? returnTransformedDocumentImage;
  CaptureStrategy? captureStrategy;
  int? minimumDocumentDpi;
  bool? adjustMinimumDocumentDpi;
  Float? documentFramingMargin;
  bool? keepMarginOnTransformedDocumentImage;
  bool? keepDpiOnTransformedDocumentImage;
  LightingThresholds? lightingThresholds;
  BlurPolicy? blurPolicy;
  GlarePolicy? glarePolicy;
  Float? handOcclusionThreshold;
  TiltPolicy? tiltPolicy;
  EnforcedDocumentGroup? enforcedDocumentGroup;
}

class LightingThresholds {
  Float? tooDarkThreshold;
  Float? tooBrightThreshold;
}

class UxSettings {
  bool? showIntroductionDialog;
  bool? showOnboardingInfo;
  double? showHelpTooltipTimeIntervalMs;
  bool? keepScreenOn;
  double? sideCaptureTimeoutMs;
}

class CameraSettings {
  CameraResolution? cameraResolution;
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
