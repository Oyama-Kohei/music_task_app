import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/service/auth_service.dart';
import 'package:taskmum_flutter/components/page/splash_page.dart';
import 'package:taskmum_flutter/components/view_model/splash_view_model.dart';
import 'package:taskmum_flutter/utility/dialog_util.dart';
import 'package:taskmum_flutter/utility/loading_circle.dart';
import 'package:taskmum_flutter/utility/locator.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

class LoginViewModel extends ChangeNotifier{

  final AuthService _authService = getIt<AuthService>();

  Future<void> signIn(
      String email,
      String password,
      context
      ) async {
    try {
      showLoadingCircle(context);
      await _authService.signIn(email, password);
      dismissLoadingCircle(context);

      NavigationHelper().pushAndRemoveUntilRoot<SplashViewModel>(
          pageBuilder: (_) => SplashPage(),
          viewModelBuilder: (_) => SplashViewModel(),
      );
    } on Exception catch(_){
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        title: "ログインエラー",
        content: "通信状況やメールアドレス及び\nパスワードをご確認ください",
      );
    }
  }
}
