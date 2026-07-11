import 'package:flutter/material.dart';

abstract class AppColors {
  // ===== Core neutrals =====
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color whiteColor70 = Colors.white70;

  // ===== Brand colors (Decora) =====
  static const Color primary = Color(0xFFD56E49); 
  static const Color primaryDark = Color(0xFFB55D3E);
  static const Color secondary = Color(0xFF8FA68E); 
  static const Color accentGold = Color(0xFFD4A857); 
static const Color warmBeige = Color.fromARGB(255, 227, 180, 147); 

  // ===== Text / surfaces =====
  static const Color charcoal = Color(0xFF2B2622); 
  static const Color lightBackground = Color(0xFFFBF7F2); 
  static const Color tipsBackground = Color(0xFFF3E9DD); 

  // ===== Status colors =====
  static const Color redColor = Colors.red;
  static const Color greenColor = Colors.green;
  static const Color greyColor = Colors.grey;

  // ===== Dark mode variants =====
  static const Color darkBackground = Color(0xFF1E1A17);
  static const Color darkSurface = Color(0xFF2B241F);
}

extension AppColorsExtension on BuildContext {
  bool get _isDark => Theme.of(this).brightness == Brightness.dark;

  Color get backgroundColor =>
      _isDark ? AppColors.darkBackground : AppColors.lightBackground;

  Color get surfaceColor =>
      _isDark ? AppColors.darkSurface : AppColors.whiteColor;

  Color get primaryTextColor =>
      _isDark ? const Color(0xFFEFE6DD) : AppColors.charcoal;

  Color get secondaryTextColor =>
      _isDark ? const Color(0xFFB8AFA6) : const Color(0xFF6B6258);

  Color get primaryColor =>
      _isDark ? const Color(0xFFDC8869) : AppColors.primary;

  Color get secondaryColor =>
      _isDark ? const Color(0xFFA3B8A2) : AppColors.secondary;

  Color get accentColor =>
      _isDark ? const Color(0xFFE0BC78) : AppColors.accentGold;

  Color get tipsBackgroundColor =>
      _isDark ? const Color(0xFF3A2E26) : AppColors.tipsBackground;

  Color get greyColor =>
      _isDark ? Colors.grey[400]! : Colors.grey[600]!;

  Color get borderColor =>
      _isDark ? const Color(0xFF453A32) : const Color(0xFFEAD9C8);
}