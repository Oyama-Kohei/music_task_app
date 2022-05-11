import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmum_flutter/components/models/task_data.dart';
import 'package:taskmum_flutter/components/service/album_service.dart';
import 'package:taskmum_flutter/components/service/auth_service.dart';
import 'package:taskmum_flutter/components/service/service.dart';
import 'package:taskmum_flutter/components/service/task_service.dart';
import 'package:taskmum_flutter/components/page/start_page.dart';
import 'package:taskmum_flutter/components/page/top_page.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';
import 'package:taskmum_flutter/components/view_model/start_view_model.dart';
import 'package:taskmum_flutter/components/view_model/top_view_model.dart';
import 'package:taskmum_flutter/utility/locator.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

class SplashViewModel extends ChangeNotifier{
  Future<void> initApp(BuildContext context) async {
    gotoNextScreen(context);
  }

  void showStartPage(BuildContext context){
    NavigationHelper().pushAndRemoveUntilRoot<StartViewModel>(
      context: context,
      pageBuilder: (_) => StartPage(),
      viewModelBuilder: (context) {
        return StartViewModel();
      },
    );
  }

  Future<void> showTopPage(BuildContext context) async {
    final UserService _userService = getIt<UserService>();
    final currentUserId = await _userService.getUserId();

    final AlbumService _albumService = getIt<AlbumService>();
    final albumList = await _albumService.getAlbumList(currentUserId);

    final List<TaskData>? taskList;

    final TaskService _taskService = getIt<TaskService>();
    if(albumList!.isNotEmpty) {
      taskList = await _taskService.getTaskList(
          currentUserId, albumList[0].albumId);
    } else {
      taskList = null;
    }

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
  }

  Future<void> gotoNextScreen(BuildContext context) async {
    Future.delayed(
      const Duration(milliseconds: 3000),
        () async{
          if (FirebaseAuth.instance.currentUser != null) {
            final user = FirebaseAuth.instance.currentUser;
            showTopPage(context);
          } else{
            showStartPage(context);
          }
        }
    );
  }
}