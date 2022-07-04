import 'package:flutter/widgets.dart';
import 'package:askMu/components/service/auth_service.dart';
import 'package:askMu/components/service/user_service.dart';
import 'package:askMu/components/page/splash_page.dart';
import 'package:askMu/components/view_model/splash_view_model.dart';
import 'package:askMu/utility/dialog_util.dart';
import 'package:askMu/utility/loading_circle.dart';
import 'package:askMu/utility/locator.dart';
import 'package:askMu/utility/navigation_helper.dart';

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
        pageBuilder: (_) => const SplashPage(),
        viewModelBuilder: (_) => SplashViewModel(),
      );
    } on Exception catch(_){
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        title: 'アカウント作成エラー',
        content: '通信状況などを再度ご確認ください',
      );
    }
  }
}
