import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/models/album_data.dart';
import 'package:taskmum_flutter/components/service/task_service.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';
import 'package:taskmum_flutter/utility/locator.dart';
import 'package:image_picker/image_picker.dart';

class TaskAddViewModel extends ChangeNotifier{
  TaskAddViewModel({
    required this.albumData,
  });

  AlbumData albumData;

  Future<void> taskAdd(
      String title,
      String albumId,
      int measure,
      String comment,
      BuildContext context
      ) async {
    final UserService _userService = getIt<UserService>();
    final currentUserId = await _userService.getUserId();
    final _taskService = getIt<TaskService>();
    await _taskService.addTask(
      title,
      currentUserId,
      albumId,
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
                Navigator.pop(context);
                Navigator.pop(context);
              }
            ),
          ],
        );
      },
    );
  }

  Future<File?> getImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
       return File(pickedFile.path);
    }
    notifyListeners();
    return null;
  }
}
