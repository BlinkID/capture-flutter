import 'package:capture_flutter/capture_flutter.dart';
import 'package:flutter/material.dart';
import "dart:convert";
import "dart:async";
import 'package:flutter/services.dart';
import 'package:capture_flutter/capture_flutter_method_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> scan() async {
    var results = await MethodChannelCaptureFlutter.scanWithCamera();
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
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      onPressed: () => scan(),
                      child: Text("Scan with camera"),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
