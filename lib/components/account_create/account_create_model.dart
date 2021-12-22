import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taskmum_flutter/components/repository/auth_repository.dart';

class AccountCreateModel extends ChangeNotifier{

  final titleController = TextEditingController();
  final authorController = TextEditingController();

  String? email;
  String? password;

  void setEmail(String email){
    this.email = email;
    notifyListeners();
  }

  void setPassword(String email){
    this.email = email;
    notifyListeners();
  }

  Future signUp(email, password) async{
    this.email = titleController.text;
    this.password = authorController.text;

    //firebase authでユーザー追加

    //firestoreに追加

  }
}

