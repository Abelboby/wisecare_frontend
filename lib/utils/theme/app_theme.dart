import 'package:flutter/material.dart';

import 'colors/app_color.dart';
import 'theme_manager.dart';
import 'typography/app_typography.dart';

/// Builds ThemeData from Skin and Co. Use commonThemeData in MaterialApp.
class AppTheme {
  AppTheme._();

  static ThemeData get commonThemeData {
    return ThemeData(
      useMaterial3: true,
      brightness:
          Skin.isDarkTheme.value ? Brightness.dark : Brightness.light,
      primaryColor: Skin.color(Co.primary),
      colorScheme: ColorScheme(
        brightness:
            Skin.isDarkTheme.value ? Brightness.dark : Brightness.light,
        primary: Skin.color(Co.primary),
        onPrimary: Skin.color(Co.onPrimary),
        secondary: Skin.color(Co.secondary),
        onSecondary: Skin.color(Co.onSecondary),
        error: Skin.color(Co.error),
        onError: Skin.color(Co.onError),
        surface: Skin.color(Co.surface),
        onSurface: Skin.color(Co.onSurface),
      ),
      scaffoldBackgroundColor: Skin.color(Co.background),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge,
        displayMedium: AppTypography.displayMedium,
        headlineMedium: AppTypography.headlineMedium,
        titleLarge: AppTypography.titleLarge,
        bodyLarge: AppTypography.bodyLarge,
        bodyMedium: AppTypography.bodyMedium,
        labelLarge: AppTypography.labelLarge,
      ),
    );
  }
}
