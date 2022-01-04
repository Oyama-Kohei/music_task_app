import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class LoginModel extends ChangeNotifier{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? email;
  String? password;

  bool isloading = false;

  void startLoading(){
    isloading = true;
  }

  void endLoading(){
    isloading = false;
  }

  void setEmail(String email){
    this.email = email;
    notifyListeners();
  }

  void setPassword(String email){
    this.email = email;
    notifyListeners();
  }

  Future<void> signUp() async {
    this.email = emailController.text;
    this.password = passwordController.text;

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
    });
  }
}

