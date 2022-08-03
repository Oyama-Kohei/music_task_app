import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:askMu/components/page/login_page.dart';
import 'package:askMu/components/page/register_page.dart';
import 'package:askMu/components/view_model/login_view_model.dart';
import 'package:askMu/components/view_model/register_view_model.dart';
import 'package:askMu/components/view_model/start_view_model.dart';
import 'package:askMu/components/wiget/common_button.dart';
import 'package:askMu/utility/navigation_helper.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final height = queryData.size.height;

    final width = queryData.size.width;
    return Consumer<StartViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            SizedBox(height: height * 0.02 + queryData.padding.top * 0.9),
            Text(
              '.askMu...',
              style: GoogleFonts.caveat(fontSize: 50, color: Colors.black),
            ),
            const SizedBox(
              height: 15,
              // child: AnimatedTextKit(
              //   animatedTexts: [
              //     TypewriterAnimatedText(
              //       '楽器/歌の課題管理をシステム化',
              //       textAlign: TextAlign.end,
              //       textStyle: GoogleFonts.caveat(
              //         color: Colors.black,
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //       ),
              //       speed: const Duration(milliseconds: 200),
              //     )
              //   ],
              // ),
            ),
            SizedBox(
              height: height * 0.59,
              child: PageView(
                controller: viewModel.startPageController,
                onPageChanged: (value) => viewModel.onStartPageChanged(value),
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Music',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.caveat(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '楽曲を追加してカードを表示\n参考演奏の登録/再生も可能\n',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.sawarabiMincho(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              'images/Tutorial1.png',
                              width: width * 0.9,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Task',
                                style: GoogleFonts.caveat(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '楽曲ごとに課題を登録\n楽章/小説番号の順で課題を管理\n',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.sawarabiMincho(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ClipRRect(
                          child: Image.asset(
                            'images/Tutorial2.png',
                            width: width * 0.9,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5, right: 5),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Photo',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.caveat(
                                    color: Colors.black,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'タスクに写真を登録\n楽譜/曲の場面/情景などを写真で追加\n',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.sawarabiMincho(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            child: Image.asset(
                              'images/Tutorial3.png',
                              width: width * 0.9,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CirclePageIndicator(
                size: 10,
                selectedSize: 12,
                currentPageNotifier: viewModel.startPageNotifier,
                selectedDotColor: Colors.lightBlueAccent,
                dotColor: Colors.grey,
                itemCount: 3),
            const SizedBox(height: 10),
            if (viewModel.startPageNotifier.value == 2)
              CommonButton(
                text: 'アカウント作成はこちら',
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                useIcon: true,
                onPressed: () async {
                  NavigationHelper().push<RegisterViewModel>(
                    context: context,
                    pageBuilder: (_) => const RegisterPage(),
                    viewModelBuilder: (context) => RegisterViewModel(),
                  );
                },
              ),
            if (viewModel.startPageNotifier.value == 2)
              CommonButton(
                text: 'ログインはこちら',
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                useIcon: true,
                onPressed: () async {
                  NavigationHelper().push<LoginViewModel>(
                    context: context,
                    pageBuilder: (_) => const LoginPage(),
                    viewModelBuilder: (context) => LoginViewModel(),
                  );
                },
              ),
          ]),
        ),
      );
    });
  }
}
