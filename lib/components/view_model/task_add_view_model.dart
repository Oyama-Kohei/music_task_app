import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/models/album_data.dart';
import 'package:taskmum_flutter/components/models/task_data.dart';
import 'package:taskmum_flutter/components/service/task_service.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';
import 'package:taskmum_flutter/utility/locator.dart';
import 'package:image_picker/image_picker.dart';

class TaskAddViewModel extends ChangeNotifier{
  TaskAddViewModel({
    required this.albumData,
    this.taskData,
  }) : super() {
    if(taskData != null && taskData!.imageUrl != null){
      imageFile = Image.network(taskData!.imageUrl!);
    }
  }

  AlbumData albumData;
  TaskData? taskData;
  Image? imageFile;
  String? setFilePath;

  static const String selectIcon = "アイコンを選択";
  static const List<String> selectIconOption = ["写真から選択", "写真を撮影"];
  static const int gallery = 0;
  static const int camera = 1;

  Future<void> taskAdd(
      String title,
      int measure,
      String? comment,
      BuildContext context
      ) async {
    final UserService userService = getIt<UserService>();
    final currentUserId = await userService.getUserId();
    final taskService = getIt<TaskService>();

    final String? imageUrl;

    if(setFilePath != null) {
      imageUrl = await taskService.uploadPhotoData(setFilePath!);
    } else {
      imageUrl = null;
    }

    await taskService.addTask(
      title,
      currentUserId,
      albumData.albumId,
      measure,
      comment,
      imageUrl,
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
                notifyListeners();
                Navigator.pop(context);
                Navigator.pop(context);
              }
            ),
          ],
        );
      },
    );
  }

  Future<void> getImage(context) async {
    var selectType = await showDialog(
        context: context,
        builder: (BuildContext context){
          return SimpleDialog(
            title: const Text(selectIcon),
            children: selectIconOption.asMap().entries.map((e) {
              return SimpleDialogOption(
                child: ListTile(
                  title: Text(e.value),
                ),
                onPressed: ()=>Navigator.of(context).pop(e.key),
              );
            }).toList(),
          ) ;
        });
    final imagePicker = ImagePicker();
    final ImageSource? ImgSrc;
    //カメラで撮影
    if (selectType == camera){
      ImgSrc = ImageSource.camera;
    }
    //ギャラリーから選択
    else if (selectType == gallery){
      ImgSrc = ImageSource.gallery;
    } else {
      ImgSrc = null;
    }
    if (ImgSrc != null) {
      final pickedFile = await imagePicker.pickImage(source: ImgSrc);
      if (pickedFile != null) {
        imageFile = Image.file(File(pickedFile.path));
        setFilePath = pickedFile.path;
        notifyListeners();
      }
    }
  }
}
