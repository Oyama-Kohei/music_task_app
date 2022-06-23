import 'package:askMu/components/service/album_service.dart';
import 'package:askMu/utility/loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:askMu/components/models/album_data.dart';
import 'package:askMu/components/models/task_data.dart';
import 'package:askMu/components/page/album_add_page.dart';
import 'package:askMu/components/page/splash_page.dart';
import 'package:askMu/components/page/task_add_page.dart';
import 'package:askMu/components/page/webview_page.dart';
import 'package:askMu/components/service/auth_service.dart';
import 'package:askMu/components/service/service.dart';
import 'package:askMu/components/service/task_service.dart';
import 'package:askMu/components/service/user_service.dart';
import 'package:askMu/components/view_model/album_add_view_model.dart';
import 'package:askMu/components/view_model/splash_view_model.dart';
import 'package:askMu/components/view_model/task_add_view_model.dart';
import 'package:askMu/components/view_model/webview_view_model.dart';
import 'package:askMu/utility/dialog_util.dart';
import 'package:askMu/utility/locator.dart';
import 'package:askMu/utility/navigation_helper.dart';

class TopViewModel extends ChangeNotifier{
  TopViewModel({
    List<Service>? services,
    required this.albumDataList,
    required this.taskDataList,
  });

  List<Service>? services;

  List<TaskData>? taskDataList;

  List<AlbumData> albumDataList = [];

  static const List<String> movementList = ['楽章なし', '1楽章', '2楽章', '3楽章', '4楽章', '5楽章', '6楽章', '7楽章', '8楽章', '9楽章', '10楽章'];

  final PageController albumPageController =
    PageController(viewportFraction: 0.85);

  final albumPageNotifier = ValueNotifier<int>(0);

  Future<void> onAlbumPageChanged(BuildContext context, int index) async {
    albumPageNotifier.value = index;
    await getTaskDataList(context);
    notifyListeners();
  }

  Future<void> onTapLogout(BuildContext context) async {
    try{
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('ログアウトしますか？'),
            actions: <Widget>[
              // ボタン領域
              TextButton(
                  child: const Text('キャンセル'),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  showLoadingCircle(context);
                  final _authService = getIt<AuthService>();
                  await _authService.signOut();
                  dismissLoadingCircle(context);
                  // ignore: avoid_print
                  print('ログアウト');
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
    } catch(e) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: 'ログアウトに失敗しました',
      );
    }
  }

  Future<void> onTapUnsubscribe(BuildContext context) async {
    try{
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('退会しますか？'),
            actions: <Widget>[
              // ボタン領域
              TextButton(
                  child: const Text('キャンセル'),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
              TextButton(
                  child: const Text('OK'),
                  onPressed: () async {
                    showLoadingCircle(context);
                    final UserService userService = getIt<UserService>();
                    final currentUserId = await userService.getUserId();
                    final _authService = getIt<AuthService>();
                    await _authService.unSubscribe(currentUserId);
                    dismissLoadingCircle(context);
                    // ignore: avoid_print
                    print('退会');
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
    } catch(_) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: '退会に失敗しました',
      );
    }
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
        title: 'アルバムがありません',
        content: 'タスクを追加する前に紐付け先のアルバムを追加してください',
      );
    }
    // ignore: avoid_print
    print('リスト追加をタップ');
  }

  Future<void> onTapAddAlbum(BuildContext context) async {
    NavigationHelper().push<AlbumAddViewModel>(
      context: context,
      pageBuilder: (_) => const AlbumAddPage(),
      viewModelBuilder: (context) => AlbumAddViewModel(),
    );
  }

  Future<void> getTaskDataList(BuildContext context) async {
    try{
      final UserService _userService = getIt<UserService>();
      final currentUserId = await _userService.getUserId();

      final TaskService _taskService = getIt<TaskService>();
      taskDataList = await _taskService.getTaskList(currentUserId, albumDataList[albumPageNotifier.value].albumId);
      // ignore: avoid_print
      print('タスクデータ取得');
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('タスクデータの取得に失敗しました。通信環境等をご確認ください。')));
    }
    notifyListeners();
  }

  Future<void> getAlbumDataList(BuildContext context) async {
    try{
      final UserService _userService = getIt<UserService>();
      final currentUserId = await _userService.getUserId();

      final AlbumService _albumService = getIt<AlbumService>();
      albumDataList = (await _albumService.getAlbumList(currentUserId))!;
      // ignore: avoid_print
      print('アルバムリスト取得');
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('アルバムの取得に失敗しました。通信環境等をご確認ください。')));
    }
    notifyListeners();
  }

  Future<void> onTapAlbumListItem(BuildContext context, AlbumData data) async {
    // ignore: avoid_print
    print('アルバムタップ');
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
        content: '参考演奏を再生しますか？',
      ).then((result) async {
        if (result == DialogAnswer.yes) {
          NavigationHelper().push<WebviewViewModel>(
            context: context,
            pageBuilder: (_) => const WebviewPage(),
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
        title: '再生エラー',
        content: '参考演奏が登録されていません',
      );
    }
  }
}
