import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = Provider.autoDispose((ref) => AuthController(ref, read));

class AuthController{
  AuthController(this.read);
  final Reader read;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User currentUser = FirebaseAuth.currentUser;

  Future signUp(username, password, passwordConfirm, mail) async{
    if (username.isEmpty) {
      throw ('IDを入力して下さい');
    }
    if (password.isEmpty) {
      throw ('パスワードを入力して下さい');
    }
    if (mail.isEmpty) {
      throw ('メールアドレスを入力して下さい');
    }

    final User user = (await _auth.createUserWithEmailAndPassword(
      email: mail,
      password: password;
    )).user;
  }


}