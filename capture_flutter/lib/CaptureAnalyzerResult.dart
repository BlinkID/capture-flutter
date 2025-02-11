import 'CaptureEnums.dart';

class AnalyzerResult {
  SideCaptureResult? firstCapture;
  SideCaptureResult? secondCapture;
  DocumentGroup? documentGroup;
  CompletnessStatus? completnessStatus;
}

class SideCaptureResult {
  String? capturedImage;
  String? transformedImage;
  DocumentSide? side;
  bool? dpiAdjusted;
}
