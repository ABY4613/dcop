import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFFF006E); // Electric Pink
  static const Color secondary = Color(0xFF8338EC); // Deep Purple
  static const Color accent = Color(0xFF3A86FF); // Alert Blue
  
  static const Color background = Color(0xFF0D0D12); // Abyss Black
  static const Color surface = Color(0xFF16161E); // Elevated Dark Grey
  static const Color cardPink = Color(0xFF2C121A); // Deep Pinkish Grey for boxes
  
  static const Color error = Color(0xFFFF4D4D);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF94A3B8);
  
  static const Color sosRed = Color(0xFFFF003A); // Aggressive Alert Red
  static const Color successGreen = Color(0xFF00FF88);
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF006E), Color(0xFF8338EC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF16161E), Color(0xFF0D0D12)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
