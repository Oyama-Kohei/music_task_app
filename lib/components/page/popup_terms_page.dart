import 'package:askMu/components/view_model/popup_terms_view_model.dart';
import 'package:askMu/components/wiget/common_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PopupTermsPage extends StatefulWidget {
  @override
  _PopupTermsPageState createState() => _PopupTermsPageState();
}

class _PopupTermsPageState extends State<PopupTermsPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: Colors.black45,
        child: Center(
          child: Consumer<PopupTermsViewModel>(
            builder: (context, viewModel, child) {
              return Container(
                width: width * 0.9,
                height: height * 0.9,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _title(viewModel),
                    _webview(viewModel, width * 0.8, height * 0.6),
                    _agreeButton(viewModel, context),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _title(PopupTermsViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        viewModel.agreeFlag
            ? '本アプリを利用するにあたり、下記の利用規約に同意していただく必要があります。ご確認の上「本規約に同意する」ボタンを押してください。'
            : '',
      ),
    );
  }

  Widget _webview(PopupTermsViewModel viewModel, double width, double height) {
    return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(color: Colors.white),
        child: Stack(
          children: [
            WebView(
              initialUrl:
                  'https://firebasestorage.googleapis.com/v0/b/tuskmum-flutter.appspot.com/o/terms%2Fterms_privacy_policyhtml.html?alt=media&token=bd887e99-542b-482b-8b2c-38630b1ae350',
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (_) {
                setState(
                  () {
                    _isLoading = false;
                  },
                );
              },
            ),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : const SizedBox.shrink()
          ],
        ));
  }

  Widget _agreeButton(PopupTermsViewModel viewModel, BuildContext context) {
    return CommonButton(
      text: viewModel.agreeFlag ? '本規約に同意する' : '閉じる',
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      useIcon: true,
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
