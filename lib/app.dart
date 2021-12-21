import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:taskmum_flutter/components/state_notifier/auth_controllar.dart';
import 'package:taskmum_flutter/utility/navigation_helper.dart';
import 'components/wiget/common_colors.dart';
import 'components/start_page/start_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    const locale = Locale('ja', 'JP');
    return MaterialApp(
      title: 'taskMum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: CommonColors.customSwatch,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.notoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      //Todo: 多言語化宣言
      localizationsDelegates: const [
      ],
      supportedLocales: const [
        locale,
      ],
      // ここにアプリ起動時に表示するWidgetを宣言する
      home: HomeScreen(),
      navigatorKey: NavigationHelper.navigatorKey,
    );

  }
}
class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context){
    final authControllerState = useProvider(authControllerProvider.state);
    return const Scaffold(

    );
  }
}