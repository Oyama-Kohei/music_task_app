import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmum_flutter/components/service/service.dart';

class AuthService extends Service{

  final firebaseAuthService = FirebaseAuth.instance;

  Future signUp(String email, String password) async{
    try{
      UserCredential _userCredential = await firebaseAuthService.createUserWithEmailAndPassword(email: email, password: password);
      if(_userCredential.user != null){
        return _userCredential.user;
      }
    }on FirebaseAuthException catch(e){
      print("AuthException ${e.toString()})");
    }
  }

  Future<bool> signIn(String email, String password) async{
    try{
      await firebaseAuthService.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      print("AuthException ${e.toString()})");
    }
    return true;
  }
}
