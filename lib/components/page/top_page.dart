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
import 'package:askMu/components/wiget/common_colors.dart';
import 'package:askMu/components/wiget/task_list_item.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}
class _TopPageState extends State<TopPage> with RouteAware{

  static const pageViewHeight = 200.0;
  late BannerAd myBanner;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey();
  bool _isOpen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void initState() {
    super.initState();
    myBanner = _createBanner(AdSize.banner);
  }

  @override
  void dispose() {
    myBanner.dispose();
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    Provider.of<TopViewModel>(context, listen: false).getAlbumDataList(context);
    Provider.of<TopViewModel>(context, listen: false).getTaskDataList(context);
    _closeMenu();
  }

  BannerAd _createBanner(AdSize size) {
    return BannerAd(
      size: size,
      adUnitId: 'ca-app-pub-8754541206691079/4153658345',
      listener: BannerAdListener(
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          myBanner.dispose();
          _createBanner(size);
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    final width = queryData.size.width;
    final height = queryData.size.height;
    return Consumer<TopViewModel>(builder: (context, viewModel, child) {
      // ignore: avoid_print
      print('トップページ更新');
      return Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              const DrawerHeader(
                child: Text(
                  'MenuBar',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),
              ListTile(
                title: const Text('利用規約・プライバシーポリシー'),
                onTap: () {
                  NavigationHelper().pushNonMaterialRoute<PopupTermsViewModel>(
                    context: context,
                    pageBuilder: (_) => PopupTermsPage(),
                    viewModelBuilder: (context) => PopupTermsViewModel(agreeFlag: false),
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
        ),
        backgroundColor: CommonColors.customSwatch.shade50,
        body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: height * 0.06),
                viewModel.albumDataList.isNotEmpty ?
                SizedBox(
                  height: pageViewHeight,
                  child: PageView(
                    controller: viewModel.albumPageController,
                    onPageChanged: (value) => viewModel.onAlbumPageChanged(context, value),
                    children: viewModel.albumDataList
                      .map(
                        (e) => AlbumListItem(
                          data:  e,
                          onTapCard: (data) => viewModel.onTapAlbumListItem(context, data),
                          onTapVideo: (data) => viewModel.onTapVideoPlayItem(context, data),
                        ),
                      ).toList(),
                  )
                ) :
                Container(
                  height: height * 0.6,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'New Music',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.orbitron(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: height * 0.05),
                              Text(
                                'まずは画面下のボタンから\n'
                                    'アルバムを追加',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.orbitron(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: ClipRRect(
                            child: Image.asset(
                              'images/Tutorial1.png',
                              width: width * 0.45,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      ]
                  ),
                ),
                const SizedBox(height: 20),
                viewModel.taskDataList != null ?
                listView(viewModel, width, height, context, myBanner) : const SizedBox(height: 0,),
              ]
            ),
        ),
        floatingActionButton: FloatingButton(viewModel, width, height),
      );
    }
    );
  }
  // ignore: non_constant_identifier_names
  Widget FloatingButton(
      TopViewModel viewModel,
      double width,
      double height){
    return Builder(
      builder: (context) => FabCircularMenu(
        key: fabKey,
        alignment: Alignment.bottomRight,
        ringColor: CommonColors.customSwatch.shade300,
        ringDiameter: width * 1.0,
        ringWidth: width * 0.35,
        fabSize: 65.0,
        fabIconBorder: const CircleBorder(),
        fabColor: Colors.white,
        fabOpenIcon: const Icon(Icons.menu, color: Colors.blueGrey),
        fabCloseIcon: const Icon(Icons.close, color: Colors.blueGrey),
        animationDuration: const Duration(milliseconds: 800),
        animationCurve: Curves.easeInOutCirc,
        onDisplayChange: (bool isOpen) {
          setState(() {
            _isOpen = isOpen;
          });
        },
        children: <Widget>[
          TextButton.icon(
            onPressed: () => viewModel.onTapAddAlbum(context),
            icon: const Icon(
                Icons.add_to_photos_rounded,
                size: 35,
                color: Colors.white),
            label: const Text(
                'NewMusic',
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
                'NewTask',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white)
            ),
          ),
          TextButton.icon(
            // onPressed: () => viewModel.onTapLogout(context),
            onPressed: () => scaffoldKey.currentState?.openDrawer(),
            icon: const Icon(
                Icons.menu,
                size: 35,
                color: Colors.white),
            label: const Text(
                'Menu',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white)
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

Widget listView(
    TopViewModel viewModel,
    double width,
    double height,
    BuildContext context,
    BannerAd myBanner) {
  final List<Widget> taskListWidget = [];
  var movementNum = 0;
  for (final data in viewModel.taskDataList!) {
    if(movementNum != data.movementNum){
      movementNum = data.movementNum;
      taskListWidget.add(
        Container(
          alignment: Alignment.centerLeft,
          height: 20,
          width: width * 0.9,
          child: Text(
            TopViewModel.movementList[movementNum],
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
  taskListWidget.add(
    bannerAdWidget(myBanner, width),
  );
  taskListWidget.add(
    Container(
      height: height * 0.2
    ),
  );
  return SizedBox(
    height: height * 0.6,
    width: width,
    child: SingleChildScrollView(
      child: Column(
        children: taskListWidget,
      ),
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
