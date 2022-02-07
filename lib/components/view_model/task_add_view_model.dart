import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/service/auth_service.dart';
import 'package:taskmum_flutter/components/service/task_service.dart';
import 'package:taskmum_flutter/utility/locator.dart';

class TaskAddViewModel extends ChangeNotifier{
  // TaskAddViewModel({
  //   List<Service>? services,
  //   required this.taskDataList,
  //   required this.albumDataList,
  // });
  // List<Service>? services;
  //
  // List<TaskData> taskDataList;
  //
  // List<AlbumData> albumDataList;

  // findService<T extends Service>(){
  //   for(Service service in services!){
  //     if(service is T){
  //       return service;
  //     }
  //   }
  // }

  Future<void> taskAdd(
      String title,
      int measure,
      String comment,
      BuildContext context
      ) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final _taskService = getIt<TaskService>();
    await _taskService.addTask(
      title,
      currentUser!,
      measure,
      comment,
    );
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("タスクを追加しました"),
          actions: <Widget>[
            FlatButton(
              child: const Text("OK"),
              onPressed: () async {
                final _authService = getIt<AuthService>();
                await _authService.signOut();
                Navigator.pop(context);
                Navigator.pop(context);
              }
            ),
          ],
        );
      },
    );
  }

  Future<void> onTapAddList(BuildContext context) async {

  }
}
