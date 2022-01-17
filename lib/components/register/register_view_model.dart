import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/repository/auth_repository.dart';
import 'package:taskmum_flutter/components/repository/user_repository.dart';
import 'package:taskmum_flutter/components/top_page.dart';
import 'package:taskmum_flutter/utility/dialog_util.dart';
import 'package:taskmum_flutter/utility/loading_circle.dart';
import 'package:taskmum_flutter/utility/locator.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

class RegisterViewModel extends ChangeNotifier{

  final AuthRepository _authRepository = getIt<AuthRepository>();
  final UserRepository _userRepository = getIt<UserRepository>();

  Future<void> signUp(
      String email,
      String password,
      String nickname,
      context
      ) async {
    try {
      showLoadingCircle(context);
      var user = await _authRepository.signUp(email, password);
      // var uid = user.uid;
      // await _userRepository.setNickname(nickname, uid);
      dismissLoadingCircle(context);

      NavigationHelper().push<void>(
              (context) => const TopPage(),
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
