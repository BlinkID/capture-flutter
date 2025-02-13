// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CaptureSettings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptureSettings _$CaptureSettingsFromJson(Map<String, dynamic> json) =>
    CaptureSettings()
      ..analyzerSettings = json['analyzerSettings'] == null
          ? null
          : AnalyzerSettings.fromJson(
              json['analyzerSettings'] as Map<String, dynamic>)
      ..uxSettings = json['uxSettings'] == null
          ? null
          : UxSettings.fromJson(json['uxSettings'] as Map<String, dynamic>)
      ..cameraSettings = json['cameraSettings'] == null
          ? null
          : CameraSettings.fromJson(
              json['cameraSettings'] as Map<String, dynamic>);

Map<String, dynamic> _$CaptureSettingsToJson(CaptureSettings instance) =>
    <String, dynamic>{
      'analyzerSettings': instance.analyzerSettings,
      'uxSettings': instance.uxSettings,
      'cameraSettings': instance.cameraSettings,
    };

AnalyzerSettings _$AnalyzerSettingsFromJson(Map<String, dynamic> json) =>
    AnalyzerSettings()
      ..captureSingleSide = json['captureSingleSide'] as bool
      ..returnTransformedDocumentImage =
          json['returnTransformedDocumentImage'] as bool
      ..captureStrategy =
          $enumDecode(_$CaptureStrategyEnumMap, json['captureStrategy'])
      ..minimumDocumentDpi = (json['minimumDocumentDpi'] as num).toInt()
      ..adjustMinimumDocumentDpi = json['adjustMinimumDocumentDpi'] as bool
      ..documentFramingMargin =
          (json['documentFramingMargin'] as num).toDouble()
      ..keepMarginOnTransformedDocumentImage =
          json['keepMarginOnTransformedDocumentImage'] as bool
      ..keepDpiOnTransformedDocumentImage =
          json['keepDpiOnTransformedDocumentImage'] as bool
      ..lightingThresholds = LightingThresholds.fromJson(
          json['lightingThresholds'] as Map<String, dynamic>)
      ..blurPolicy = $enumDecode(_$BlurPolicyEnumMap, json['blurPolicy'])
      ..glarePolicy = $enumDecode(_$GlarePolicyEnumMap, json['glarePolicy'])
      ..handOcclusionThreshold =
          (json['handOcclusionThreshold'] as num).toDouble()
      ..tiltPolicy = $enumDecode(_$TiltPolicyEnumMap, json['tiltPolicy'])
      ..enforcedDocumentGroup = $enumDecodeNullable(
          _$EnforcedDocumentGroupEnumMap, json['enforcedDocumentGroup']);

Map<String, dynamic> _$AnalyzerSettingsToJson(AnalyzerSettings instance) =>
    <String, dynamic>{
      'captureSingleSide': instance.captureSingleSide,
      'returnTransformedDocumentImage': instance.returnTransformedDocumentImage,
      'captureStrategy': _$CaptureStrategyEnumMap[instance.captureStrategy]!,
      'minimumDocumentDpi': instance.minimumDocumentDpi,
      'adjustMinimumDocumentDpi': instance.adjustMinimumDocumentDpi,
      'documentFramingMargin': instance.documentFramingMargin,
      'keepMarginOnTransformedDocumentImage':
          instance.keepMarginOnTransformedDocumentImage,
      'keepDpiOnTransformedDocumentImage':
          instance.keepDpiOnTransformedDocumentImage,
      'lightingThresholds': instance.lightingThresholds,
      'blurPolicy': _$BlurPolicyEnumMap[instance.blurPolicy]!,
      'glarePolicy': _$GlarePolicyEnumMap[instance.glarePolicy]!,
      'handOcclusionThreshold': instance.handOcclusionThreshold,
      'tiltPolicy': _$TiltPolicyEnumMap[instance.tiltPolicy]!,
      'enforcedDocumentGroup':
          _$EnforcedDocumentGroupEnumMap[instance.enforcedDocumentGroup],
    };

