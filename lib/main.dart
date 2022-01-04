import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';
import 'components/wiget/common_colors.dart';
import 'components/start_page/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'taskMum',
      theme: ThemeData(
        primarySwatch: CommonColors.customSwatch,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      //Todo: 多言語化宣言

      // ここにアプリ起動時に表示するWidgetを宣言する
      home: MyHomePage(),
      navigatorKey: NavigationHelper.navigatorKey,
    );
  }
}