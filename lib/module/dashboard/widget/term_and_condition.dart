import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermAndCondition extends StatefulWidget {
  const TermAndCondition({super.key});

  @override
  State<TermAndCondition> createState() => _TermAndConditionState();
}

class _TermAndConditionState extends State<TermAndCondition> {
  final WebViewController _controller = WebViewController();
  @override
  void initState() {
    super.initState();
    _controller.loadFlutterAsset('assets/html/term_and_condition.htm');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(
          controller: _controller,
        ),
      ),
    );
  }
}
