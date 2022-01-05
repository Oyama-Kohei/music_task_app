import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/repository/auth_repository.dart';
import 'package:taskmum_flutter/utility/locator.dart';

enum AppState { LOADING, LOADED, ERROR }

class LoginViewModel extends ChangeNotifier{

  AppState? _state;
  final AuthRepository _repository = getIt<AuthRepository>();

  AppState? get state => _state;

  set state(AppState? state){
    this._state;
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    state = AppState.LOADING;

    var result = await _repository.signUp(email, password);
    if (result is! User) {
      state = AppState.ERROR;
      return false;
    }

    state = AppState.LOADED;
    return true;
  }

// final doc = FirebaseFirestore.instance.collection('user').doc(uid);
//
// // //firestoreに追加
// // doc.set({
// //   'uid': uid,
// //   'email': email,
// //   'nickname': nickname,
// // });
}
