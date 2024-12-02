import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';
import 'app_input_decoration_theme.dart';
import 'app_bottom_navigation_bar_theme.dart';

class DarkTheme {
  static final ThemeData theme = ThemeData(
    primaryColor: Colors.orange,
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,  // No const here
      foregroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: kToolbarHeight,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle( // Make this const for optimization
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: Colors.grey.shade500,
      indicator: BoxDecoration( // No const here
        border: Border(
          bottom: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
    ),
    tooltipTheme: TooltipThemeData(  // No const here
      textStyle: const TextStyle(color: Colors.black),
      decoration: BoxDecoration(color: AppColors.primaryColor),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    bottomNavigationBarTheme: AppBottomNavigationBarTheme.darkBottomNavigationBarTheme(),
    inputDecorationTheme: AppInputDecorationTheme.darkInputDecorationTheme(),
    popupMenuTheme: const PopupMenuThemeData(
      elevation: 4,
      color: Colors.grey,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: AppTextTheme.applyBodyColor(AppTextTheme.textTheme, bodyColor: Colors.white),
  );
}
