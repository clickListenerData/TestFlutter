

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class WebViewPage extends StatelessWidget {

  String title;
  String url;
  WebViewPage(this.title,this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WebView.platform = AndroidWebView();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      // body: WebviewScaffold(url: url,
      //   withZoom: false,
      //   withLocalStorage: true,
      //   hidden: true,
      //   withJavascript: true,),
      body: WebView(
        initialUrl: url,
      ),
    );
  }

}