import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/service/auth_service.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';
import 'package:taskmum_flutter/components/splash/splash_page.dart';
import 'package:taskmum_flutter/components/splash/splash_view_model.dart';
import 'package:taskmum_flutter/components/top/top_page.dart';
import 'package:taskmum_flutter/utility/dialog_util.dart';
import 'package:taskmum_flutter/utility/loading_circle.dart';
import 'package:taskmum_flutter/utility/locator.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

class RegisterViewModel extends ChangeNotifier{

  final AuthService _authService = getIt<AuthService>();
  final UserService _userService = getIt<UserService>();

  Future<void> signUp(
      String email,
      String password,
      String nickname,
      context
      ) async {
    try {
      showLoadingCircle(context);
      var user = await _authService.signUp(email, password);
      var uid = user.uid;
      await _userService.setNickname(nickname, uid);
      dismissLoadingCircle(context);
      NavigationHelper().pushAndRemoveUntilRoot<SplashViewModel>(
        pageBuilder: (_) => SplashPage(),
        viewModelBuilder: (_) => SplashViewModel(),
      );
    } on Exception catch(_){
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        title: "アカウント作成エラー",
        content: "アカウント作成に失敗しました",
      );
    }
  }
}
