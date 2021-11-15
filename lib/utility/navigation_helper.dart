import 'package:flutter/cupertino.dart';

class NavigationHelper {
  factory NavigationHelper() {
    return _instance;
  }
  //todo: この書き方何これ static(変わらないよ)
  NavigationHelper._();
  static final NavigationHelper _instance = NavigationHelper._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> push<T>(WidgetBuilder builder, {String routeName = ''}) async{
    return Navigator.of(navigatorKey.currentContext!).push<T>(
      //todo: スワイプバックできるようにする？
      CupertinoPageRoute(
          settings: RouteSettings(name: routeName),
          builder: builder
      )
    );
  }

  Future pushAndRemoveUtil<T>(WidgetBuilder builder) async{
    return Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
      CupertinoPageRoute(
          builder: builder
      ),
      (route) => false
    );

  }
}