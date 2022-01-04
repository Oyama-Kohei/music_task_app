import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskmum_flutter/components/register/register_page.dart';
import 'package:taskmum_flutter/components/login/login_page.dart';
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
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Text(
                    'tuskMum',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.orbitron(
                      color: Colors.blueGrey,
                      fontSize: 46,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("images/memo.jpeg", scale: 1,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                        child:Text(
                            '本アプリは今までにない\nよりシンプルなカレンダーアプリです',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.orbitron(
                              color: Colors.blueGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                      CommonButton(
                        text: 'アカウントをお持ちでない方',
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        useIcon: true,
                        onPressed: () async {
                          await NavigationHelper().push<void>(
                                (context) => RegisterPage(),
                          );
                        },
                      ),
                      CommonButton(
                        text: 'ログイン',
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        useIcon: true,
                        onPressed: () async {
                          await NavigationHelper().push<void>(
                                (context) => LoginPage(),
                          );
                        },
                      ),
                    ]
                ),
              ]
          ),
        ),
      ),
    );
  }
}
