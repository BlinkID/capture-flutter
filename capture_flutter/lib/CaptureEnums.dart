import 'package:json_annotation/json_annotation.dart';

enum DocumentSide {
  @JsonValue(0)
  Unknown,

  @JsonValue(1)
  Front,

  @JsonValue(2)
  Back
}

enum DocumentGroup {
  @JsonValue(0)
  Unknown,

  @JsonValue(1)
  DL,

  @JsonValue(2)
  ID,

  @JsonValue(3)
  Passport,

  @JsonValue(4)
  PassportCard,

  @JsonValue(5)
  Visa
}

enum CompletnessStatus {
  @JsonValue(0)
  Empty,

  @JsonValue(1)
  OneSideMissing,

  @JsonValue(2)
  Complete
}

enum CaptureStrategy {
  @JsonValue(0)
  OptimizeForSpeed,

  @JsonValue(1)
  OptimizeForQuality,

  @JsonValue(2)
  Default,

  @JsonValue(3)
  SingleFrame
}

enum BlurPolicy {
  @JsonValue(0)
  Disabled,

  @JsonValue(1)
  Strict,

  @JsonValue(2)
  Normal,

  @JsonValue(3)
  Relaxed
}

enum GlarePolicy {
  @JsonValue(0)
  Disabled,

  @JsonValue(1)
  Strict,

  @JsonValue(2)
  Normal,

  @JsonValue(3)
  Relaxed
}

enum TiltPolicy {
  @JsonValue(0)
  Disabled,

  @JsonValue(1)
  Strict,

  @JsonValue(2)
  Normal,

  @JsonValue(3)
  Relaxed
}

enum EnforcedDocumentGroup {
  @JsonValue(0)
  Dl,

  @JsonValue(1)
  Id,

  @JsonValue(2)
  Passport,

  @JsonValue(3)
  PassportCard,

  @JsonValue(4)
  Visa
}

enum CameraResolution {
  @JsonValue(0)
  RESOLUTION_1080_P,

  @JsonValue(1)
  RESOLUTION_2160_P,

  @JsonValue(2)
  RESOLUTION_4320_P
}
