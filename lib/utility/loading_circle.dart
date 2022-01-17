import 'package:flutter/material.dart';

///ローディング画面表示
void showLoadingCircle(BuildContext context){
  showDialog<dynamic>(
    barrierDismissible: false,
    barrierColor: Colors.white.withOpacity(0.5),
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  );
}

///ローディング画面表示を終了
void dismissLoadingCircle(BuildContext context){
  Navigator.of(context).pop();
}
