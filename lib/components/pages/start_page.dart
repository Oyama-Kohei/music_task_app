import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:taskmum_flutter/components/pages/start_page1.dart';

import 'start_page2.dart';

void main() {
  runApp(const StartPage());
}

class StartPage extends HookWidget{
  const StartPage({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  int _selectedIndex = 0;

  // ボトムメニューの遷移先画面
  final _pages = [
    const StartPage1(),
    const StartPage2(),
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //return LoginPage();

    return Scaffold(
        body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pages));
  }
}