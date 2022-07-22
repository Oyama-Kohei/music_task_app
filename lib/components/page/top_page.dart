import 'package:askMu/components/page/popup_terms_page.dart';
import 'package:askMu/components/view_model/popup_terms_view_model.dart';
import 'package:askMu/main.dart';
import 'package:askMu/utility/navigation_helper.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:askMu/components/view_model/top_view_model.dart';
import 'package:askMu/components/wiget/album_list_item.dart';
import 'package:askMu/components/wiget/task_list_item.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> with RouteAware {
  static const pageViewHeight = 200.0;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool _isOpen = false;

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
  Future<void> didPopNext() async {
    Future(() async {
      await Provider.of<TopViewModel>(context, listen: false)
          .getAlbumDataList(context);
      await Provider.of<TopViewModel>(context, listen: false)
          .getTaskDataList(context);
    });
    _closeMenu();
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    return Scaffold(
      key: scaffoldKey,
      drawer: Consumer<TopViewModel>(
          builder: (context, viewModel, child) =>
              MenuDrawer(viewModel, context)),
      backgroundColor: Colors.white,
      body: Center(
        child: Consumer<TopViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.albumDataList.isEmpty
                ? Column(
                    children: [
                      SizedBox(height: height * 0.1),
                      Text(
                        'Welcome to .askMu...',
                        style: GoogleFonts.caveat(
                            fontSize: 40, color: Colors.black),
                      ),
                      Image.asset(
                        'images/Splash.png',
                        width: width * 0.9,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Text(
                          '現在楽曲が未登録です\n下のボタンから『NewMusic』を選択して曲のカードを追加しよう',
                          style: GoogleFonts.sawarabiMincho(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  )
                : CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        elevation: 0.0,
                        expandedHeight: pageViewHeight + kToolbarHeight + 50,
                        pinned: true,
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.white,
                        flexibleSpace: FlexibleSpaceBar(
                          title: const SizedBox(height: 0),
                          background: Column(
                            children: [
                              SizedBox(height: height * 0.06),
                              Stack(
                                children: [
                                  Stack(
                                    children: [
                                      const Image(
                                        image: AssetImage('images/Header.png'),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '.askMu...',
                                          style: GoogleFonts.caveat(
                                              fontSize: 40,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 60),
                                    height: pageViewHeight + 60,
                                    child: PageView(
                                      controller: viewModel.albumPageController,
                                      onPageChanged: (value) => viewModel
                                          .onAlbumPageChanged(context, value),
                                      children: viewModel.albumDataList
                                          .map(
                                            (e) => AlbumListItem(
                                              data: e,
                                              onTapCard: (data) =>
                                                  viewModel.onTapAlbumListItem(
                                                      context, data),
                                              onTapVideo: (data) =>
                                                  viewModel.onTapVideoPlayItem(
                                                      context, data),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: height * 0.03),
                            ],
                          ),
                        ),
                      ),
                      if (viewModel.taskDataList != null)
                        listView(width, height, context, viewModel),
                    ],
                  );
          },
        ),
      ),
      floatingActionButton: FloatingButton(width, height),
    );
  }

  // ignore: non_constant_identifier_names
  Widget FloatingButton(double width, double height) {
    return Builder(
      builder: (context) => FabCircularMenu(
        key: fabKey,
        alignment: Alignment.bottomRight,
        ringColor: const Color(0xff696969),
        ringDiameter: width * 1.0,
        ringWidth: width * 0.35,
        fabSize: 80.0,
        fabIconBorder: const CircleBorder(),
        fabColor: const Color(0xff696969),
        fabOpenIcon: const Icon(Icons.menu, color: Colors.white),
        fabCloseIcon: const Icon(Icons.close, color: Colors.white),
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.easeInOutCirc,
        onDisplayChange: (bool isOpen) {
          setState(() {
            _isOpen = isOpen;
          });
        },
        children: <Widget>[
          TextButton.icon(
            onPressed: () => Provider.of<TopViewModel>(context, listen: false)
                .onTapAddAlbum(context),
            icon: const Icon(Icons.add_to_photos_rounded,
                size: 34, color: Colors.white),
            label: Text(
              'NewMusic',
              style: GoogleFonts.caveat(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              Provider.of<TopViewModel>(context, listen: false).onTapAddList(
                context,
                Provider.of<TopViewModel>(context, listen: false)
                    .albumPageNotifier
                    .value,
              );
            },
            icon: const Icon(
              Icons.add_task,
              size: 34,
              color: Colors.white,
            ),
            label: Text(
              'NewTask',
              style: GoogleFonts.caveat(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton.icon(
            // onPressed: () => viewModel.onTapLogout(context),
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(Icons.menu, size: 34, color: Colors.white),
            label: Text(
              'Menu',
              style: GoogleFonts.caveat(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _closeMenu() {
    if (fabKey.currentState?.isOpen ?? false) {
      fabKey.currentState!.close();
    }
  }
}

// ignore: non_constant_identifier_names
Widget MenuDrawer(TopViewModel viewModel, BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        ListTile(
          title: const Text('利用規約・プライバシーポリシー'),
          onTap: () {
            NavigationHelper().pushNonMaterialRoute<PopupTermsViewModel>(
              context: context,
              pageBuilder: (_) => const PopupTermsPage(),
              viewModelBuilder: (context) =>
                  PopupTermsViewModel(agreeFlag: false),
            );
          },
        ),
        ListTile(
          title: const Text('ログアウト'),
          onTap: () {
            viewModel.onTapLogout(context);
          },
        ),
        ListTile(
          title: const Text('退会'),
          onTap: () {
            viewModel.onTapUnsubscribe(context);
          },
        ),
      ],
    ),
  );
}

Widget listView(
    double width, double height, BuildContext context, TopViewModel viewModel) {
  final List<Widget> taskListWidget = [];
  BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-8754541206691079/4153658345',
    size: AdSize.banner,
    request: const AdRequest(),
    listener: const BannerAdListener(),
  )..load();
  var movementNum = 0;
  if (viewModel.acquireStatus == AcquireStatus.hasData)
    // ignore: curly_braces_in_flow_control_structures
    for (final data in viewModel.taskDataList!) {
      if (movementNum != data.movementNum) {
        movementNum = data.movementNum;
        taskListWidget.add(
          Container(
            alignment: Alignment.centerLeft,
            height: 20,
            width: width * 0.85,
            child: Text(
              TopViewModel.movementList[movementNum],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        );
      }
      taskListWidget.add(
        TaskListItem(
          data: data,
          onPress: (data) => viewModel.onTapListItem(
            context,
            data,
            viewModel.albumPageNotifier.value,
          ),
          width: width * 0.8,
          height: 69,
        ),
      );
    }
  else {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
            children: [
              Container(
                height: 70,
                width: 70,
                padding: const EdgeInsets.all(10),
                child: viewModel.acquireStatus.getStatus(),
              ),
            ],
          )
        ],
      ),
    );
  }
  taskListWidget.add(
    bannerAdWidget(myBanner, width),
  );
  taskListWidget.add(
    Container(height: height * 0.2),
  );
  return SliverList(
    delegate: SliverChildListDelegate(
      [
        Column(
          children: taskListWidget,
        )
      ],
    ),
  );
}

Widget bannerAdWidget(myBanner, double width) {
  return StatefulBuilder(
    builder: (context, setState) => Container(
      height: 50.0,
      width: width * 0.8,
      child: AdWidget(ad: myBanner),
      alignment: Alignment.center,
    ),
  );
}
