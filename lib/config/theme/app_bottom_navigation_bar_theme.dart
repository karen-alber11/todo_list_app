import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppBottomNavigationBarTheme {
  static BottomNavigationBarThemeData lightBottomNavigationBarTheme() {
    return BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.lightBackground,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.unselectedItemColor,
    );
  }

  static BottomNavigationBarThemeData darkBottomNavigationBarTheme() {
    return BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: AppColors.darkBackground,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.unselectedItemColor,
    );
  }
}
