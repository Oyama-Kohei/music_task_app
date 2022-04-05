import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmum_flutter/components/view_model/login_view_model.dart';
import 'package:taskmum_flutter/components/page/register_page.dart';
import 'package:taskmum_flutter/components/page/login_page.dart';
import 'package:taskmum_flutter/components/view_model/register_view_model.dart';
import 'package:taskmum_flutter/components/wiget/common_button.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

class StartPage2 extends StatelessWidget{
  const StartPage2 ({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                'tuskMum',
                textAlign: TextAlign.end,
                style: GoogleFonts.orbitron(
                  color: Colors.blueGrey,
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                "images/memo.jpeg",
              height: 240),
              Text(
                '本アプリは音楽の練習に特化した\n課題管理アプリ\n楽譜への書き込みを軽減',
                textAlign: TextAlign.center,
                style: GoogleFonts.orbitron(
                  color: Colors.blueGrey,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CommonButton(
                text: 'アカウント作成',
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                useIcon: true,
                onPressed: () async {
                  NavigationHelper().push<RegisterViewModel>(
                    context: context,
                    pageBuilder: (_) => const RegisterPage(),
                    viewModelBuilder: (context) => RegisterViewModel(),
                  );
                },
              ),
              CommonButton(
                text: 'ログイン',
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
      ),
    );
  }
}
