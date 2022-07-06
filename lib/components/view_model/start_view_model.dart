import 'package:flutter/material.dart';

class StartViewModel extends ChangeNotifier {
  final PageController startPageController =
      PageController(viewportFraction: 0.95);

  final startPageNotifier = ValueNotifier<int>(0);

  void onStartPageChanged(int index) {
    startPageNotifier.value = index;
    notifyListeners();
  }
}
