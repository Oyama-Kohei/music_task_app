import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/view_model/top_view_model.dart';
import 'package:taskmum_flutter/components/wiget/album_list_item.dart';
import 'package:taskmum_flutter/components/wiget/common_colors.dart';
import 'package:taskmum_flutter/components/wiget/task_list_item.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}
class _TopPageState extends State<TopPage> with RouteAware{

  static const pageViewHeight = 235.0;

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
    return Consumer<TopViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
          backgroundColor: CommonColors.customSwatch.shade50,
          body: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: height * 0.05),
                  SizedBox(
                    height: pageViewHeight,
                    child: PageView(
                      controller: viewModel.albumPageController,
                      onPageChanged: (value) => viewModel.onAlbumPageChanged(value),
                      children: viewModel.albumDataList
                        .map(
                          (e) => AlbumListItem(
                            data:  e,
                            onTapCard: (data) => viewModel.onTapAlbumListItem(context, data),
                            onTapVideo: (data) => viewModel.onTapVideoPlayItem(context, data),
                          ),
                        ).toList(),
                    )
                  ),
                  const SizedBox(height: 20),
                  listView(viewModel, width, height, context),
                ]
              ),
          ),
          floatingActionButton: FloatingButton(viewModel, fabKey, width, height),
      );
    }
    );
  }
}

Widget listView(
    TopViewModel viewModel,
    double width,
    double height,
    BuildContext context,) {
  final List<Widget> taskListWidget = [];
  viewModel.getTaskDataList(
      context,
      viewModel.albumDataList[viewModel.albumPageNotifier.value].albumId);
  if(viewModel.taskDataList == null){
    return const SizedBox(height: 0);
  } else {
    for (final data in viewModel.taskDataList!) {
      taskListWidget.add(TaskListItem(
        data: data,
        onPress: (data) => viewModel.onTapListItem(
          context,
          data,
          viewModel.albumPageNotifier.value,
        ),
        width: width * 0.8,
        height: 65,
      ),
      );
    }
    return SizedBox(
      width: width,
      height: height * 0.5,
      child: SingleChildScrollView(
        child: Column(
          children: taskListWidget,
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget FloatingButton(
    TopViewModel viewModel,
    GlobalKey<FabCircularMenuState> fabKey,
    double width,
    double height){
  return Builder(
    builder: (context) => FabCircularMenu(
      key: fabKey,
      alignment: Alignment.bottomRight,
      ringColor: Colors.white.withAlpha(25),
      ringDiameter: width * 1.1,
      ringWidth: width * 0.35,
      fabSize: 64.0,
      fabIconBorder: const CircleBorder(),
      fabColor: Colors.white,
      fabOpenIcon: const Icon(Icons.menu, color: Colors.blueGrey),
      fabCloseIcon: const Icon(Icons.close, color: Colors.blueGrey),
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.easeInOutCirc,
      onDisplayChange: (isOpen) {
        // _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
      },
      children: <Widget>[
        TextButton.icon(
          onPressed: () => viewModel.onTapAddAlbum(context),
          icon: const Icon(
            Icons.add_to_photos_rounded,
            size: 35,
            color: Colors.white),
          label: const Text(
              "NewMusic",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white)
          ),
        ),
        TextButton.icon(
          onPressed: () {
            viewModel.onTapAddList(context, viewModel.albumPageNotifier.value);
          },
          icon: const Icon(
              Icons.add_task,
              size: 35,
              color: Colors.white),
          label: const Text(
              "NewTask",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white)
          ),
        ),
        TextButton.icon(
          onPressed: () => viewModel.onTapLogout(context),
          icon: const Icon(
              Icons.add_to_home_screen,
              size: 35,
              color: Colors.white),
          label: const Text(
              "Logout",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white)
          ),
        ),
      ],
    ),
  );
}
