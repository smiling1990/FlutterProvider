/**
 *
 * Name: Eddie
 * Email: enguagns@parcelsanta.com
 * Homepage: https://juejin.im/user/5acd7f706fb9a028d375c045
 *
 */

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Created On 2019/12/5
/// Description: Url Web Page
///
class WebViewPage extends StatefulWidget {
  /// URL
  final String url;
  final String title;

  WebViewPage(this.url, {this.title});

  @override
  WebViewPageState createState() => WebViewPageState(url, title);
}

class WebViewPageState extends State<WebViewPage> {
  /// URL
  String url, title;

  /// WebViewController
  WebViewController _controller;

  WebViewPageState(this.url, this.title);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title ?? 'Detail'),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) => _controller = controller,
        onPageFinished: (url) {
          _controller.evaluateJavascript('document.title').then((result) {
            setState(() => title = result);
          });
        },
      ),
    );
  }
}
