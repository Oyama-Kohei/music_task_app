import 'package:askMu/components/models/youtube_data.dart';
import 'package:askMu/utility/dialog_util.dart';
import 'package:askMu/utility/loading_circle.dart';
import 'package:askMu/utility/youtube_thumbnail_generator_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:askMu/components/models/task_data.dart';
import 'package:askMu/components/service/album_service.dart';
import 'package:askMu/components/service/auth_service.dart';
import 'package:askMu/components/service/service.dart';
import 'package:askMu/components/service/task_service.dart';
import 'package:askMu/components/page/start_page.dart';
import 'package:askMu/components/page/top_page.dart';
import 'package:askMu/components/service/user_service.dart';
import 'package:askMu/components/view_model/start_view_model.dart';
import 'package:askMu/components/view_model/top_view_model.dart';
import 'package:askMu/utility/locator.dart';
import 'package:askMu/utility/navigation_helper.dart';

class SplashViewModel extends ChangeNotifier {
  Future<void> initApp(BuildContext context) async {
    gotoNextScreen(context);
  }

  void showStartPage(BuildContext context) {
    NavigationHelper().pushAndRemoveUntilRoot<StartViewModel>(
      context: context,
      pageBuilder: (_) => StartPage(),
      viewModelBuilder: (context) {
        return StartViewModel();
      },
    );
  }

  Future<void> showTopPage(BuildContext context) async {
    try {
      showLoadingCircle(context);
      final UserService _userService = getIt<UserService>();
      final currentUserId = await _userService.getUserId();

      final AlbumService _albumService = getIt<AlbumService>();
      final albumList = await _albumService.getAlbumList(currentUserId);

      final List<TaskData>? taskList;

      final TaskService _taskService = getIt<TaskService>();
      if (albumList!.isNotEmpty) {
        taskList =
            await _taskService.getTaskList(currentUserId, albumList[0].albumId);
      } else {
        taskList = null;
      }
      dismissLoadingCircle(context);
      NavigationHelper().pushAndRemoveUntilRoot<TopViewModel>(
        context: context,
        pageBuilder: (_) => const TopPage(),
        viewModelBuilder: (context) {
          return TopViewModel(
            services: [
              Service.of<TaskService>(context),
              Service.of<AuthService>(context),
            ],
            albumDataList: albumList,
            taskDataList: taskList,
          );
        },
      );
    } on Exception catch (_) {
      dismissLoadingCircle(context);
      DialogUtil.showPreventPopErrorDialog(
        context: context,
        content: '?????????????????????????????????????????????????????????',
      );
    }
  }

  Future<void> gotoNextScreen(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        showTopPage(context);
      } else {
        showStartPage(context);
      }
    });
  }
}
