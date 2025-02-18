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
  None,

  @JsonValue(1)
  Dl,

  @JsonValue(2)
  Id,

  @JsonValue(3)
  Passport,

  @JsonValue(4)
  PassportCard,

  @JsonValue(5)
  Visa
}

enum AndroidCameraResolution {
  @JsonValue(0)
  Resolution1080P,

  @JsonValue(1)
  Resolution2160P,

  @JsonValue(2)
  Resolution4320P
}

enum IosCameraResolution {
  @JsonValue(0)
  Resolution1080p,

  @JsonValue(1)
  Resolution4K
}
