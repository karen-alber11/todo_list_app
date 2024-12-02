import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  // Define the necessary text styles explicitly for Material 3
  static final TextTheme textTheme = TextTheme(
    // Use the new equivalents for headline6, bodyText1, etc.
    displayLarge: GoogleFonts.dekko(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white, // Default color, can be overridden
    ),
    bodyLarge: GoogleFonts.dekko(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white, // Default color, can be overridden
    ),
    bodyMedium: GoogleFonts.dekko(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.white, // Default color, can be overridden
    ),
    titleLarge: GoogleFonts.dekko(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white, // Default color, can be overridden
    ),
    // Adding other default text styles like caption or button if needed
    labelSmall: GoogleFonts.dekko(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.white, // Default color, can be overridden
    ),
    labelLarge: GoogleFonts.dekko(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white, // Default color, can be overridden
    ),
  );

  // Light and Dark Body Color Adjustments
  static TextTheme applyBodyColor(TextTheme theme, {required Color bodyColor}) {
    return theme.apply(bodyColor: bodyColor);
  }
}
