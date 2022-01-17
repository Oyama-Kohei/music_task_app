import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {

  final firebaseFireStore = FirebaseFirestore.instance;

  Future setNickname(String nickname, uid) async{
    final doc = firebaseFireStore.collection("users").doc(uid);
    await doc.set({
      "uid": uid,
      "nickname": nickname
    });
  }
}
