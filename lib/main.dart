import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:askMu/components/service/album_service.dart';
import 'package:askMu/components/service/auth_service.dart';
import 'package:askMu/components/service/task_service.dart';
import 'package:askMu/components/service/user_service.dart';
import 'package:askMu/components/page/splash_page.dart';
import 'package:askMu/components/view_model/splash_view_model.dart';
import 'package:askMu/utility/locator.dart';
import 'package:askMu/utility/navigation_helper.dart';
import 'components/wiget/common_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
        providers: [
          RouteObserverProvider(),
        ],
        child: MyApp()
      ),
  );
}

final RouteObserver routeObserver = RouteObserver();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<TaskService>(
            create: (_) => TaskService()),
        Provider<AuthService>(
            create: (_) => AuthService()),
        Provider<UserService>(
            create: (_) => UserService()),
        Provider<AlbumService>(
            create: (_) => AlbumService()),
      ],
    child: MaterialApp(
      title: 'askMu',
      theme: ThemeData(
        primarySwatch: CommonColors.customSwatch,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme
              .of(context)
              .textTheme,
        ),
      ),
      home: ChangeNotifierProvider(
        create: (_) => SplashViewModel(),
        child: SplashPage(),
      ),
      navigatorObservers: [routeObserver],
      navigatorKey: NavigationHelper.navigatorKey,
    )
    );
  }
}
