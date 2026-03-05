part of 'health_tab_screen.dart';

class _HealthTabColors {
  _HealthTabColors._();

  static const Color background = Color(0xFFF8F6F5);

  // Header
  static const Color headerNavy = Color(0xFF1E293B);
  static const Color headerTitle = Color(0xFFFFFFFF);
  static const Color headerButtonBg = Color(0x1AFFFFFF);
  static const Color headerIcon = Color(0xFFFFFFFF);
  static const Color notificationBadge = Color(0xFFFF6933);

  // Low Risk Banner
  static const Color bannerGreen = Color(0xFF10B981);
  static const Color bannerIcon = Color(0xFFFFFFFF);
  static const Color bannerTitle = Color(0xFFFFFFFF);
  static const Color bannerSubtitle = Color(0xFFF0FDF4);
  static const Color bannerOverlay = Color(0x1AFFFFFF);

  // Section headings
  static const Color sectionTitle = Color(0xFF0F172A);

  // Vitals cards
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE7DEDA);
  static const Color cardIconOrangeBg = Color(0x1AFF6933);
  static const Color cardIconOrange = Color(0xFFFF6933);
  static const Color normalBadgeBg = Color(0xFFDCFCE7);
  static const Color normalBadgeText = Color(0xFF166534);
  static const Color valuePrimary = Color(0xFF0F172A);
  static const Color valueUnit = Color(0xFF64748B);
  static const Color labelText = Color(0xFF64748B);

  // Trends chart
  static const Color chartBarFill = Color(0x33FF6933);
  static const Color chartDayLabel = Color(0xFF64748B);
  static const Color chartActiveDayLabel = Color(0xFF0F172A);
  static const Color chartTooltipBg = Color(0xFF1E293B);
  static const Color chartTooltipText = Color(0xFFFFFFFF);
  static const Color filterChipBg = Color(0xFFF8F6F5);
  static const Color filterChipText = Color(0xFF334155);
  static const Color filterChipIcon = Color(0xFF6B7280);

  // Latest readings
  static const Color oxygenIconBg = Color(0xFFEFF6FF);
  static const Color oxygenIcon = Color(0xFF2563EB);
  static const Color tempIconBg = Color(0xFFFFF7ED);
  static const Color tempIcon = Color(0xFFEA580C);
  static const Color weightIconBg = Color(0xFFFAF5FF);
  static const Color weightIcon = Color(0xFF9333EA);
  static const Color statusGreenDot = Color(0xFF22C55E);
  static const Color statusGreenText = Color(0xFF16A34A);
}

class _HealthTabDimens {
  _HealthTabDimens._();

  // Header
  static const double headerPaddingHorizontal = 16.0;
  static const double headerPaddingBottom = 24.0;
  static const double headerButtonSize = 34.0;

  // Content
  static const double contentPaddingHorizontal = 16.0;
  static const double contentPaddingTop = 24.0;
  static const double contentPaddingBottom = 96.0;
  static const double sectionGap = 24.0;
  static const double cardGap = 16.0;
  static const double cardRadius = 24.0;
  static const double cardBorderWidth = 1.0;

  // Banner
  static const double bannerRadius = 24.0;
  static const double bannerPadding = 24.0;

  // Vitals cards
  static const double vitalCardPadding = 20.0;
  static const double vitalIconCircleSize = 39.0;
  static const double vitalIconSize = 23.0;

  // Chart
  static const double chartPaddingHorizontal = 24.0;
  static const double chartPaddingBottom = 24.0;
  static const double chartBarGap = 8.0;
  static const double chartMaxBarHeight = 128.0;
  static const double chartFilterChipHeight = 36.0;
  static const double chartFilterChipRadius = 16.0;

  // Reading items
  static const double readingItemPadding = 16.0;
  static const double readingIconCircleSize = 48.0;
  static const double readingItemGap = 12.0;
  static const double statusDotSize = 10.0;
}
