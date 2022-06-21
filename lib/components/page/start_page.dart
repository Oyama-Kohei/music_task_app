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
import 'package:askMu/components/wiget/common_colors.dart';
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
          child: Column(
            children: <Widget>[
              SizedBox(height: height * 0.07),
              Text(
                'askMu',
                textAlign: TextAlign.end,
                style: GoogleFonts.orbitron(
                  color: Colors.blueGrey,
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              SizedBox(
                height: 30,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '楽器/歌の課題管理をシステム化',
                      textAlign: TextAlign.end,
                      textStyle: GoogleFonts.orbitron(
                        color: Colors.blueGrey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      speed: const Duration(milliseconds: 200),
                    )
                  ],
                ),
              ),

              // Text(
              //   '楽器/歌の課題管理をシステム化',
              //   textAlign: TextAlign.end,
              //   style: GoogleFonts.orbitron(
              //     color: Colors.blueGrey,
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              SizedBox(height: height * 0.01),
              SizedBox(
                  height: height * 0.53,
                  child: PageView(
                    controller: viewModel.startPageController,
                    onPageChanged: (value) => viewModel.onStartPageChanged(value),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: CommonColors.customSwatch.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'New Music',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.orbitron(
                                      color: Colors.blueGrey,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: height * 0.05),
                                  Text(
                                    '画面下のボタンから\n'
                                        'アルバムを追加\n\n'
                                        '参考演奏も設定可能\n\n'
                                        '複数曲の課題を管理',
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.orbitron(
                                      color: Colors.blueGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ),
                            ClipRRect(
                              child: Image.asset(
                                'images/Tutorial1.png',
                                width: width * 0.45,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ]
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: CommonColors.customSwatch.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'New Task',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.orbitron(
                                          color: Colors.blueGrey,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: height * 0.05),
                                      Text(
                                        '画面下のボタンから\n'
                                            '課題を追加\n\n'
                                            '譜面への書き込みを\n'
                                            '減らしてコンパクトに',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.orbitron(
                                          color: Colors.blueGrey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              ClipRRect(
                                child: Image.asset(
                                  'images/Tutorial2.png',
                                  width: width * 0.45,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ]
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: CommonColors.customSwatch.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Manage',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.orbitron(
                                          color: Colors.blueGrey,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: height * 0.05),
                                      Text(
                                        '譜面や情景を追加し\n'
                                            '曲の理解度を向上\n\n'
                                            '画像追加機能を\n'
                                            '自由に活用しよう',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.orbitron(
                                          color: Colors.blueGrey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              ClipRRect(
                                child: Image.asset(
                                  'images/Tutorial3.png',
                                  width: width * 0.45,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ]
                        ),
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 10),
              CirclePageIndicator(
                size: 10,
                selectedSize: 12,
                currentPageNotifier: viewModel.startPageNotifier,
                selectedDotColor: Colors.lightBlueAccent,
                dotColor: Colors.grey,
                itemCount: 3),
              const SizedBox(height: 20),
              if(viewModel.startPageNotifier.value == 2)
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
              if(viewModel.startPageNotifier.value == 2)
              CommonButton(
                text: 'ログインはこちら',
                padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
                useIcon: true,
                onPressed: () async {
                  NavigationHelper().push<LoginViewModel>(
                    context: context,
                    pageBuilder: (_) => const LoginPage(),
                    viewModelBuilder: (context) => LoginViewModel(),
                  );
                },
              ),
            ]
          ),
        ),
      );
    }
    );
  }
}