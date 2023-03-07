import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../webview/menu.dart';
import '../webview/navigation_controls.dart';
import '../widgets/web_view_stack.dart';

class InAppWebBrowser extends StatefulWidget {
  // const InAppWebBrowser(data, {Key? key}) : super(key: key);
  InAppWebBrowser(this.webLink,{super.key});
  final String webLink;

  @override
  State<InAppWebBrowser> createState() => _InAppWebBrowserState();
}

class _InAppWebBrowserState extends State<InAppWebBrowser> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.webLink),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("In App Browser"),
        actions: [
          NavigationControls(controller: controller),
          Menu(controller: controller),
        ],
      ),
      body: WebViewStack(controller: controller),
    );
  }
}
