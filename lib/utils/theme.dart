import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppColor {
  static const backgroundColor = Colors.white;            // white background
  static const secondary = Color(0xFF386FA4);              // dark blue for fonts/text
  static const iconGray = Color(0xFF59A5D8);                // light blue for icons (subtle)
  static const primary = Color(0xFF133C55);                 // medium blue for sidebar bg
  static const secondaryBg = Color.fromARGB(255, 255, 255, 255); // very light blue for secondary background
  static const barBg = Color.fromARGB(255, 165, 227, 255); // pale blue for bars or highlights
}

class MyAppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: MyAppColor.backgroundColor,
    primaryColor: MyAppColor.primary,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.audiowide(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: MyAppColor.primary,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        color: MyAppColor.secondary,
      ),

      titleSmall: TextStyle(
        fontSize: 16,
        height: 1.4,
        color: MyAppColor.secondary,
      )
    ),
  );
}
