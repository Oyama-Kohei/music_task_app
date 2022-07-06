import 'dart:io';

import 'package:askMu/utility/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:askMu/components/models/album_data.dart';
import 'package:askMu/components/models/task_data.dart';
import 'package:askMu/components/service/task_service.dart';
import 'package:askMu/components/service/user_service.dart';
import 'package:askMu/utility/loading_circle.dart';
import 'package:askMu/utility/locator.dart';
import 'package:image_picker/image_picker.dart';

class TaskAddViewModel extends ChangeNotifier {
  TaskAddViewModel({
    required this.albumData,
    this.taskData,
  }) : super() {
    if (taskData != null && taskData!.imageUrl != null) {
      imageFile = Image.network(taskData!.imageUrl!);
    }
  }

  AlbumData albumData;
  TaskData? taskData;
  Image? imageFile;
  String? setFilePath;

  static const String selectIcon = '画像の選択方法';
  static const List<String> selectIconOption = ['写真から選択', '写真を撮影'];
  static const List<String> movementList = [
    '楽章なし',
    '1楽章',
    '2楽章',
    '3楽章',
    '4楽章',
    '5楽章',
    '6楽章',
    '7楽章',
    '8楽章',
    '9楽章',
    '10楽章'
  ];
  static const int gallery = 0;
  static const int camera = 1;

  // 画面更新フラグ
  bool updateFlag = false;

  Future<void> taskAdd(String title, int measure, String movement,
      String? comment, BuildContext context) async {
    var movementNum = 0;
    for (var i = 0; i < movementList.length; i++) {
      if (movement == movementList[i]) {
        movementNum = i;
        break;
      }
    }
    try {
      showLoadingCircle(context);
      final UserService userService = getIt<UserService>();
      final currentUserId = await userService.getUserId();
      final taskService = getIt<TaskService>();

      final String? imageUrl;

      if (setFilePath != null) {
        imageUrl = await taskService.uploadPhotoData(setFilePath!);
      } else {
        imageUrl = null;
      }

      taskData == null
          ? await taskService.addTask(
              title: title,
              uid: currentUserId,
              albumId: albumData.albumId,
              movementNum: movementNum,
              measureNum: measure,
              comment: comment,
              imageUrl: imageUrl,
            )
          : await taskService.updateTask(
              id: taskData!.taskId,
              title: title,
              uid: currentUserId,
              albumId: albumData.albumId,
              movementNum: movementNum,
              measureNum: measure,
              comment: comment,
              imageUrl: imageUrl);
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopDialog(
          context: context,
          content: taskData == null ? 'タスクを追加しました' : 'タスクを更新しました',
          onPressed: () async {
            notifyListeners();
            Navigator.pop(context);
            Navigator.pop(context);
          });
    } catch (e) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: 'タスクの追加に失敗しました',
      );
    }
  }

  Future<void> taskDelete(BuildContext context) async {
    try {
      showLoadingCircle(context);
      final taskService = getIt<TaskService>();
      await taskService.deleteTask(taskData!);
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopDialog(
          context: context,
          content: 'タスクを削除しました',
          onPressed: () async {
            notifyListeners();
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          });
    } catch (e) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: 'タスクの削除に失敗しました',
      );
    }
  }

  Future<void> getImage(context) async {
    var selectType = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text(selectIcon),
            children: selectIconOption.asMap().entries.map((e) {
              return SimpleDialogOption(
                child: ListTile(
                  title: Text(e.value),
                ),
                onPressed: () => Navigator.of(context).pop(e.key),
              );
            }).toList(),
          );
        });
    final imagePicker = ImagePicker();
    // ignore: non_constant_identifier_names
    final ImageSource? ImgSrc;
    //カメラで撮影
    if (selectType == camera) {
      ImgSrc = ImageSource.camera;
    }
    //ギャラリーから選択
    else if (selectType == gallery) {
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
