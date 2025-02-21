import 'capture_enums.dart';

/// The result of the capture analysis.
/// Contains the information about each document side,
/// completness status of the capture process, and the document group.
class AnalyzerResult {
  /// Contains the result of the first side capture.
  /// See [SideCaptureResult] for more detailed information.
  SideCaptureResult? firstCapture;

  /// Contains the result of the second side capture.
  /// See [SideCaptureResult] for more detailed information.
  SideCaptureResult? secondCapture;

  /// Contains the information about the document group classification.
  /// See [DocumentGroup] enum for more information
  DocumentGroup? documentGroup;

  /// Contains the completeness status of the capture process.
  /// See [CompletnessStatus] for more information.
  CompletnessStatus? completnessStatus;

  AnalyzerResult(Map<String, dynamic> nativeAnalyzerResult) {
    this.firstCapture = nativeAnalyzerResult['nativeFirstCapture'] != null
        ? SideCaptureResult(Map<String, dynamic>.from(
            nativeAnalyzerResult['nativeFirstCapture']))
        : null;
    this.secondCapture = nativeAnalyzerResult['nativeSecondCapture'] != null
        ? SideCaptureResult(Map<String, dynamic>.from(
            nativeAnalyzerResult['nativeSecondCapture']))
        : null;
    this.documentGroup =
        DocumentGroup.values[nativeAnalyzerResult['nativeDocumentGroup']];
    this.completnessStatus = CompletnessStatus
        .values[nativeAnalyzerResult['nativeCompletnessStatus']];
  }
}

/// Result of the document side capture.
class SideCaptureResult {
  /// Contains the original image of the captured document,
  /// untransformed, as it was used in analysis.
  String? capturedImage;

  /// Contains the image of a cropped and perspective-corrected document.
  /// Transformed image is returned in the correct orientation.
  String? transformedImage;

  /// Contains the document side classification.
  /// If side classification was uncertain, `Unknown` is returned.
  /// See [DocumentSide] enum for more detailed information.
  DocumentSide? side;

  /// Indicates whether DPI was adjusted.
  /// If document is captured at lower dpi than the `minimumDocumentDpi` in [AnalyzerSettings], the property is set to `true`.
  bool? dpiAdjusted;

  SideCaptureResult(Map<String, dynamic> nativeCaptureResult) {
    this.capturedImage = nativeCaptureResult['nativeCapturedImage'] != null
        ? nativeCaptureResult['nativeCapturedImage']
        : null;
    this.transformedImage =
        nativeCaptureResult['nativeTransformedImage'] != null
            ? nativeCaptureResult['nativeTransformedImage']
            : null;
    this.side = nativeCaptureResult['nativeSide'] != null
        ? DocumentSide.values[nativeCaptureResult['nativeSide']]
        : null;
    this.dpiAdjusted = nativeCaptureResult['nativeDpiAdjusted'] != null
        ? nativeCaptureResult['nativeDpiAdjusted']
        : null;
  }
}
