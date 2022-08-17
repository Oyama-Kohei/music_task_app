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
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

enum AcquireStatus {
  loading,
  hasData,
  noData,
}

extension AcquireStatusExtension on AcquireStatus {
  Widget getStatus() {
    switch (this) {
      case AcquireStatus.loading:
        return const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.black54));
      case AcquireStatus.hasData:
        return const Text('');
      case AcquireStatus.noData:
        return Text('No Task Setting', style: GoogleFonts.caveat(fontSize: 20));
    }
  }
}

class TopViewModel extends ChangeNotifier {
  TopViewModel({
    List<Service>? services,
    required this.albumDataList,
    required this.taskDataList,
    required this.initialPage,
  });

  List<Service>? services;

  List<TaskData>? taskDataList;

  List<AlbumData> albumDataList = [];

  List<List<TaskData>?> allTaskDataList = []..length = 50;

  final int initialPage;

  BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-8754541206691079/6762182762',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  )..load();

  int albumPageChangedCount = 0;
  int reloadCount = 0;

  bool nonUpdateFlag = false;

  static const List<String> movementList = [
    'なし',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
  ];

  PageController albumPageController = PageController(viewportFraction: 0.85);

  final albumPageNotifier = ValueNotifier<int>(0);

  AcquireStatus acquireStatus = AcquireStatus.hasData;

  Future<void> initApp(BuildContext context) async {
    albumPageController = PageController(viewportFraction: 0.85, initialPage: initialPage);
  }

