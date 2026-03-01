import 'package:flutter/material.dart';

/// Color token enum. Resolve with Skin.color(Co.xxx).
enum Co {
  primary,
  secondary,
  background,
  surface,
  error,
  onPrimary,
  onSecondary,
  onBackground,
  onSurface,
  onError,
}

/// Light and dark color sets for theme resolution.
class _AppColors {
  const _AppColors._();

  static const Color _primaryLight = Color(0xFF6750A4);
  static const Color _secondaryLight = Color(0xFF625B71);
  static const Color _backgroundLight = Color(0xFFFFFBFE);
  static const Color _surfaceLight = Color(0xFFFFFBFE);
  static const Color _errorLight = Color(0xFFB3261E);
  static const Color _onPrimaryLight = Color(0xFFFFFFFF);
  static const Color _onSecondaryLight = Color(0xFFFFFFFF);
  static const Color _onBackgroundLight = Color(0xFF1C1B1F);
  static const Color _onSurfaceLight = Color(0xFF1C1B1F);
  static const Color _onErrorLight = Color(0xFFFFFFFF);

  static const Color _primaryDark = Color(0xFFD0BCFF);
  static const Color _secondaryDark = Color(0xFFCCC2DC);
  static const Color _backgroundDark = Color(0xFF1C1B1F);
  static const Color _surfaceDark = Color(0xFF1C1B1F);
  static const Color _errorDark = Color(0xFFF2B8B5);
  static const Color _onPrimaryDark = Color(0xFF381E72);
  static const Color _onSecondaryDark = Color(0xFF332D41);
  static const Color _onBackgroundDark = Color(0xFFE6E1E5);
  static const Color _onSurfaceDark = Color(0xFFE6E1E5);
  static const Color _onErrorDark = Color(0xFF601410);

  static Color getLight(Co co) {
    switch (co) {
      case Co.primary:
        return _primaryLight;
      case Co.secondary:
        return _secondaryLight;
      case Co.background:
        return _backgroundLight;
      case Co.surface:
        return _surfaceLight;
      case Co.error:
        return _errorLight;
      case Co.onPrimary:
        return _onPrimaryLight;
      case Co.onSecondary:
        return _onSecondaryLight;
      case Co.onBackground:
        return _onBackgroundLight;
      case Co.onSurface:
        return _onSurfaceLight;
      case Co.onError:
        return _onErrorLight;
    }
  }

  static Color getDark(Co co) {
    switch (co) {
      case Co.primary:
        return _primaryDark;
      case Co.secondary:
        return _secondaryDark;
      case Co.background:
        return _backgroundDark;
      case Co.surface:
        return _surfaceDark;
      case Co.error:
        return _errorDark;
      case Co.onPrimary:
        return _onPrimaryDark;
      case Co.onSecondary:
        return _onSecondaryDark;
      case Co.onBackground:
        return _onBackgroundDark;
      case Co.onSurface:
        return _onSurfaceDark;
      case Co.onError:
        return _onErrorDark;
    }
  }
}

/// Resolves Co to Color. Use after Skin is initialized; isDark is passed by Skin.
Color resolveColor(Co co, bool isDark) {
  return isDark ? _AppColors.getDark(co) : _AppColors.getLight(co);
}
