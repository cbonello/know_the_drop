import 'package:flutter/material.dart';

abstract final class AppColors {
  static const deepPurple = Color(0xFF0D0B1A);
  static const darkPurple = Color(0xFF1A1530);
  static const mediumPurple = Color(0xFF2D2550);
  static const accentPurple = Color(0xFF6C4AB6);
  static const brightPurple = Color(0xFF8B5CF6);
  static const neonGreen = Color(0xFF4ADE80);
  static const mutedGray = Color(0xFF9CA3AF);
  static const lightGray = Color(0xFFD1D5DB);
  static const white = Color(0xFFFFFFFF);
  static const errorRed = Color(0xFFEF4444);
}

abstract final class AppTheme {
  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.deepPurple,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accentPurple,
        secondary: AppColors.brightPurple,
        surface: AppColors.darkPurple,
        error: AppColors.errorRed,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.white,
      ),
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.lightGray,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: AppColors.lightGray),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.mutedGray),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          color: AppColors.mutedGray,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentPurple,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.mediumPurple,
        selectedColor: AppColors.accentPurple,
        labelStyle: const TextStyle(fontSize: 14, color: AppColors.lightGray),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: const BorderSide(color: AppColors.mediumPurple),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}

/// Background image from Wikimedia Commons.
/// Source: https://commons.wikimedia.org/wiki/File:Bangkok,_Thailand,_Party,_Lights_and_sounds,_Electronic_music.jpg
/// License: CC BY-SA 4.0
abstract final class AppAssets {
  static const backgroundImageAttribution =
      'Bangkok, Thailand, Party, Lights and sounds, Electronic music — Wikimedia Commons / CC BY-SA 4.0';
}
