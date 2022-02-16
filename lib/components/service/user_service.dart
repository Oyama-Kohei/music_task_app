import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmum_flutter/components/service/service.dart';

class UserService  extends Service{

  final firebaseFireStore = FirebaseFirestore.instance;

  Future setNickname(String nickname, uid) async{
    final doc = firebaseFireStore.collection("users").doc(uid);
    await doc.set({
      "uid": uid,
      "nickname": nickname
    });
  }

  Future getUserId() async{
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
