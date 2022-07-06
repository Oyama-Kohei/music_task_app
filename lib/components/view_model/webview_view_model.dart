import 'package:flutter/material.dart';

class WebviewViewModel extends ChangeNotifier {
  WebviewViewModel({
    required this.youtubeUrl,
  });
  final String youtubeUrl;
}
