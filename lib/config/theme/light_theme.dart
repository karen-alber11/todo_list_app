import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_theme.dart';
import 'app_input_decoration_theme.dart';
import 'app_bottom_navigation_bar_theme.dart';

class LightTheme {
  static final ThemeData theme = ThemeData(
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: kToolbarHeight,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.unselectedItemColor,
      indicator: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
    ),
    tooltipTheme: const TooltipThemeData(
      textStyle: TextStyle(color: Colors.white),
      decoration: BoxDecoration(color: AppColors.primaryColor),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    bottomNavigationBarTheme: AppBottomNavigationBarTheme.lightBottomNavigationBarTheme(),
    inputDecorationTheme: AppInputDecorationTheme.lightInputDecorationTheme(),
    popupMenuTheme: const PopupMenuThemeData(
      elevation: 4,
      color: Colors.white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: AppTextTheme.applyBodyColor(AppTextTheme.textTheme, bodyColor: Colors.black),
  );
}
