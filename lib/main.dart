import 'package:flutter/material.dart';
import 'package:webviewdemo/common_webview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Material(
        child: CommonWebViewPage(
          url: 'assets/files/aa.html',
        ),
      ),
    );
  }
}

