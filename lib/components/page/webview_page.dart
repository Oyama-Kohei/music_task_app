import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:askMu/components/view_model/webview_view_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatelessWidget {
  const WebviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Consumer<WebviewViewModel>(builder: (context, viewModel, child) {
          return Column(
            children: [
              Expanded(
                child: WebView(
                  initialUrl: viewModel.youtubeUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                ),
              )
            ],
          );
        }));
  }
}
