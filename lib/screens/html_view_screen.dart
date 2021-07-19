import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlViewScreen extends StatefulWidget {
  @override
  _HtmlViewScreenState createState() => _HtmlViewScreenState();
}

class _HtmlViewScreenState extends State<HtmlViewScreen> {
  WebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('WebView'))),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: '',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;
                _loadHtmlFromAssets();
              },
            ),
          ),
          MaterialButton(child: Text("PDF"), onPressed: () {})
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller!
              .evaluateJavascript('value("Antony", "Alexia", "Female")');
        },
        child: Icon(Icons.add),
      ),
    );
  }

  _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/web.html');
    _controller!.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
