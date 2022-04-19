import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/view_model/webview_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: use_key_in_widget_constructors
class WebviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<WebviewViewModel>(builder: (context, viewModel, child) {
          return WebView(initialUrl: viewModel.youtubeUrl);
        }
      )
    );
  }
}