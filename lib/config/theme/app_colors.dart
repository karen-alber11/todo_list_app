import 'package:flutter/material.dart';

class AppColors {
  // Common Colors
  static const Color primaryColor = Colors.orange;
  static const Color unselectedItemColor = Colors.amber;

  // Light Theme Colors
  static final Color lightBackground = Colors.white;
  static final Color lightFillColor = Colors.amber.shade200;
  static final Color lightEnabledBorderColor = Colors.orange.shade200;
  static final Color lightFocusedBorderColor = primaryColor;

  // Dark Theme Colors
  static final Color darkBackground = Colors.black;
  static final Color darkFillColor = Colors.grey.shade800;
  static final Color darkEnabledBorderColor = Colors.grey.shade600;
  static final Color darkFocusedBorderColor = primaryColor;
}
