import 'package:flutter/material.dart';

/// One semantic color token with three concrete colors (light, grayscale, dark).
class AppColor {
  const AppColor({
    required this.light,
    required this.dark,
    required this.grayscale,
  });

  final Color light;
  final Color dark;
  final Color grayscale;
}

/// Semantic color tokens. Use with Skin.color(Co.xxx).
class Co {
  Co._();

  static const AppColor primary = AppColor(
    light: Color(0xFFFF6933),
    dark: Color(0xFFFF6933),
    grayscale: Color(0xFF424242),
  );

  static const AppColor secondary = AppColor(
    light: Color(0xFF625B71),
    dark: Color(0xFFCCC2DC),
    grayscale: Color(0xFF616161),
  );

  static const AppColor background = AppColor(
    light: Color(0xFFFFFBFE),
    dark: Color(0xFF1C1B1F),
    grayscale: Color(0xFFFAFAFA),
  );

  static const AppColor surface = AppColor(
    light: Color(0xFFFFFBFE),
    dark: Color(0xFF1C1B1F),
    grayscale: Color(0xFFFAFAFA),
  );

  static const AppColor error = AppColor(
    light: Color(0xFFB3261E),
    dark: Color(0xFFF2B8B5),
    grayscale: Color(0xFF757575),
  );

  static const AppColor onPrimary = AppColor(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFFFFFFFF),
    grayscale: Color(0xFFFFFFFF),
  );

  static const AppColor onSecondary = AppColor(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF332D41),
    grayscale: Color(0xFFFFFFFF),
  );

  static const AppColor onBackground = AppColor(
    light: Color(0xFF1C1B1F),
    dark: Color(0xFFE6E1E5),
    grayscale: Color(0xFF1E1E1E),
  );

  static const AppColor onSurface = AppColor(
    light: Color(0xFF1C1B1F),
    dark: Color(0xFFE6E1E5),
    grayscale: Color(0xFF1E1E1E),
  );

  static const AppColor onError = AppColor(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF601410),
    grayscale: Color(0xFFFFFFFF),
  );

  static const AppColor navyBrand = AppColor(
    light: Color(0xFF1F234D),
    dark: Color(0xFF1F234D),
    grayscale: Color(0xFF37474F),
  );

  static const AppColor gradientTop = AppColor(
    light: Color(0xFF1A1A2E),
    dark: Color(0xFF1A1A2E),
    grayscale: Color(0xFF1A1A2E),
  );

  static const AppColor gradientBottom = AppColor(
    light: Color(0xFF2D3561),
    dark: Color(0xFF2D3561),
    grayscale: Color(0xFF2D3561),
  );

  static const AppColor accentBlur = AppColor(
    light: Color(0xFF60A5FA),
    dark: Color(0xFF60A5FA),
    grayscale: Color(0xFF90A4AE),
  );
}
