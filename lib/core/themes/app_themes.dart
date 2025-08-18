import 'package:flutter/material.dart';
import 'package:project_iti_2025/core/constants/app_colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryButtonColor),
    appBarTheme: const AppBarTheme(
      color: AppColors.white,
      elevation: 0,
      centerTitle: true,
      shadowColor: AppColors.grey,
      iconTheme: IconThemeData(color: AppColors.black),
      titleTextStyle: TextStyle(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: AppColors.white,
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: AppColors.darkGrey),
      bodyMedium: TextStyle(color: AppColors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryButtonColor,
        foregroundColor: AppColors.white,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primaryButtonColor,
        foregroundColor: AppColors.white,
        textStyle: const TextStyle(color: AppColors.white),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.primaryButtonColor,
      unselectedItemColor: AppColors.darkGrey,
    ),
    brightness: Brightness.light,
    useMaterial3: true,
  );
}