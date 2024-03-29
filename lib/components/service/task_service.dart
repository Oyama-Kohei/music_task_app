import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:askMu/components/models/task_data.dart';
import 'package:askMu/components/service/service.dart';

class TaskService extends Service {
  List<TaskData>? taskDataList;

  String generateFileName(int length) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    final randomStr =
        List.generate(length, (_) => charset[random.nextInt(charset.length)])
            .join();
    return randomStr;
  }

  Future<List<TaskData>?> getTaskList(String uid, String albumId) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('tasks')
          .where('userId', isEqualTo: uid)
          .where('albumId', isEqualTo: albumId)
          .orderBy('movementNum')
          .orderBy('measureNum')
          .get();
      final List<TaskData> taskDataList =
          snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String userId = data['userId'];
        final String albumId = data['albumId'];
        final String title = data['title'];
        final int movementNum = data['movementNum'];
        final int measureNum = data['measureNum'];
        final String? comment = data['comment'];
        final String? imageUrl = data['imageUrl'];
        final DateTime createAt = data['createAt'].toDate();
        return TaskData(
            taskId: document.id,
            userId: userId,
            albumId: albumId,
            title: title,
            movementNum: movementNum,
            measureNum: measureNum,
            comment: comment,
            imageUrl: imageUrl,
            createAt: createAt);
      }).toList();
      return taskDataList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTask({
    required String title,
    required String uid,
    required String albumId,
    required int movementNum,
    required int measureNum,
    String? comment,
    String? imageUrl,
  }) async {
    try {
      var id = FirebaseFirestore.instance.collection('_').doc().id;
      await FirebaseFirestore.instance.collection('tasks').doc(id).set({
        'taskId': id,
        'userId': uid,
        'albumId': albumId,
        'title': title,
        'movementNum': movementNum,
        'measureNum': measureNum,
        'comment': comment,
        'imageUrl': imageUrl,
        'createAt': DateTime.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask({
    required String id,
    required String title,
    required String uid,
    required String albumId,
    required int movementNum,
    required int measureNum,
    String? comment,
    String? imageUrl,
  }) async {
    try {
      // ignore: avoid_print
      print('updateTask');
      await FirebaseFirestore.instance.collection('tasks').doc(id).update({
        'taskId': id,
        'userId': uid,
        'albumId': albumId,
        'title': title,
        'movementNum': movementNum,
        'measureNum': measureNum,
        'comment': comment,
        'imageUrl': imageUrl,
        'createAt': DateTime.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(TaskData data) async {
    try {
      // ignore: avoid_print
      print('deleteTask');
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(data.taskId)
          .delete();
      if (data.imageUrl != null) {
        await deletePhotoData(data.imageUrl!);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadPhotoData(String filePath) async {
    try {
      // ignore: avoid_print
      print('uploadPhotoData');
      final ref = FirebaseStorage.instance.ref();
      final storedImage = await ref
          .child('images')
          .child(generateFileName(16))
          .putFile(File(filePath));
      final photoUrl = await storedImage.ref.getDownloadURL();
      return photoUrl.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePhotoData(String url) async {
    try {
      // ignore: avoid_print
      print('_deletePhotoData');
      final storageReference = FirebaseStorage.instance.refFromURL(url);
      await storageReference.delete();
    } catch (error) {
      rethrow;
    }
  }
}
