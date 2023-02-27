import 'package:filmtrack/src/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';


class TAppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: const MaterialColor(0xFF7884F8, <int, Color>{
      50: Color(0x1A7884F8),
      100: Color(0x337884F8),
      200: Color(0x4D7884F8),
      300: Color(0x667884F8),
      400: Color(0x807884F8),
      500: Color(0xFF7884F8),
      600: Color(0x997884F8),
      700: Color(0xB37884F8),
      800: Color(0xCC7884F8),
      900: Color(0xE67884F8),
    }),
    textTheme: TTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: const MaterialColor(0xFF7884F8, <int, Color>{
      50: Color(0x1A7884F8),
      100: Color(0x337884F8),
      200: Color(0x4D7884F8),
      300: Color(0x667884F8),
      400: Color(0x807884F8),
      500: Color(0xFF7884F8),
      600: Color(0x997884F8),
      700: Color(0xB37884F8),
      800: Color(0xCC7884F8),
      900: Color(0xE67884F8),
    }),
      textTheme: TTextTheme.darkTextTheme,
  );
}