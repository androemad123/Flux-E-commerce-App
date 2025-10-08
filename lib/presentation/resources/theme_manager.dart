import 'package:flutter/material.dart';

import 'color_manager.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorManager.primaryLight,
    scaffoldBackgroundColor: ColorManager.whiteLight,
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primaryLight,
      foregroundColor: ColorManager.whiteLight,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: ColorManager.darkGrayLight),
      bodyMedium: TextStyle(color: ColorManager.lightGrayLight),
      bodySmall: TextStyle(color: ColorManager.lighterGrayLight),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.greenLight,
      foregroundColor: ColorManager.whiteLight,
    ),
    colorScheme: ColorScheme.light(
      primary: ColorManager.primaryLight,
      secondary: ColorManager.greenLight,
      error: ColorManager.errorLight,
      surface: ColorManager.whiteLight,
      shadow: ColorManager.lighterGrayLight,
      onPrimary: ColorManager.whiteLight,
      onSecondary: ColorManager.whiteLight,
      onError: ColorManager.whiteLight,
      onSurface: ColorManager.darkGrayLight,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorManager.primaryDark,
    scaffoldBackgroundColor: ColorManager.whiteDark,
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primaryDark,
      foregroundColor: ColorManager.whiteDark,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: ColorManager.darkGrayDark),
      bodyMedium: TextStyle(color: ColorManager.lightGrayDark),
      bodySmall: TextStyle(color: ColorManager.lighterGrayDark),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorManager.greenDark,
      foregroundColor: ColorManager.whiteDark,
    ),
    colorScheme: ColorScheme.dark(
      primary: ColorManager.primaryDark,
      secondary: ColorManager.greenDark,
      error: ColorManager.errorDark,
      surface: ColorManager.whiteDark,
      shadow: ColorManager.lighterGrayDark,
      onPrimary: ColorManager.whiteDark,
      onSecondary: ColorManager.whiteDark,
      onError: ColorManager.whiteDark,
      onSurface: ColorManager.darkGrayDark,
    ),
  );
}
