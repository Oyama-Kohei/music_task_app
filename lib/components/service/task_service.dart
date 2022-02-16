import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmum_flutter/components/models/task_data.dart';
import 'package:taskmum_flutter/components/service/service.dart';

class TaskService extends Service{

  List<TaskData>? taskDataList;

  Future<List<TaskData>?> getTaskList(String uid, String albumId) async{
    try{
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection("tasks")
              .where("userId", isEqualTo: uid)
              .where("albumId", isEqualTo: albumId).orderBy("measureNum").get();

      final List<TaskData> taskDataList = snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String userId = data["userId"];
        final String albumId = data["albumId"];
        final String title = data["title"];
        final int measureNum = data["measureNum"];
        final String comment = data["comment"];
        final DateTime createAt = data["createAt"].toDate();
        return TaskData(
            taskId: document.id,
            userId: userId,
            albumId: albumId,
            title: title,
            measureNum: measureNum,
            comment: comment,
            createAt: createAt);
      }).toList();
      return taskDataList;
  } catch(e) {
      print(e);
    }
  }
  Future<void> addTask(
      String title,
      String uid,
      String albumId,
      int measure,
      String? comment,
      ) async{
    try{
      var id = FirebaseFirestore.instance.collection("_").doc().id;
      await FirebaseFirestore.instance.collection("tasks").doc(id).set({
        "taskId": id,
        "userId": uid,
        "albumId": albumId,
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