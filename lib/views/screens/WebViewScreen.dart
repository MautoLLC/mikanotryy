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
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Mikano shop',
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Roboto',
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              child: Container(
                color: Colors.orange,
                height: 0.0,
              ),
              preferredSize: Size.fromHeight(0.0)),
        ),
        extendBodyBehindAppBar: true,
        body: WebviewScaffold(
            url: 'https://ecommerce.codepickles.com/newproducts'));
  }
}
