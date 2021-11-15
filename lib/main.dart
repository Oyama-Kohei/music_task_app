import 'package:taskmum_flutter/app.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const ProviderScope(child: App()));
}