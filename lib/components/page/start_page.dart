import 'package:flutter/material.dart';
import 'package:taskmum_flutter/components/page/start_page1.dart';
import 'package:taskmum_flutter/components/page/start_page2.dart';

class MainStartPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MainStartPage> {
  late PageController _pageController;
  int _selectedIndex = 0;

  final _pages = [
    const StartPage1(),
    const StartPage2()
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
    return Scaffold(
        body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pages));
  }
}