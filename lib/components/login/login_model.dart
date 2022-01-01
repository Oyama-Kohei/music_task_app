import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class LoginModel extends ChangeNotifier{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? email;
  String? password;

  void setEmail(String email){
    this.email = email;
  }

  void setPassword(String email){
    this.email = email;
  }

  void signIn(email, password) {
    this.email = emailController.text;
    this.password = passwordController.text;

    //firebase authでユーザー追加

    //firestoreに追加

  }
}

