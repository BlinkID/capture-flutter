import 'package:capture_flutter/CaptureSettings.dart';
import 'package:flutter/material.dart';
import "dart:convert";
import "dart:async";
import 'package:flutter/services.dart';
import 'package:capture_flutter/capture_flutter_method_channel.dart';
import 'dart:typed_data';
import 'package:capture_flutter/CaptureEnums.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List? firstCapturedImage;
  Uint8List? firstTransformedImage;
  Uint8List? secondCapturedImage;
  Uint8List? secondTransformedImage;

  Future<void> scan() async {
    try {
      // setup Capture settings
      final settings = CaptureSettings();

      // modify UX settings
      settings.uxSettings?.showOnboardingInfo = true;
      settings.uxSettings?.showIntroductionDialog = true;
      settings.uxSettings?.showHelpTooltipTimeIntervalMs = 2000;

      // modify Analyzer settings
      settings.analyzerSettings?.captureStrategy = CaptureStrategy.Default;
      settings.analyzerSettings?.documentFramingMargin = 0.3;
      settings.analyzerSettings?.keepMarginOnTransformedDocumentImage = true;
      settings.analyzerSettings?.enforcedDocumentGroup =
          EnforcedDocumentGroup.Id;
      settings.analyzerSettings?.lightingThresholds.tooBrightThreshold = 0.99;
      settings.analyzerSettings?.lightingThresholds.tooDarkThreshold = 0.99;

      // modify Camera settings
      settings.cameraSettings?.iosCameraResolution =
          IosCameraResolution.Resolution4K;

      // add the license key
      const licenseKey =
          "sRwCABVjb20ubWljcm9ibGluay5zYW1wbGUBbGV5SkRjbVZoZEdWa1QyNGlPakUzTXprek56UXdNRFl4TkRZc0lrTnlaV0YwWldSR2IzSWlPaUprWkdRd05qWmxaaTAxT0RJekxUUXdNRGd0T1RRNE1DMDFORFU0WWpBeFlUVTJZamdpZlE9PVyRo/fMJzpMKHViG4GWa1iSirSGrTw11h21H9wLUUNyCMY4xwFVRwRT/iYkk/hAVe5SdUg51YahxV9qkzRLg5IPb/3XtrmAdlhRGMfhENSIkOEOyoVWO4IsmzYuY2g=";

      // add the license key and the Capture settings in the scanWithCamera method
      var results = await MethodChannelCaptureFlutter.scanWithCamera(
          settings, licenseKey);
      // get the results
      if (results?.completnessStatus != CompletnessStatus.Empty) {
        setState(() {
          firstCapturedImage =
              base64Decode(getImage(results?.firstCapture?.capturedImage));
          firstTransformedImage =
              base64Decode(getImage(results?.firstCapture?.transformedImage));
          secondCapturedImage =
              base64Decode(getImage(results?.secondCapture?.capturedImage));
          secondTransformedImage =
              base64Decode(getImage(results?.secondCapture?.transformedImage));
        });
      }
    } catch (captureError) {
      if (captureError is PlatformException) {
        setState(() {
          showAlert(context, captureError.code, captureError.message!);
        });
      }
    }
  }

  String getImage(String? base64Image) {
    if (base64Image != null) {
      return base64Image;
    }
    return "";
  }

  void showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Capture Sample"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    onPressed: scan,
                    child: Text("Scan with camera"),
                  ),
                ),
              ),
              if (firstCapturedImage != null) ...[
                Text("First Capture - Original"),
                Image.memory(firstCapturedImage!),
              ],
              if (firstTransformedImage != null) ...[
                Text("First Capture - Transformed"),
                Image.memory(firstTransformedImage!),
              ],
              if (secondCapturedImage != null) ...[
                Text("Second Capture - Original"),
                Image.memory(secondCapturedImage!),
              ],
              if (secondTransformedImage != null) ...[
                Text("Second Capture - Transformed"),
                Image.memory(secondTransformedImage!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
