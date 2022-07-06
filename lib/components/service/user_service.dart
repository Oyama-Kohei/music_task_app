import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:askMu/components/service/service.dart';

class UserService extends Service {
  final firebaseFireStore = FirebaseFirestore.instance;

  Future setNickname(String nickname, uid) async {
    try {
      // ignore: avoid_print
      print('setNickname');
      final doc = firebaseFireStore.collection('users').doc(uid);
      await doc.set({'uid': uid, 'nickname': nickname});
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getUserId() async {
    try {
      // ignore: avoid_print
      print('getUserId');
      final result = FirebaseAuth.instance.currentUser!.uid;
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
