import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taskmum_flutter/components/models/album_data.dart';
import 'package:taskmum_flutter/components/models/task_data.dart';
import 'package:taskmum_flutter/components/page/album_add_page.dart';
import 'package:taskmum_flutter/components/page/splash_page.dart';
import 'package:taskmum_flutter/components/page/task_add_page.dart';
import 'package:taskmum_flutter/components/service/auth_service.dart';
import 'package:taskmum_flutter/components/service/service.dart';
import 'package:taskmum_flutter/components/service/task_service.dart';
import 'package:taskmum_flutter/components/service/user_service.dart';
import 'package:taskmum_flutter/components/view_model/album_add_view_model.dart';
import 'package:taskmum_flutter/components/view_model/splash_view_model.dart';
import 'package:taskmum_flutter/components/view_model/task_add_view_model.dart';
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

  List<AlbumData> albumDataList;

  // findService<T extends Service>(){
  //   for(Service service in services!){
  //     if(service is T){
  //       return service;
  //     }
  //   }
  // }

  Future<void> onTapLogout(BuildContext context) async {
    showDialog(
        context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("ログアウトしますか？"),
          actions: <Widget>[
            // ボタン領域
            FlatButton(
              child: const Text("キャンセル"),
              onPressed: () {
                Navigator.pop(context);
              }
            ),
            FlatButton(
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

  Future<void> onTapAddList(BuildContext context, AlbumData albumData) async {
    NavigationHelper().push<TaskAddViewModel>(
      context: context,
      pageBuilder: (_) => const TaskAddPage(),
      viewModelBuilder: (context) => TaskAddViewModel(albumData: albumData),
    );
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
}
