import 'package:flutter/material.dart';
import 'package:startup_saathi/src/components/constants/theme/app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.whiteColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
      );
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.focusedBorderColor),
      errorBorder: _border(AppPallete.errorColor),
      fillColor: AppPallete.textBoxFillColor,
      filled: true,
      hintStyle: const TextStyle(
        color: AppPallete.greyColor,
        fontSize: 16,
      ),
    ),
  );
}
