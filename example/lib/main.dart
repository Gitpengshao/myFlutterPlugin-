import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:batterylevel/batterylevel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  final _batterylevelPlugin = Batterylevel();

  // 电量
  String batteryLevel = '';

  String _androidFlutterValue = '111';
  String _intentResultView = '111';

  // 获取电量
  Future<void> getBatteryLevel() async {
    try {
      int res = await _batterylevelPlugin.getBatteryLevel() ?? 0;
      batteryLevel = res.toString();
    } on PlatformException {
      batteryLevel = 'Failed to get battery level.';
    }
    // 更新
    setState(() {});
  }

  Future<void> _getValueByAndroid() async {
    String? value;
    try {
      value = await _batterylevelPlugin.getValueByAndroid('tag哈哈哈Flutter');
    } on PlatformException {
      value = 'Failed to get value';
    }
    if (!mounted) return;
    setState(() {
      _androidFlutterValue = value ?? '';
    });
  }

  Future<void> _intentToAndroidView() async {
    String? value;
    try {
      value = await _batterylevelPlugin.intentToAndroidView('tag哈哈哈Flutter');
    } on PlatformException {
      value = 'Failed to get value';
    }
    if (!mounted) return;
    setState(() {
      _intentResultView = value ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _batterylevelPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            Text('电量：$batteryLevel\n'),
            ElevatedButton(
                onPressed: () {
                  getBatteryLevel();
                },
                child: const Text("获取电量")),
            TextButton(
                onPressed: () {
                  _getValueByAndroid();
                },
                child: Text(_androidFlutterValue)),
            TextButton(
                onPressed: () {
                  _intentToAndroidView();
                },
                child: Text(_intentResultView))
          ],
        ),
      ),
    );
  }
}
