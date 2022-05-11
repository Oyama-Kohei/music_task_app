import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/page/login_page.dart';
import 'package:taskmum_flutter/components/page/register_page.dart';
import 'package:taskmum_flutter/components/view_model/login_view_model.dart';
import 'package:taskmum_flutter/components/view_model/register_view_model.dart';
import 'package:taskmum_flutter/components/view_model/start_view_model.dart';
import 'package:taskmum_flutter/components/wiget/common_button.dart';
import 'package:taskmum_flutter/components/wiget/common_colors.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}
class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final height = queryData.size.height;
    return Consumer<StartViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: height * 0.08),
              Text(
                'tuskMum',
                textAlign: TextAlign.end,
                style: GoogleFonts.orbitron(
                  color: Colors.blueGrey,
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),
              SizedBox(
                  height: height * 0.55,
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
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    '・画面下のボタンから\n'
                                        'アルバムを追加\n\n'
                                        '・参考演奏も設定可能\n\n'
                                        '・複数曲の課題を管理',
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
                                "images/tuto1.png",
                                height: height * 0.5,
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
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                        '・画面下のボタンから\n'
                                            '課題を追加\n\n'
                                            '・譜面への書き込みを\n'
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
                                  "images/tuto2.png",
                                  height: height * 0.5,
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
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                        '・譜面や情景を追加し\n'
                                            '曲の理解度を向上\n\n'
                                            '・画像追加機能を\n'
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
                                  "images/tuto3.png",
                                  height: height * 0.5,
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
                text: 'アカウント作成',
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                text: 'ログイン',
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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