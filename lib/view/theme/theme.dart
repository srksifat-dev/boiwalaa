import 'package:flutter/material.dart';

import 'colors.dart';

class Themes {
  final lightTheme = ThemeData.light().copyWith(
    primaryColor: AppColors.green,
    backgroundColor: AppColors.backgroundWhite,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      elevation: 0,
    ),
    dialogBackgroundColor: AppColors.green,
    snackBarTheme: const SnackBarThemeData(
      actionTextColor: AppColors.deepAmber,
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: AppColors.deepAmber),
  );
  final darkTheme = ThemeData.dark().copyWith(
      primaryColor: AppColors.deepAmber,
      backgroundColor: AppColors.backgroundBlack,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        elevation: 0,
      ));
}
