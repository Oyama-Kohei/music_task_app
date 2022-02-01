import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:taskmum_flutter/components/top/top_view_model.dart';
import 'package:taskmum_flutter/components/wiget/common_colors.dart';
import 'package:taskmum_flutter/components/wiget/music_album_item.dart';
import 'package:taskmum_flutter/components/wiget/task_list_item.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}
class _TopPageState extends State<TopPage> {

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      backgroundColor: CommonColors.customSwatch.shade50,
        body: Center(
          child: Consumer<TopViewModel>(builder: (context, viewModel, child){
            return Padding(padding: const EdgeInsets.fromLTRB(0, 70, 0, 20),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 250,
                    child: Swiper(
                      itemCount: 3,
                      layout: SwiperLayout.DEFAULT,
                      itemBuilder: (BuildContext context, int index) {
                        return MusicAlbumItem();
                      },
                      viewportFraction: 0.8,
                      scale: 0.9,
                      pagination: const SwiperPagination(),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          listView(viewModel, width, height),
                        ],
                      ),
                    )
                  ),
                ]
              ),
            );
            }),
          )
        );
    }
}

Widget listView(TopViewModel viewModel, double width, double height) {
  final List<Widget> taskList = [];

  for(final data in viewModel.dataList){
    taskList.add(TaskListItem(
      data: data,
      // onPress: viewModel.onTapListItem,
      width: width * 0.8,
      height: height * 0.8,
    ));
  }

  return Container(
    width: width,
    child: SingleChildScrollView(
      child: Column(
        children: taskList,
      ),
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