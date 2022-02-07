import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/view_model/top_view_model.dart';
import 'package:taskmum_flutter/components/wiget/common_colors.dart';
import 'package:taskmum_flutter/components/wiget/music_album_item.dart';
import 'package:taskmum_flutter/components/wiget/task_list_item.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}
class _TopPageState extends State<TopPage> {
  late int _currentIndex;

  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
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
                        Container(
                          height: height * 0.25,
                          child: Swiper(
                            index: _currentIndex,
                            itemCount: viewModel.albumDataList.length,
                            layout: SwiperLayout.DEFAULT,
                            itemBuilder: (BuildContext context, int index) {
                              return MusicAlbumItem(
                                  dataList: viewModel.albumDataList,
                                  index: index,);
                            },
                            viewportFraction: 0.8,
                            scale: 0.9,
                            pagination: const SwiperPagination(),
                            onIndexChanged: (int index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        listView(viewModel, width, height),
                      ]
                  )
              )
          ),
          floatingActionButton: FloatingButton(viewModel, fabKey),
      );
    }
    );
  }
}

Widget listView(TopViewModel viewModel, double width, double height) {
  final List<Widget> taskList = [];

  for(final data in viewModel.taskDataList){
    taskList.add(TaskListItem(
      data: data,
      // onPress: viewModel.onTapListItem,
      width: width * 0.8,
      height: height * 0.08,
    ),
    );
  }
  return Container(
    width: width,
    height: height * 0.5,
    child: SingleChildScrollView(
      child: Column(
        children: taskList,
      ),
    ),
  );
}

Widget FloatingButton(TopViewModel viewModel, GlobalKey<FabCircularMenuState> fabKey){
  return Builder(
    builder: (context) => FabCircularMenu(
      key: fabKey,
      alignment: Alignment.bottomRight,
      ringColor: Colors.white.withAlpha(25),
      ringDiameter: 400.0,
      ringWidth: 150.0,
      fabSize: 64.0,
      fabElevation: 8.0,
      fabIconBorder: const CircleBorder(),
      fabColor: Colors.white,
      fabOpenIcon: Icon(Icons.menu, color: Colors.blueGrey),
      fabCloseIcon: Icon(Icons.close, color: Colors.blueGrey),
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.easeInOutCirc,
      onDisplayChange: (isOpen) {
        // _showSnackBar(context, "The menu is ${isOpen ? "open" : "closed"}");
      },
      children: <Widget>[
        RawMaterialButton(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          onPressed: () => viewModel.onTapLogout(context),
          child: const Icon(
            Icons.add_to_home_screen,
            size: 40,
            color: Colors.white),
        ),
        RawMaterialButton(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          onPressed: () => viewModel.onTapAddList(context),
          child: const Icon(
            Icons.add_task,
            size: 40,
            color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () {},
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: const Icon(
            Icons.add_to_photos_rounded,
            size: 40,
            color: Colors.white),
        )
      ],
    ),
  );
}


// floatingActionButton: FloatingActionButton(
// onPressed: () {
// FirebaseAuth.instance.signOut();
// // Navigator.of(context).push(
// //   MaterialPageRoute(builder: (context){
// //     return SplashPage();}
// //   )
// // );
// },
// child: Icon(Icons.mouse),
// backgroundColor: Colors.green,
// );