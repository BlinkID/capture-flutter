import 'CaptureEnums.dart';
import 'package:json_annotation/json_annotation.dart';

class AnalyzerResult {
  SideCaptureResult? firstCapture;
  SideCaptureResult? secondCapture;
  DocumentGroup? documentGroup;
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

class SideCaptureResult {
  String? capturedImage;
  String? transformedImage;
  DocumentSide? side;
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
