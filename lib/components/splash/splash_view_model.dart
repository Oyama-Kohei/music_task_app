import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmum_flutter/components/service/service.dart';
import 'package:taskmum_flutter/components/service/task_service.dart';
import 'package:taskmum_flutter/components/start_page/start_page.dart';
import 'package:taskmum_flutter/components/top/top_page.dart';
import 'package:taskmum_flutter/components/top/top_view_model.dart';
import 'package:taskmum_flutter/utility/locator.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';

class SplashViewModel extends ChangeNotifier{
  Future<void> initApp(BuildContext context) async {
    gotoNextScreen(context);
  }

  void showStartPage(BuildContext context){
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
          builder: (context) => MainStartPage()
      ),
      (route) => false
    );
  }

  Future<void> showTopPage(BuildContext context) async {
    final TaskService _taskService = getIt<TaskService>();
    final taskList = await _taskService.getTaskList();

    NavigationHelper().pushAndRemoveUntilRoot<TopViewModel>(
      context: context,
      pageBuilder: (_) => const TopPage(),
      viewModelBuilder: (context) {
        return TopViewModel(
          services: [
            Service.of<TaskService>(context),
          ],
          dataList: taskList!,
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