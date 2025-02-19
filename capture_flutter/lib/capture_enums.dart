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

/// CaptureStrategy is used for selecting the strategy for capturing the best frame.
/// Used in [AnalyzerSettings] when setting [CaptureSettings].
enum CaptureStrategy {
  /// Analysis is faster, but it is possible to capture frames with lower quality.
  @JsonValue(0)
  OptimizeForSpeed,

  /// Analysis is slower in order to capture high quality frames.
  @JsonValue(1)
  OptimizeForQuality,

  /// The default Capture strategy.
  /// Trade-off for quality and speed.
  @JsonValue(2)
  Default,

  /// Captures first acceptable frame.
  @JsonValue(3)
  SingleFrame
}

/// Policy used to discard frames with blurred documents.
/// Used in [AnalyzerSettings] when setting [CaptureSettings].
enum BlurPolicy {
  /// Disables blur detection.
  @JsonValue(0)
  Disabled,

  /// Strict blur detection.
  /// Enables capture of documents with minimum blur degradation.
  @JsonValue(1)
  Strict,

  /// Default Blur policy.
  /// Trade-off between strict and relaxed.
  @JsonValue(2)
  Normal,

  /// Relaxed blur detection.
  /// Enables capture of documents with relaxed blur degradation,
  /// allowing capture of more blurry documents.
  @JsonValue(3)
  Relaxed
}

/// Policy used to discard frames with glare detected on the document.
/// Used in [AnalyzerSettings] when setting [CaptureSettings].
enum GlarePolicy {
  /// Disables glare detection
  @JsonValue(0)
  Disabled,

  /// Strict glare detection.
  /// Enables capture of documents with minimum glare degradation.
  @JsonValue(1)
  Strict,

  /// Default Glare policy
  /// Trade-off for strict and relaxed.
  @JsonValue(2)
  Normal,

  /// Relaxed glare detection.
  /// Enables capture of documents with relaxed glare detection,
  /// allowing capture of documents with more glare.
  @JsonValue(3)
  Relaxed
}

/// Policy used to detect tilted documents.
/// Used in [AnalyzerSettings] when setting [CaptureSettings].
enum TiltPolicy {
  /// Disables tilt detection.
  @JsonValue(0)
  Disabled,

  /// Strict tilt detection.
  /// Enables capture of document with minimum tilt tolerance.
  @JsonValue(1)
  Strict,

  /// Default Tilt policy
  /// Trade-off for strict and relaxed.
  @JsonValue(2)
  Normal,

  /// Relaxed tilt detection.
  /// Enables capture of documents with higher tilt tolerance.
  @JsonValue(3)
  Relaxed
}

/// Enforces a specific document group, overriding the analyzer’s document classification.
/// Used in [AnalyzerSettings] when setting [CaptureSettings].
enum EnforcedDocumentGroup {
  /// Disables enforing specific document groups
  /// Default EnforcedDocumentGroup.
  @JsonValue(0)
  None,

  /// Enforces drivers license document groups.
  @JsonValue(1)
  Dl,

  /// Enforces ID document groups.
  @JsonValue(2)
  Id,

  /// Enforces passport document groups.
  @JsonValue(3)
  Passport,

  /// Enforces passport card document groups.
  @JsonValue(4)
  PassportCard,

  /// Enforces VISA document groups.
  @JsonValue(5)
  Visa
}

/// Sets the camera resolution for Android devices.
/// Used in [CameraSettings] when setting [CaptureSettings].
enum AndroidCameraResolution {
  /// Sets the camera resolution nearest to 1080p on the Android device
  @JsonValue(0)
  Resolution1080P,

  /// Sets the camera resolution nearest to 2160p on the Android device
  /// Default camera resolution for Android devices
  @JsonValue(1)
  Resolution2160P,

  /// Sets the camera resolution nearest to 4320p on the Android device
  @JsonValue(2)
  Resolution4320P
}

/// Sets the camera resolution for iOS devices.
/// Used in [CameraSettings] when setting [CaptureSettings].
enum IosCameraResolution {
  /// Sets the camera resolution nearest to 1080p on the iOS device
  /// Default camera resolution for iOS devices
  @JsonValue(0)
  Resolution1080p,

  /// Sets the camera resolution nearest to 4K on the iOS device
  @JsonValue(1)
  Resolution4K
}
