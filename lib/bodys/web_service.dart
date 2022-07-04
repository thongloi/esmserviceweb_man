import 'dart:io';

import 'package:esmserviceweb/widgets/show_text.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebService extends StatefulWidget {
  const WebService({Key? key}) : super(key: key);

  @override
  State<WebService> createState() => _WebServiceState();
}

class _WebServiceState extends State<WebService> {
  String urlWeb = 'https://esmartiso.com';

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: WebView(
          initialUrl: urlWeb,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