  Future<void> onAlbumPageChanged(BuildContext context, int index) async {
    albumPageNotifier.value = index;
    if (allTaskDataList[index] == null) {
      await getTaskDataList(context, index);
    }
    fetchTaskList();
    if (albumPageChangedCount == 10) {
      nonUpdateFlag = true;
      showLoadingCircle(context);
      if (reloadCount == 5) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.only(top: 50),
                title: Column(
                  children: [
                    Text(
                      'Now reloading...',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.caveat(fontSize: 30),
                    ),
                    Text(
                      '画面再読み込み中です。\n少々お待ちください。',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.caveat(fontSize: 16),
                    ),
                  ],
                ),
                content: Image.asset(
                  'images/Metronom.png',
                ),
              );
            });
        await Future.delayed(const Duration(seconds: 4), () {
          dismissLoadingCircle(context);
          NavigationHelper().pushAndRemoveUntilRoot<SplashViewModel>(
            pageBuilder: (_) => const SplashPage(),
            viewModelBuilder: (_) => SplashViewModel(initialPage: index),
          );
        });
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          dismissLoadingCircle(context);
          myBanner.load();
          albumPageChangedCount = 0;
          reloadCount++;
        });
        nonUpdateFlag = false;
      }
    }
    albumPageChangedCount++;
  }

  Future<void> onTapLogout(BuildContext context) async {
    try {
      DialogUtil.showPreventPopDialog(
        context: context,
        content: 'ログアウトしますか？',
        actions: <Widget>[
          SimpleDialogOption(
            child: const Text(
              "Cancel",
              textAlign: TextAlign.center,
            ),
            onPressed: () => {Navigator.pop(context)},
          ),
          SimpleDialogOption(
            child: const Text(
              "OK",
              textAlign: TextAlign.center,
            ),
            onPressed: () async {
              showLoadingCircle(context);
              final _authService = getIt<AuthService>();
              await _authService.signOut();
              dismissLoadingCircle(context);
              // ignore: avoid_print
              print('ログアウト');
              NavigationHelper().pushAndRemoveUntilRoot<SplashViewModel>(
                pageBuilder: (_) => const SplashPage(),
                viewModelBuilder: (_) => SplashViewModel(),
              );
            },
          ),
        ],
      );
    } catch (e) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: 'ログアウトに失敗しました',
      );
    }
  }

  Future<void> onTapUnsubscribe(BuildContext context) async {
    try {
      DialogUtil.showPreventPopDialog(
        context: context,
        content: '退会しますか？\n退会する場合は少々時間がかかる場合があります。',
        actions: <Widget>[
          SimpleDialogOption(
            child: const Text(
              "Cancel",
              textAlign: TextAlign.center,
            ),
            onPressed: () => {Navigator.pop(context)},
          ),
          SimpleDialogOption(
            child: const Text(
              "OK",
              textAlign: TextAlign.center,
            ),
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
                pageBuilder: (_) => const SplashPage(),
                viewModelBuilder: (_) => SplashViewModel(),
              );
            },
          ),
        ],
      );
    } catch (_) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: '退会に失敗しました',
      );
    }
  }

  void onTapAddList(BuildContext context, int currentIndex) {
    if (albumDataList.isNotEmpty) {
      NavigationHelper().push<TaskAddViewModel>(
        context: context,
        pageBuilder: (_) => const TaskAddPage(),
        viewModelBuilder: (context) =>
            TaskAddViewModel(albumData: albumDataList[currentIndex]),
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

  void onTapAddAlbum(BuildContext context) {
    NavigationHelper().push<AlbumAddViewModel>(
      context: context,
      pageBuilder: (_) => const AlbumAddPage(),
      viewModelBuilder: (context) => AlbumAddViewModel(),
    );
  }

  void fetchTaskList() {
    taskDataList = allTaskDataList[albumPageNotifier.value];
    notifyListeners();
  }

  void initAllTaskDataList() {
    for (int i = 0; i < 50; i++) {
      allTaskDataList[i] = null;
    }
    myBanner.load();
    albumPageChangedCount = 0;
  }

  Future<void> getTaskDataList(BuildContext context, int index) async {
    try {
      if (albumDataList.isNotEmpty) {
        acquireStatus = AcquireStatus.loading;
        notifyListeners();

        final UserService _userService = getIt<UserService>();
        final currentUserId = await _userService.getUserId();

        final TaskService _taskService = getIt<TaskService>();
        List<TaskData>? result = await _taskService.getTaskList(
            currentUserId, albumDataList[index].albumId);
        // ignore: avoid_print
        print('タスクデータ取得');
        if (result != null) {
          acquireStatus = AcquireStatus.hasData;
          if (result.isNotEmpty) {
            allTaskDataList[index] = result;
          } else {
            allTaskDataList[index] = [];
          }
        } else {
          acquireStatus = AcquireStatus.noData;
          allTaskDataList[index] = [];
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('タスクデータの取得に失敗しました。通信環境等をご確認ください。')));
    }
  }

  Future<void> getAlbumDataList(BuildContext context) async {
    try {
      final UserService _userService = getIt<UserService>();
      final currentUserId = await _userService.getUserId();

      final AlbumService _albumService = getIt<AlbumService>();
      albumDataList = (await _albumService.getAlbumList(currentUserId))!;
      // ignore: avoid_print
      print('アルバムリスト取得');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('アルバムの取得に失敗しました。通信環境等をご確認ください。')));
    }
    notifyListeners();
  }

  void onTapAlbumListItem(BuildContext context, AlbumData data) {
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

  void onTapListItem(
      BuildContext context, TaskData taskData, int currentIndex) {
    NavigationHelper().push<TaskAddViewModel>(
      context: context,
      pageBuilder: (_) => const TaskAddPage(),
      viewModelBuilder: (context) => TaskAddViewModel(
        albumData: albumDataList[currentIndex],
        taskData: taskData,
      ),
    );
  }

  void onTapVideoPlayItem(BuildContext context, AlbumData data) {
    if (data.youtubeUrl != null) {
      DialogUtil.showPreventPopSelectDialog(
        context: context,
        content: '参考演奏を再生しますか？',
      ).then((result) async {
        if (result == DialogAnswer.yes) {
          NavigationHelper().push<WebviewViewModel>(
            context: context,
            pageBuilder: (_) => const WebviewPage(),
            viewModelBuilder: (context) => WebviewViewModel(
              youtubeUrl: data.youtubeUrl!,
            ),
          );
        }
      });
    } else {
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        title: '再生エラー',
        content: '参考演奏が登録されていません',
      );
    }
  }
}
