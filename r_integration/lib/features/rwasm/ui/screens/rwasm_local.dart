import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RIntegrationLocalPage extends StatefulWidget {
  const RIntegrationLocalPage({super.key});

  @override
  State<RIntegrationLocalPage> createState() => _RIntegrationLocalPageState();
}

class _RIntegrationLocalPageState extends State<RIntegrationLocalPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      //  ..loadRequest(Uri.parse('http://www.nyt.com'));
      ..loadRequest(Uri.parse('http://127.0.0.1:8080'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('R-wasm Integration')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
