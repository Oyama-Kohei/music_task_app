import 'package:flutter/material.dart';

///
/// アプリ内独自カラー拡張クラス
///
class CommonColors {
  static const int _primaryValue = 0xFF58B0D7;
  static const Color primaryColor = Color(_primaryValue);
  static const MaterialColor customSwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFF626D71),
      100: Color(0xFFDCDCDC),
      200: Color(0xFF537072),
      300: Color(0xFF8E9B97),
      400: Color(0xFFDCDCDC),
      500: primaryColor,
      600: Color(0xFF50A9D3),
      700: Color(0xFF47A0CD),
      800: Color(0xFF3D97C7),
      900: Color(0xFF2D87BE),
    },
  );
}
