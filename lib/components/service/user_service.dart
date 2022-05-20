import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:askMu/components/service/service.dart';

class UserService  extends Service{

  final firebaseFireStore = FirebaseFirestore.instance;

  Future setNickname(String nickname, uid) async{
    try {
      final doc = firebaseFireStore.collection("users").doc(uid);
      await doc.set({
        "uid": uid,
        "nickname": nickname
      });
    } on Exception catch(_){
      rethrow;
    }
  }

  Future getUserId() async{
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
