import 'package:filmtrack/src/utils/theme/widget_themes/color_swatch_theme.dart';
import 'package:filmtrack/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:filmtrack/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:filmtrack/src/utils/theme/widget_themes/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primarySwatch: TColorSwatchTheme.lightColorTheme,
      textTheme: TTextTheme.lightTextTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: TColorSwatchTheme.darkColorTheme,
      textTheme: TTextTheme.darkTextTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
      elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme);
}
