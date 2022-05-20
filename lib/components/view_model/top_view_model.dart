import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/models/album_data.dart';
import 'package:taskmum_flutter/components/models/task_data.dart';
import 'package:taskmum_flutter/components/page/album_add_page.dart';
import 'package:taskmum_flutter/components/page/splash_page.dart';
import 'package:taskmum_flutter/components/page/task_add_page.dart';
import 'package:taskmum_flutter/components/page/webview_page.dart';
import 'package:taskmum_flutter/components/service/auth_service.dart';
import 'package:taskmum_flutter/components/service/service.dart';
import 'package:taskmum_flutter/components/service/task_service.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';
import 'package:taskmum_flutter/components/view_model/album_add_view_model.dart';
import 'package:taskmum_flutter/components/view_model/splash_view_model.dart';
import 'package:taskmum_flutter/components/view_model/task_add_view_model.dart';
import 'package:taskmum_flutter/components/view_model/webview_view_model.dart';
import 'package:taskmum_flutter/utility/dialog_util.dart';
import 'package:taskmum_flutter/utility/locator.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

class TopViewModel extends ChangeNotifier{
  TopViewModel({
    List<Service>? services,
    required this.taskDataList,
    required this.albumDataList,
  });
  List<Service>? services;

  List<TaskData>? taskDataList;

  List<AlbumData> albumDataList = [];

  final PageController albumPageController =
    PageController(viewportFraction: 0.85);

  final albumPageNotifier = ValueNotifier<int>(0);

  void onAlbumPageChanged(int index){
    albumPageNotifier.value = index;
    notifyListeners();
  }

  Future<void> onTapLogout(BuildContext context) async {
    showDialog(
        context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("ログアウトしますか？"),
          actions: <Widget>[
            // ボタン領域
            TextButton(
              child: const Text("キャンセル"),
              onPressed: () {
                Navigator.pop(context);
              }
            ),
            TextButton(
              child: const Text("OK"),
              onPressed: () async {
                final _authService = getIt<AuthService>();
                await _authService.signOut();
                NavigationHelper().pushAndRemoveUntilRoot<SplashViewModel>(
                  pageBuilder: (_) => SplashPage(),
                  viewModelBuilder: (_) => SplashViewModel(),
                );
              }
            ),
          ],
        );
      },
    );
  }

  Future<void> onTapAddList(BuildContext context, int currentIndex) async {
    if(albumDataList.isNotEmpty) {
      NavigationHelper().push<TaskAddViewModel>(
        context: context,
        pageBuilder: (_) => const TaskAddPage(),
        viewModelBuilder: (context) => TaskAddViewModel(albumData: albumDataList[currentIndex]),
      );
    } else {
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        title: "アルバムがありません",
        content: "タスクを追加する前に紐付け先のアルバムを追加してください",
      );
    }
  }

  Future<void> onTapAddAlbum(BuildContext context) async {
    NavigationHelper().push<AlbumAddViewModel>(
      context: context,
      pageBuilder: (_) => const AlbumAddPage(),
      viewModelBuilder: (context) => AlbumAddViewModel(),
    );
  }

  Future<void> getTaskDataList(BuildContext context, String albumId) async {
    // showLoadingCircle(context);
    final UserService _userService = getIt<UserService>();
    final currentUserId = await _userService.getUserId();

    final TaskService _taskService = getIt<TaskService>();
    taskDataList = await _taskService.getTaskList(currentUserId, albumId);
    notifyListeners();
  }

  Future<void> onTapAlbumListItem(BuildContext context, AlbumData data) async {
    NavigationHelper().push<AlbumAddViewModel>(
      context: context,
      pageBuilder: (_) => const AlbumAddPage(),
      viewModelBuilder: (context) => AlbumAddViewModel(
        albumData: data,
      ),
    );
  }

  Future<void> onTapListItem(BuildContext context, TaskData taskData, int currentIndex) async {
    NavigationHelper().push<TaskAddViewModel>(
      context: context,
      pageBuilder: (_) => const TaskAddPage(),
      viewModelBuilder: (context) => TaskAddViewModel(
        albumData: albumDataList[currentIndex],
        taskData: taskData,
      ),
    );
  }

  Future<void> onTapVideoPlayItem(BuildContext context, AlbumData data) async {
    if(data.youtubeUrl != null) {
      DialogUtil.showPreventPopSelectDialog(
        context: context,
        content: "Youtubeで参考演奏を再生しますか？",
      ).then((result) async {
        if (result == DialogAnswer.yes) {
          NavigationHelper().push<WebviewViewModel>(
            context: context,
            pageBuilder: (_) => WebviewPage(),
            viewModelBuilder: (context) =>
                WebviewViewModel(
                  youtubeUrl: data.youtubeUrl!,
                ),
          );
        }
      }
    );
    } else {
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        title: "再生エラー",
        content: "参考演奏が登録されていません",
      );
    }
  }
}
