import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:taskmum_flutter/components/splash/splash_page.dart';
import 'package:taskmum_flutter/components/splash/splash_view_model.dart';
import 'package:taskmum_flutter/utility/locator.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';
import 'components/wiget/common_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'taskMum',
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
      navigatorObservers: [RouteObserverProvider.of(context)],
      navigatorKey: NavigationHelper.navigatorKey,
    );
  }
}
