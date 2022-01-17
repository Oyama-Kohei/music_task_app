import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/repository/auth_repository.dart';
import 'package:taskmum_flutter/components/repository/user_repository.dart';
import 'package:taskmum_flutter/components/top_page.dart';
import 'package:taskmum_flutter/utility/dialog_util.dart';
import 'package:taskmum_flutter/utility/loading_circle.dart';
import 'package:taskmum_flutter/utility/locator.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

class LoginViewModel extends ChangeNotifier{

  final AuthRepository _authRepository = getIt<AuthRepository>();

  Future<void> signIn(
      String email,
      String password,
      context
      ) async {
    try {
      showLoadingCircle(context);
      await _authRepository.signIn(email, password);
      dismissLoadingCircle(context);

      NavigationHelper().push<void>(
            (context) => const TopPage(),
      );
    } on Exception catch(_){
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        title: "ログインエラー",
        content: "ログインに失敗しました",
      );
    }
  }
}
