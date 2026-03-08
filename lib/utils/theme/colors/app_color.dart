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

  /// Muted text on dark header (e.g. "Last 7 Days").
  static const AppColor onPrimaryMuted = AppColor(
    light: Color(0xB3FFFFFF),
    dark: Color(0xB3FFFFFF),
    grayscale: Color(0xB3FFFFFF),
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

  /// Login / auth: warm body background.
  static const AppColor warmBackground = AppColor(
    light: Color(0xFFF8F6F5),
    dark: Color(0xFF1C1B1F),
    grayscale: Color(0xFFFAFAFA),
  );

  /// Login header (navy).
  static const AppColor loginHeader = AppColor(
    light: Color(0xFF0E1C36),
    dark: Color(0xFF0E1C36),
    grayscale: Color(0xFF37474F),
  );

  /// Subtitle text on login header.
  static const AppColor headerSubtitle = AppColor(
    light: Color(0xFFDBEAFE),
    dark: Color(0xFFDBEAFE),
    grayscale: Color(0xFF90A4AE),
  );

  /// Card surface (e.g. login card).
  static const AppColor cardSurface = AppColor(
    light: Color(0xFFFFFFFF),
    dark: Color(0xFF2D2D2D),
    grayscale: Color(0xFFFAFAFA),
  );

  /// Muted / secondary text.
  static const AppColor textMuted = AppColor(
    light: Color(0xFF63504B),
    dark: Color(0xFFB0A8A4),
    grayscale: Color(0xFF757575),
  );

  /// Outline / border.
  static const AppColor outline = AppColor(
    light: Color(0xFFE5E7EB),
    dark: Color(0xFF49454F),
    grayscale: Color(0xFFE0E0E0),
  );

  /// App icon shield / logo container (matches icon’s dark blue shield).
  static const AppColor iconShield = AppColor(
    light: Color(0xFF354670),
    dark: Color(0xFF354670),
    grayscale: Color(0xFF4A5568),
  );

  /// Screen body background (e.g. health history).
  static const AppColor contentBackground = AppColor(
    light: Color(0xFFF8F9FF),
    dark: Color(0xFF1C1B1F),
    grayscale: Color(0xFFFAFAFA),
  );

  /// Subtle border (cards, badges).
  static const AppColor borderSubtle = AppColor(
    light: Color(0xFFF1F5F9),
    dark: Color(0xFF49454F),
    grayscale: Color(0xFFE0E0E0),
  );

  /// Secondary label text.
  static const AppColor textSecondary = AppColor(
    light: Color(0xFF64748B),
    dark: Color(0xFF94A3B8),
    grayscale: Color(0xFF757575),
  );

  /// Tertiary / source text.
  static const AppColor textTertiary = AppColor(
    light: Color(0xFF94A3B8),
    dark: Color(0xFF64748B),
    grayscale: Color(0xFF9E9E9E),
  );

  /// Dark header button overlay (e.g. back/calendar on navy).
  static const AppColor headerButtonOverlay = AppColor(
    light: Color(0x1AFFFFFF),
    dark: Color(0x1AFFFFFF),
    grayscale: Color(0x1AFFFFFF),
  );

  /// Primary color tint (e.g. icon background).
  static const AppColor primaryTint = AppColor(
    light: Color(0x1AFF6933),
    dark: Color(0x33FF6933),
    grayscale: Color(0x1A424242),
  );

  /// Alert / critical (e.g. pattern ALERT).
  static const AppColor alert = AppColor(
    light: Color(0xFFEF4444),
    dark: Color(0xFFF87171),
    grayscale: Color(0xFF757575),
  );

  /// Warning (e.g. pattern WARNING).
  static const AppColor warning = AppColor(
    light: Color(0xFFFB923C),
    dark: Color(0xFFFDBA74),
    grayscale: Color(0xFF9E9E9E),
  );

  /// Timeline dot / divider (secondary).
  static const AppColor timelineMuted = AppColor(
    light: Color(0xFFE2E8F0),
    dark: Color(0xFF49454F),
    grayscale: Color(0xFFE0E0E0),
  );
}
