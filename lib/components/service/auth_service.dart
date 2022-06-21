import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:askMu/components/service/service.dart';

class AuthService extends Service{

  final firebaseAuthService = FirebaseAuth.instance;

  Future signUp(String email, String password) async{
    try{
      UserCredential _userCredential = await firebaseAuthService.createUserWithEmailAndPassword(email: email, password: password);
      if(_userCredential.user != null){
        return _userCredential.user;
      }
    }on Exception catch(e){
      rethrow;
    }
  }

  Future<bool> signIn(String email, String password) async{
    try{
      await firebaseAuthService.signInWithEmailAndPassword(email: email, password: password);
    }on Exception catch(e){
      rethrow;
    }
    return true;
  }

  Future<bool> signOut() async{
    try{
      await firebaseAuthService.signOut();
    }on FirebaseAuthException catch(e){
      rethrow;
    }
    return true;
  }

  Future<bool> unSubscribe(String userId) async{
    try{
      await firebaseAuthService.signOut();
      // ユーザデータに紐づいているアルバムを削除
      final queryAlbum = await FirebaseFirestore.instance
          .collection('albums')
          .where('userId', isEqualTo: userId)
          .get();
      for (var doc in queryAlbum.docs) {
        await doc.reference.delete();
      }
      // ユーザデータに紐づいているタスクを削除
      final queryTask = await FirebaseFirestore.instance
          .collection('tasks')
          .where('userId', isEqualTo: userId)
          .get();
      for (var doc in queryTask.docs) {
        await doc.reference.delete();
      }
      FirebaseFirestore.instance.collection('users').doc(userId).delete();

    }on Exception catch(e){
      rethrow;
    }
    return true;
  }
}
