import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/view_model/top_view_model.dart';
import 'package:taskmum_flutter/components/wiget/common_colors.dart';
import 'package:taskmum_flutter/components/wiget/music_album_item.dart';
import 'package:taskmum_flutter/components/wiget/task_list_item.dart';
import 'package:taskmum_flutter/main.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}
class _TopPageState extends State<TopPage> with RouteAware{
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<void> didPopNext() async {
    // TODO(): もう少しいい方法がありそう。。。
    // final viewModel = Provider.of<TopViewModel>(context, listen: false);
    // await viewModel.getTaskDataList(context, viewModel.albumDataList[_currentIndex].albumId);
    setState(() {});
  }

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
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 70, 0, 20),
                  child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: height * 0.25,
                          child: Swiper(
                            index: _currentIndex,
                            loop: false,
                            itemCount: viewModel.albumDataList.length,
                            layout: SwiperLayout.DEFAULT,
                            itemBuilder: (BuildContext context, int index) {
                              return MusicAlbumItem(
                                  dataList: viewModel.albumDataList,
                                  index: _currentIndex,);
                            },
                            viewportFraction: 0.8,
                            scale: 0.9,
                            pagination: const SwiperPagination(),
                            onIndexChanged: (int index) async {
                              _currentIndex = index;
                              if(viewModel.albumDataList.isNotEmpty){
                                await viewModel.getTaskDataList(
                                    context,
                                    viewModel.albumDataList[_currentIndex].albumId);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        listView(viewModel, width, height, _currentIndex, context),
                      ]
                  )
              )
          ),
          floatingActionButton: FloatingButton(viewModel, fabKey, width, height, _currentIndex),
      );
    }
    );
  }
}

Widget listView(
    TopViewModel viewModel,
    double width,
    double height,
    int currentIndex,
    BuildContext context,) {
  final List<Widget> taskListWidget = [];
  viewModel.getTaskDataList(
      context,
      viewModel.albumDataList[currentIndex].albumId);
  if(viewModel.taskDataList == null){
    return const SizedBox(height: 0);
  } else {
    for (final data in viewModel.taskDataList!) {
      taskListWidget.add(TaskListItem(
        data: data,
        onPress: (data) => viewModel.onTapListItem(
          context,
          data,
          currentIndex,
        ),
        width: width * 0.8,
        height: height * 0.08,
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
    double height,
    int _currentIndex){
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
            viewModel.onTapAddList(context, _currentIndex);
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
