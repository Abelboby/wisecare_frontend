part of 'health_tab_screen.dart';

/// Figma design tokens for Health tab (WiseCare Analytics).
class _HealthTabColors {
  _HealthTabColors._();

  static const Color background = Color(0xFFF8F9FF);

  // Header
  static const Color headerBg = Color(0xFFFFFFFF);
  static const Color headerBorder = Color(0xFFE2E8F0);
  static const Color headerTitle = Color(0xFF1E293B);
  static const Color primaryOrange = Color(0xFFFF6933);
  static const Color headerIconMuted = Color(0xFF64748B);
  static const Color notificationBadge = Color(0xFFFF6933);

  // Cards
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE2E8F0);
  static const Color cardShadow = Color(0x0D000000);

  // Time range filter
  static const Color filterChipSelectedBg = Color(0xFFFF6933);
  static const Color filterChipSelectedText = Color(0xFFFFFFFF);
  static const Color filterChipUnselectedText = Color(0xFF475569);
  static const Color dateRangeText = Color(0xFF475569);

  // Stat cards
  static const Color labelMuted = Color(0xFF64748B);
  static const Color valuePrimary = Color(0xFF1E293B);
  static const Color valueUnitMuted = Color(0xFF94A3B8);
  static const Color trendRed = Color(0xFFEF4444);
  static const Color trendMuted = Color(0xFF64748B);
  static const Color iconHeart = Color(0xFFFF6933);
  static const Color iconBp = Color(0xFF3B82F6);
  static const Color iconShield = Color(0xFF94A3B8);

  // Charts
  static const Color chartHigh = Color(0xFFFF6933);
  static const Color chartLow = Color(0xFF64748B);
  static const Color chartPillBg = Color(0x1AFF6933);
  static const Color chartPillMuted = Color(0xFFF1F5F9);
  static const Color chartAxisLabel = Color(0xFF94A3B8);
  static const Color chartLineSystolic = Color(0xFF3B82F6);
  static const Color chartLineDiastolic = Color(0xFFCBD5E1);

  // Risk distribution
  static const Color riskNormal = Color(0xFF22C55E);
  static const Color riskMild = Color(0xFFFB923C);
  static const Color riskHigh = Color(0xFFEF4444);
  static const Color riskBarTrack = Color(0xFFF1F5F9);
  static const Color riskLabel = Color(0xFF64748B);
  static const Color riskValue = Color(0xFF1E293B);
  static const Color riskFooter = Color(0xFF64748B);
  static const Color riskDivider = Color(0xFFF1F5F9);

  // Table
  static const Color statusNormalBg = Color(0xFFFFEDD5);
  static const Color statusNormalText = Color(0xFFC2410C);
  static const Color statusHealthyBg = Color(0xFFDCFCE7);
  static const Color statusHealthyText = Color(0xFF15803D);
  static const Color statusFeverBg = Color(0xFFFEE2E2);
  static const Color statusFeverText = Color(0xFFB91C1C);
}

class _HealthTabDimens {
  _HealthTabDimens._();

  static const double contentPadding = 16.0;
  static const double contentBottom = 46.0;
  static const double sectionGap = 24.0;
  static const double cardRadius = 24.0;

  static const double headerHeight = 120.0;
  static const double headerPadding = 16.0;

  static const double filterChipPaddingH = 24.0;
  static const double filterChipPaddingV = 8.0;
  static const double filterChipRadius = 16.0;

  static const double statCardPadding = 20.0;
  static const double statCardGap = 8.0;
  static const double statValueFontSize = 30.0;
  static const double statUnitFontSize = 14.0;
  static const double statTrendFontSize = 12.0;
  static const double statIconSize = 20.0;

  static const double chartPadding = 24.0;
  static const double chartLegendPillPaddingH = 8.0;
  static const double chartLegendPillPaddingV = 4.0;
  static const double chartLegendPillRadius = 8.0;
  static const double chartLegendFontSize = 10.0;
  static const double chartHeight = 240.0;
  static const double chartAxisFontSize = 10.0;

  static const double riskBarHeight = 12.0;
  static const double riskBarRadius = 9999.0;
  static const double riskRowGap = 16.0;
  static const double riskLabelFontSize = 12.0;

  static const double tableStatusChipPaddingH = 8.0;
  static const double tableStatusChipPaddingV = 4.0;
  static const double tableStatusChipRadius = 9999.0;
}

/// Time range options for the filter.
enum _HealthTimeRange {
  sevenDays,
  thirtyDays,
  threeMonths,
}
