import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Colors.black;
  static const Color primaryRed = Colors.white;
  static const Color textWhite = Colors.white;
  static const Color textGrey = Color(0xFF8C8C8C);
  static const Color cardDark = Color(0xFF141414);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primaryRed,
      colorScheme: const ColorScheme.dark(
        primary: primaryRed,
        surface: cardDark,
        onSurface: textWhite,
      ),
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            displayLarge: GoogleFonts.outfit(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: textWhite,
            ),
            displayMedium: GoogleFonts.outfit(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: textWhite,
            ),
            bodyLarge: GoogleFonts.outfit(fontSize: 18, color: textWhite),
            bodyMedium: GoogleFonts.outfit(fontSize: 14, color: textGrey),
          ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          foregroundColor: textWhite,
          textStyle: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    );
  }
}
