import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppInputDecorationTheme {
  static InputDecorationTheme lightInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightFillColor,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightEnabledBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightFocusedBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  static InputDecorationTheme darkInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkFillColor,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkEnabledBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkFocusedBorderColor),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
