import 'package:flutter/material.dart';
import 'package:fruits_app/core/utils/colors_manager.dart';

ThemeData getApplicationTheme() => ThemeData(
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: "Cairo",
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
);
