import 'package:flutter/material.dart';
import "dart:convert";
import "dart:async";
import 'package:flutter/services.dart';
import 'package:capture_flutter/capture_flutter.dart';
import 'package:capture_flutter/capture_settings.dart';
import 'package:capture_flutter/capture_enums.dart';
import 'package:capture_flutter/capture_analyzer_result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String resultString = "";
  Uint8List? firstCapturedImage;
  Uint8List? firstTransformedImage;
  Uint8List? secondCapturedImage;
  Uint8List? secondTransformedImage;

  Future<void> scan() async {
    try {
      // initialize Capture plugin
      final capturePlugin = CaptureFlutter();

      // setup Capture settings
      final settings = CaptureSettings();

      // modify UX settings
      settings.uxSettings?.showOnboardingInfo = true;
      settings.uxSettings?.showIntroductionDialog = true;
      settings.uxSettings?.showHelpTooltipTimeIntervalMs = 2000;

      // modify Analyzer settings
      settings.analyzerSettings?.captureStrategy = CaptureStrategy.Default;
      settings.analyzerSettings?.documentFramingMargin = 0.01;
      settings.analyzerSettings?.keepMarginOnTransformedDocumentImage = true;
      settings.analyzerSettings?.enforcedDocumentGroup =
          EnforcedDocumentGroup.None;

      // modify Camera settings
      settings.cameraSettings?.iosCameraResolution =
          IosCameraResolution.Resolution1080p;
      settings.cameraSettings?.androidCameraResolution =
          AndroidCameraResolution.Resolution2160P;

      // add the license key
      var licenseKey = "";
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        licenseKey =
            "sRwCABVjb20ubWljcm9ibGluay5zYW1wbGUBbGV5SkRjbVZoZEdWa1QyNGlPakUzTXprek56UXdNRFl4TkRZc0lrTnlaV0YwWldSR2IzSWlPaUprWkdRd05qWmxaaTAxT0RJekxUUXdNRGd0T1RRNE1DMDFORFU0WWpBeFlUVTJZamdpZlE9PVyRo/fMJzpMKHViG4GWa1iSirSGrTw11h21H9wLUUNyCMY4xwFVRwRT/iYkk/hAVe5SdUg51YahxV9qkzRLg5IPb/3XtrmAdlhRGMfhENSIkOEOyoVWO4IsmzYuY2g=";
      } else if (Theme.of(context).platform == TargetPlatform.android) {
        licenseKey =
            'sRwCABVjb20ubWljcm9ibGluay5zYW1wbGUAbGV5SkRjbVZoZEdWa1QyNGlPakUzTXprMU1qZ3pPRE14TWpNc0lrTnlaV0YwWldSR2IzSWlPaUprWkdRd05qWmxaaTAxT0RJekxUUXdNRGd0T1RRNE1DMDFORFU0WWpBeFlUVTJZamdpZlE9PXUNwFYL3KiIFimEF74euSD7BFdYifhniKxgQtOvgSVsgSYaMY5zXE/LuD3nnaYmn9x7s+lLITCzAb6LOwET5Q6kuu0B3zfdItakTgq2kBU07v2MrCnPk6g9wIY6nQw=';
      } else {
        licenseKey = "";
      }

      // add the license key and the Capture settings in the scanWithCamera method
      var results = await capturePlugin.scanWithCamera(settings, licenseKey);

      // get the results
      if (results?.completnessStatus == CompletenessStatus.Complete) {
        setState(() {
          resultString = getCaptureStringResult(results);
          firstCapturedImage = base64Decode(
            getImage(results?.firstCapture?.capturedImage),
          );
          firstTransformedImage = base64Decode(
            getImage(results?.firstCapture?.transformedImage),
          );

          if (results?.secondCapture?.capturedImage != null) {
            secondCapturedImage = base64Decode(
              getImage(results?.secondCapture?.capturedImage),
            );
            secondTransformedImage = base64Decode(
              getImage(results?.secondCapture?.transformedImage),
            );
          } else {
            secondCapturedImage = null;
            secondTransformedImage = null;
          }
        });
      }
    } catch (captureError) {
      if (captureError is PlatformException) {
        var message = captureError.message;
        setState(() {
          resultString = "Capture error: $message";
          firstCapturedImage = null;
          firstTransformedImage = null;
          secondCapturedImage = null;
          secondTransformedImage = null;
        });
      }
    }
  }

  String getImage(String? base64String) {
    if (base64String == null || base64String.isEmpty) {
      return "";
    }
    final cleanedBase64 = base64String.replaceAll(RegExp(r'\s'), '');
    return cleanedBase64;
  }

  String getCaptureStringResult(AnalyzerResult? result) {
    return buildAnalyzerResult(
          result?.completnessStatus,
          "Completeness status",
        ) +
        buildAnalyzerResult(result?.documentGroup, "Document group") +
        buildAnalyzerResult(result?.firstCapture?.side, "First capture side") +
        buildAnalyzerResult(
          result?.firstCapture?.dpiAdjusted,
          "First capture DPI adjusted",
        ) +
        buildAnalyzerResult(
          result?.secondCapture?.side,
          "Second capture side",
        ) +
        buildAnalyzerResult(
          result?.secondCapture?.dpiAdjusted,
          "Second capture DPI adjusted",
        );
  }

  String buildAnalyzerResult(dynamic result, String propertyName) {
    if (result == null || result == "") {
      return "";
    }
    return "$propertyName: $result\n";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Capture Sample")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: scan,
                    child: const Text("Scan with camera"),
                  ),
                ),
              ),
              Text(resultString),
              if (firstCapturedImage != null) ...[
                const Text("First Capture - Captured Image"),
                Image.memory(firstCapturedImage!),
              ],
              if (firstTransformedImage != null) ...[
                const Text("First Capture - Transformed Image"),
                Image.memory(firstTransformedImage!),
              ],
              if (secondCapturedImage != null) ...[
                const Text("Second Capture - Captured Image"),
                Image.memory(secondCapturedImage!),
              ],
              if (secondTransformedImage != null) ...[
                const Text("Second Capture - Transformed Image"),
                Image.memory(secondTransformedImage!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
