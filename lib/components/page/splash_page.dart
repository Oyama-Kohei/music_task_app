import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';
import 'package:askMu/components/view_model/splash_view_model.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with RouteAware, RouteObserverMixin {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Image.asset('images/Splash.png'),
        ),
      ),
    );
  }

  @override
  void didPush() {
    //アプリケーション初期化
    var snapshot = FirebaseAuth.instance.authStateChanges();
    Provider.of<SplashViewModel>(context).initApp(context);
  }
}
