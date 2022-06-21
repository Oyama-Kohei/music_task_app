import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationHelper {
  factory NavigationHelper() {
    return _instance;
  }
  NavigationHelper._internal();
  static final NavigationHelper _instance = NavigationHelper._internal();

  static final navigatorKey = GlobalKey<NavigatorState>();

  Future<void> push<T extends ChangeNotifier>({
    required BuildContext context,
    required WidgetBuilder pageBuilder,
    required ValueBuilder<T> viewModelBuilder,
  }) async{
    Navigator.of(context).push(MaterialPageRoute<Widget>(builder: (context){
      return ChangeNotifierProvider<T>(
        create: viewModelBuilder,
        child: pageBuilder(context),
      );
    }),
    );
  }

  Future<void> pushAndRemoveUntilRoot<T extends ChangeNotifier>({
    BuildContext? context,
    required WidgetBuilder pageBuilder,
    required ValueBuilder<T> viewModelBuilder,
  }) async {
    context ??= navigatorKey.currentState!.overlay!.context;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<Widget>(
            builder: (context) {
              return ChangeNotifierProvider<T>(
                create: viewModelBuilder,
                child: pageBuilder(context),
              );
            }
        ),
        (_) => false,
    );
  }

  Future<void> pushNonMaterialRoute<T extends ChangeNotifier>({
    required BuildContext context,
    required WidgetBuilder pageBuilder,
    required ValueBuilder<T> viewModelBuilder,
  }) async {
    Navigator.push(
      context,
      PageRouteBuilder<Widget>(
        opaque: false,
        pageBuilder: (context, animation1, animation2){
          return ChangeNotifierProvider<T>(
            create: viewModelBuilder,
            child: pageBuilder(context),
          );
        },
      ),
    );
  }
}

typedef ValueBuilder<T> = T Function(BuildContext context);