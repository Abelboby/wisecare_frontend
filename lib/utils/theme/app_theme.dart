import 'package:flutter/material.dart';

import 'colors/app_color.dart';
import 'theme_manager.dart';
import 'typography/app_typography.dart';

/// Builds ThemeData for light and dark mode using Skin colors.
class AppTheme {
  AppTheme._();

  static ThemeData get light => _buildTheme(false);
  static ThemeData get dark => _buildTheme(true);

  static ThemeData get currentTheme => _buildTheme(Skin.isDark);

  static ThemeData _buildTheme(bool isDark) {
    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: resolveColor(Co.primary, isDark),
        onPrimary: resolveColor(Co.onPrimary, isDark),
        secondary: resolveColor(Co.secondary, isDark),
        onSecondary: resolveColor(Co.onSecondary, isDark),
        error: resolveColor(Co.error, isDark),
        onError: resolveColor(Co.onError, isDark),
        surface: resolveColor(Co.surface, isDark),
        onSurface: resolveColor(Co.onSurface, isDark),
      ),
      scaffoldBackgroundColor: resolveColor(Co.background, isDark),
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
