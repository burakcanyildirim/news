import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewsScreen extends StatefulWidget {
  String url;

  WebViewsScreen({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewsScreen> createState() => _WebViewsScreenState();
}

class _WebViewsScreenState extends State<WebViewsScreen> {
  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          print("WebView is loading (progress : $progress%)");
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: WebViewWidget(
      controller: controller..loadRequest(Uri.parse(widget.url)),
    ));
  }
}
