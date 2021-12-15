import 'package:flutter/material.dart';
import 'dart:async';

import 'package:package_signature/package_signature.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _signatureSha256 = 'Unknown';
  String _signatureSha256Hex = 'Unknown';
  String _signatureSha1 = 'Unknown';
  String _signatureSha1Hex = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    Signature signature = await PackageSignature.signature;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _signatureSha256 = signature.sha256;
      _signatureSha256Hex = signature.sha256Hex;
      _signatureSha1 = signature.sha1;
      _signatureSha1Hex = signature.sha1Hex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("App Signature"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SHA256",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(_signatureSha256),
              const SizedBox(height: 12),
              Text(
                "SHA256Hex",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(_signatureSha256Hex),
              const SizedBox(height: 12),
              Text(
                "SHA1",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(_signatureSha1),
              const SizedBox(height: 12),
              Text(
                "SHA1 Hex",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(_signatureSha1Hex),
            ],
          ),
        ),
      ),
    );
  }
}
