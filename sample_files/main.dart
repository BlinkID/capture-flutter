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
    var results = await MethodChannelCaptureFlutter.scanWithCamera();

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
  }

  String getImage(String? base64Image) {
    if (base64Image != null) {
      return base64Image;
    }
    return "";
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
