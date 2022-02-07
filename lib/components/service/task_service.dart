import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmum_flutter/components/models/task_data.dart';
import 'package:taskmum_flutter/components/service/service.dart';
import 'package:uuid/uuid.dart';

class TaskService extends Service{

  List<TaskData>? taskDataList;

  Future<List<TaskData>?> getTaskList() async{
    try{
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("tasks").get();

      final List<TaskData> taskDataList = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String userId = data["userId"];
        final String title = data["title"];
        final int measureNum = data["measureNum"];
        final String comment = data["comment"];
        final DateTime createAt = data["createAt"].toDate();
        return TaskData(
            taskId: document.id,
            userId: userId,
            title: title,
            measureNum: measureNum,
            comment: comment,
            createAt: createAt);
      }).toList();
      // this.taskDataList = taskDataList;
      return taskDataList;
  } catch(e) {
      print(e);
    }
  }
  Future<void> addTask(
      String title,
      User user,
      int measure,
      String comment,
      ) async{
    try{
      var id = FirebaseFirestore.instance.collection("_").doc().id;
      await FirebaseFirestore.instance.collection("tasks").doc(id).set({
        "taskId": id,
        "userId": user.uid,
        "title": title,
        "measureNum": measure,
        "comment": comment,
        "createAt": DateTime.now(),
      });
    } catch(e) {
      print(e);
    }
  }
}