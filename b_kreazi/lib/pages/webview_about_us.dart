import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewAboutUs extends StatefulWidget {
  const WebViewAboutUs({super.key, required this.title, required this.url});
  
  final String title;
  final String url;

  @override
  State<WebViewAboutUs> createState() => _WebViewAboutUsState();
}

class _WebViewAboutUsState extends State<WebViewAboutUs> {
  @override
  void initState() {
    super.initState();

    // enable virtual display
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView - ${widget.title}'),
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close_rounded),
          splashRadius: 12,
        ),
      ),
      body: SafeArea(
        child: WebView(initialUrl: widget.url, javascriptMode: JavascriptMode.unrestricted,)
      ),
    );
  }
}