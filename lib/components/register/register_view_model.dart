import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/repository/auth_repository.dart';
import 'package:taskmum_flutter/utility/locator.dart';

enum AppState { LOADING, LOADED, ERROR }

class RegisterViewModel extends ChangeNotifier{

  AppState? _state;
  final AuthRepository _repository = getIt<AuthRepository>();

  AppState? get state => _state;

  set state(AppState? state){
    this._state;
    notifyListeners();
  }

  Future<bool> signUp(String email, String password) async {
    state = AppState.LOADING;

    //firebase authでユーザー追加
    // final result = await FirebaseAuth.instance
    //     .createUserWithEmailAndPassword(email: email!, password: password!);

    var result = await _repository.signUp(email, password);
    if (result is! User) {
      state = AppState.ERROR;
      return false;
    }

    state = AppState.LOADED;
    return true;
  }
}
