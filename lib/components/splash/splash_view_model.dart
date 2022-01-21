import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmum_flutter/components/start_page/start_page.dart';
import 'package:taskmum_flutter/components/top_page.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

class SplashViewModel extends ChangeNotifier{
  Future<void> initApp(BuildContext context) async {
    gotoNextScreen(context);
  }

  void showStartPage(){
    NavigationHelper().push<void>(
            (context) => MainStartPage()
    );
  }

  void showTopPage(){
    NavigationHelper().push<void>(
            (context) => const TopPage()
    );
  }

  Future<void> gotoNextScreen(BuildContext context) async {
    Future.delayed(
      const Duration(milliseconds: 3000),
        () async{
          if (FirebaseAuth.instance.currentUser != null) {
            showTopPage();
          } else{
            showStartPage();
          }
        }
    );
  }

}