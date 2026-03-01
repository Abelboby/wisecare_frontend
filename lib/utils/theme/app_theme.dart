import 'package:flutter/material.dart';

import 'package:wisecare_frontend/utils/theme/colors/app_color.dart';
import 'package:wisecare_frontend/utils/theme/theme_manager.dart';
import 'package:wisecare_frontend/utils/theme/typography/app_typography.dart';

/// Builds ThemeData from Skin and Co. Use commonThemeData in MaterialApp.
/// Use [noScrollbarBehavior] in MaterialApp.scrollBehavior to hide scrollbars
/// app-wide (e.g. for web) on SingleChildScrollView, ListView, GridView, etc.
class AppTheme {
  AppTheme._();

  /// Scroll behavior that hides scrollbars globally. Use with MaterialApp.scrollBehavior.
  static ScrollBehavior get noScrollbarBehavior =>
      ScrollBehavior().copyWith(scrollbars: false);

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
      scrollbarTheme: ScrollbarThemeData(
        thumbVisibility: WidgetStateProperty.resolveWith((_) => false),
        trackVisibility: WidgetStateProperty.resolveWith((_) => false),
      ),
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