const _$CaptureStrategyEnumMap = {
  CaptureStrategy.OptimizeForSpeed: 0,
  CaptureStrategy.OptimizeForQuality: 1,
  CaptureStrategy.Default: 2,
  CaptureStrategy.SingleFrame: 3,
};

const _$BlurPolicyEnumMap = {
  BlurPolicy.Disabled: 0,
  BlurPolicy.Strict: 1,
  BlurPolicy.Normal: 2,
  BlurPolicy.Relaxed: 3,
};

const _$GlarePolicyEnumMap = {
  GlarePolicy.Disabled: 0,
  GlarePolicy.Strict: 1,
  GlarePolicy.Normal: 2,
  GlarePolicy.Relaxed: 3,
};

const _$TiltPolicyEnumMap = {
  TiltPolicy.Disabled: 0,
  TiltPolicy.Strict: 1,
  TiltPolicy.Normal: 2,
  TiltPolicy.Relaxed: 3,
};

const _$EnforcedDocumentGroupEnumMap = {
  EnforcedDocumentGroup.Dl: 0,
  EnforcedDocumentGroup.Id: 1,
  EnforcedDocumentGroup.Passport: 2,
  EnforcedDocumentGroup.PassportCard: 3,
  EnforcedDocumentGroup.Visa: 4,
};

LightingThresholds _$LightingThresholdsFromJson(Map<String, dynamic> json) =>
    LightingThresholds()
      ..tooDarkThreshold = (json['tooDarkThreshold'] as num?)?.toDouble()
      ..tooBrightThreshold = (json['tooBrightThreshold'] as num?)?.toDouble();

Map<String, dynamic> _$LightingThresholdsToJson(LightingThresholds instance) =>
    <String, dynamic>{
      'tooDarkThreshold': instance.tooDarkThreshold,
      'tooBrightThreshold': instance.tooBrightThreshold,
    };

UxSettings _$UxSettingsFromJson(Map<String, dynamic> json) => UxSettings()
  ..showIntroductionDialog = json['showIntroductionDialog'] as bool
  ..showOnboardingInfo = json['showOnboardingInfo'] as bool
  ..showHelpTooltipTimeIntervalMs =
      (json['showHelpTooltipTimeIntervalMs'] as num?)?.toDouble()
  ..keepScreenOn = json['keepScreenOn'] as bool?
  ..sideCaptureTimeoutMs = (json['sideCaptureTimeoutMs'] as num?)?.toDouble();

Map<String, dynamic> _$UxSettingsToJson(UxSettings instance) =>
    <String, dynamic>{
      'showIntroductionDialog': instance.showIntroductionDialog,
      'showOnboardingInfo': instance.showOnboardingInfo,
      'showHelpTooltipTimeIntervalMs': instance.showHelpTooltipTimeIntervalMs,
      'keepScreenOn': instance.keepScreenOn,
      'sideCaptureTimeoutMs': instance.sideCaptureTimeoutMs,
    };

CameraSettings _$CameraSettingsFromJson(Map<String, dynamic> json) =>
    CameraSettings()
      ..androidCameraResolution = $enumDecode(
          _$AndroidCameraResolutionEnumMap, json['androidCameraResolution'])
      ..iosCameraResolution = $enumDecode(
          _$IosCameraResolutionEnumMap, json['iosCameraResolution']);

Map<String, dynamic> _$CameraSettingsToJson(CameraSettings instance) =>
    <String, dynamic>{
      'androidCameraResolution':
          _$AndroidCameraResolutionEnumMap[instance.androidCameraResolution]!,
      'iosCameraResolution':
          _$IosCameraResolutionEnumMap[instance.iosCameraResolution]!,
    };

const _$AndroidCameraResolutionEnumMap = {
  AndroidCameraResolution.Resolution1080P: 0,
  AndroidCameraResolution.Resolution2160P: 1,
  AndroidCameraResolution.Resolution4320P: 2,
};

const _$IosCameraResolutionEnumMap = {
  IosCameraResolution.Resolution1080p: 0,
  IosCameraResolution.Resolution4K: 1,
};
