
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(
        [
          SystemUiOverlay.bottom,
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,

        ),
        extendBodyBehindAppBar: true,
        body:   WebviewScaffold(url: 'http://ecommerce.codepickles.com')
    );
  }
}
