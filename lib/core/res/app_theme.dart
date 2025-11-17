import 'package:be_board/core/res/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent, // To allow for backdrop blur effect
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.textBlack),
      titleTextStyle: TextStyle(
        color: AppColors.textBlack,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Inter',
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: CircleBorder(),
      elevation: 4, // Corresponds to shadow-lg
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      background: AppColors.backgroundLight,
    ).copyWith(background: AppColors.backgroundLight),
  );
}
