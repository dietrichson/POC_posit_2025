import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RIntegrationPage extends StatefulWidget {
  const RIntegrationPage({super.key});

  @override
  State<RIntegrationPage> createState() => _RIntegrationPageState();
}

class _RIntegrationPageState extends State<RIntegrationPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset('assets/webR/webR.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('R-wasm Integration')),
      body: WebViewWidget(controller: _controller),
    );
  }
}
