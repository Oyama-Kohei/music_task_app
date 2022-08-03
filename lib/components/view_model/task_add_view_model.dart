import 'package:askMu/utility/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:askMu/components/models/album_data.dart';
import 'package:askMu/components/models/task_data.dart';
import 'package:askMu/components/service/task_service.dart';
import 'package:askMu/components/service/user_service.dart';
import 'package:askMu/utility/loading_circle.dart';
import 'package:askMu/utility/locator.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class TaskAddViewModel extends ChangeNotifier {
  TaskAddViewModel({
    required this.albumData,
    this.taskData,
  }) : super() {
    if (taskData != null && taskData!.imageUrl != null) {
      imageFile = Image.network(
        taskData!.imageUrl!,
        loadingBuilder: (context, child, loadingProgress) {
          return loadingProgress == null
              ? child
              : Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image_outlined);
        },
      );
    }
  }

  AlbumData albumData;
  TaskData? taskData;
  Image? imageFile;
  String? setFilePath;

  static const String selectIcon = '画像の選択方法';
  static const List<String> selectIconOption = ['写真から選択', '写真を撮影'];
  static const List<String> movementList = [
    '練習番号なし',
    '練習番号A',
    '練習番号B',
    '練習番号C',
    '練習番号D',
    '練習番号E',
    '練習番号F',
    '練習番号G',
    '練習番号H',
    '練習番号I',
    '練習番号J',
    '練習番号K',
    '練習番号L',
    '練習番号M',
    '練習番号N',
    '練習番号O',
    '練習番号P',
    '練習番号Q',
    '練習番号R',
    '練習番号S',
    '練習番号T',
    '練習番号U',
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

      String? imageUrl;

      if (setFilePath != null) {
        imageUrl = await taskService.uploadPhotoData(setFilePath!);
        if (taskData != null && taskData!.imageUrl != null) {
          await taskService.deletePhotoData(taskData!.imageUrl!);
        }
      } else if (taskData != null && taskData!.imageUrl != null) {
        imageUrl = taskData!.imageUrl!;
      } else {
        imageUrl = null;
      }

      if (taskData == null) {
        await taskService.addTask(
          title: title,
          uid: currentUserId,
          albumId: albumData.albumId,
          movementNum: movementNum,
          measureNum: measure,
          comment: comment,
          imageUrl: imageUrl,
        );
      } else {
        await taskService.updateTask(
          id: taskData!.taskId,
          title: title,
          uid: currentUserId,
          albumId: albumData.albumId,
          movementNum: movementNum,
          measureNum: measure,
          comment: comment,
          imageUrl: imageUrl,
        );
      }
      dismissLoadingCircle(context);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.only(top: 50),
              title: Column(
                children: [
                  Text(
                    'Successful addition',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(fontSize: 30),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    taskData == null ? 'タスクの追加が完了しました' : 'タスクの更新が完了しました',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(fontSize: 16),
                  ),
                  Text(
                    '引き続き練習頑張ってください！',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(fontSize: 16),
                  ),
                ],
              ),
              content: Image.asset(
                'images/Success.png',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    notifyListeners();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
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
    try {
      final selectType = await showDialog(
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
          final tmpDir = await getTemporaryDirectory();
          final timestamp = DateTime.now().toString();
          final targetPath = '${tmpDir.path}/$timestamp.jpg';
          final result = await FlutterImageCompress.compressAndGetFile(
            pickedFile.path,
            targetPath,
            minWidth: 500,
            minHeight: 0,
            quality: 80,
          );
          imageFile = Image.file(result!);
          setFilePath = result.path;
          notifyListeners();
        }
      }
    } catch (_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text(
                '写真の追加に失敗しました\nカメラや写真の使用には端末設定からのアクセス許可が必要になります',
                style: TextStyle(fontSize: 16),
              ),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () async {
                    await openAppSettings();
                  },
                  child: const Text("設定画面へ移動する"),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('キャンセル'),
                ),
              ],
            );
          });
    }
  }
}
