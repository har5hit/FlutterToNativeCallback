/*
 * Created by Harshith Shetty on 4/4/19 7:18 PM.
 * Copyright (c) 2019 People Interactive. All rights reserved.
 *
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(WebViewApp());

class WebViewApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  WebViewScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  static const channel = MethodChannel('webview');

  final keysToCollect = ["q"];

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((url) {
      var uri = Uri.parse(url);
      final valueCollector = [];
      uri.queryParameters.entries.forEach((entry) {
        if (keysToCollect.contains(entry.key)) {
          valueCollector.add(entry.value);
        }
      });
      debugPrint("url changed" + url);
      debugPrint("collected" + valueCollector.toString());
      channel.invokeListMethod("urlParams", valueCollector);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: "https://www.google.com",
    );
  }
}
