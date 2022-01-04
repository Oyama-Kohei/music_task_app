import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taskmum_flutter/components/repository/auth_repository.dart';

final registerViewModelNotifierProvider = ChangeNotifierProvider(
    (ref) => RegisterViewModel());

class RegisterViewModel extends ChangeNotifier{

  // RegisterViewModel(ref, {required AuthRepository repository})

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nicknameController = TextEditingController();

  String? email;
  String? password;
  String? nickname;

  bool isloading = false;

  void startLoading(){
    isloading = true;
    notifyListeners();
  }

  void endLoading(){
    isloading = false;
    notifyListeners();
  }

  void setEmail(String email){
    this.email = email;
    notifyListeners();
  }

  void setPassword(String email){
    this.email = email;
    notifyListeners();
  }

  void setNickname(String nickname){
    this.nickname = nickname;
    notifyListeners();
  }

  Future<void> signUp() async {
    this.email = emailController.text;
    this.password = passwordController.text;
    this.nickname = nicknameController.text;

    //firebase authでユーザー追加
    final result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);

    final user = result.user;
    final uid = user!.uid;

    final doc = FirebaseFirestore.instance.collection('user').doc(uid);

    //firestoreに追加
    doc.set({
      'uid': uid,
      'email': email,
      'nickname': nickname,
    });
  }
}

