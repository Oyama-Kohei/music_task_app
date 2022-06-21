import 'package:flutter/material.dart';

class PopupTermsViewModel extends ChangeNotifier{
  PopupTermsViewModel({
    required this.agreeFlag,
  });
  final bool agreeFlag;
}
