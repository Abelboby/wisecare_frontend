part of 'home_screen.dart';

/// Home screen layout and color constants (from Figma).
class _HomeDimens {
  _HomeDimens._();

  static const double headerBottomRadius = 40;
  static const double headerPaddingTop = 48;
  static const double headerPaddingHorizontal = 24;
  static const double headerPaddingBottom = 80;
  static const double headerGap = 24;
  static const double floatingCardRadius = 24;
  /// How far the card extends up into the header (visual overlap).
  static const double floatingCardHeaderOverlap = 48;
  /// Approx card height; used to position overlap. Adjust if card content changes.
  static const double floatingCardApproxHeight = 117;
  static const double contentPaddingTop = 32;
  static const double contentPaddingHorizontal = 24;
  static const double contentPaddingBottom = 24;
  static const double contentGap = 24;
  static const double quickActionCardRadius = 24;
  static const double quickActionCardPadding = 20;
  static const double quickActionIconSize = 56;
  static const double quickActionIconGap = 11.25;
  static const double bannerRadius = 16;
  static const double bannerPadding = 16;
  static const double avatarSize = 48;
  static const double avatarCircleSize = 56;
  static const double statusBadgeSize = 12;
  static const double notificationBadgeSize = 10;
  static const double micButtonSize = 40;

  // Bottom navigation bar (from Figma)
  static const double navBarHeight = 88;
  static const double navBarPaddingTop = 8;
  static const double navBarPaddingHorizontal = 24;
  static const double navBarPaddingBottom = 16;
  static const double navBarIconLabelGap = 4;
  static const double navBarItemWidth = 64;
  static const double navBarIconSizeInactive = 18.67;
  static const double navBarIconSizeActive = 21;
  static const double navBarSelectedPillWidth = 56;
  static const double navBarSelectedPillHeight = 32;
}

/// Home screen colors (from Figma). Not theme-aware; use for this screen only.
class _HomeColors {
  _HomeColors._();

  static const Color headerNavy = Color(0xFF1A237E);
  static const Color background = Color(0xFFF8F6F5);
  static const Color vitalsCardBg = Color(0xFFFFFFFF);
  static const Color vitalsDivider = Color(0xFFF1F5F9);
  static const Color heartIcon = Color(0xFFEF4444);
  static const Color bpIcon = Color(0xFF3B82F6);
  static const Color riskIcon = Color(0xFF22C55E);
  static const Color vitalsValue = Color(0xFF0F172A);
  static const Color vitalsLabel = Color(0xFF64748B);
  static const Color quickActionsTitle = Color(0xFF1E293B);
  static const Color sosBg = Color(0xFFFEF2F2);
  static const Color sosBorder = Color(0xFFFEE2E2);
  static const Color sosIconBg = Color(0xFFFEE2E2);
  static const Color sosIcon = Color(0xFFDC2626);
  static const Color sosText = Color(0xFF7F1D1D);
  static const Color medicineBg = Color(0xFFEFF6FF);
  static const Color medicineBorder = Color(0xFFDBEAFE);
  static const Color medicineIconBg = Color(0xFFDBEAFE);
  static const Color medicineIcon = Color(0xFF2563EB);
  static const Color medicineText = Color(0xFF1E3A8A);
  static const Color chatBg = Color(0xFFFAF5FF);
  static const Color chatBorder = Color(0xFFF3E8FF);
  static const Color chatIconBg = Color(0xFFF3E8FF);
  static const Color chatIcon = Color(0xFF9333EA);
  static const Color chatText = Color(0xFF581C87);
  static const Color vitalsCardBgGreen = Color(0xFFF0FDF4);
  static const Color vitalsCardBorderGreen = Color(0xFFDCFCE7);
  static const Color vitalsCardIconBgGreen = Color(0xFFDCFCE7);
  static const Color vitalsCardIconGreen = Color(0xFF16A34A);
  static const Color vitalsCardTextGreen = Color(0xFF14532D);
  static const Color bannerGradientStart = Color(0xFF7C3AED);
  static const Color bannerGradientEnd = Color(0xFF4F46E5);
  static const Color bannerSubtitle = Color(0xCCFFFFFF);
  static const Color bannerMicBg = Color(0x33FFFFFF);
  static const Color statusGreen = Color(0xFF22C55E);
  static const Color statusGreenBanner = Color(0xFF4ADE80);
  static const Color notificationBadge = Color(0xFFFF6933);
  static const Color headerBorderWhite = Color(0x33FFFFFF);

  // Bottom navigation bar
  static const Color navBarBackground = Color(0xFFFFFFFF);
  static const Color navBarBorderTop = Color(0xFFE2E8F0);
  static const Color navBarIconInactive = Color(0xFF94A3B8);
  static const Color navBarLabelInactive = Color(0xFF64748B);
  static const Color navBarIconActive = Color(0xFFFF6933);
  static const Color navBarLabelActive = Color(0xFFFF6933);
  static const Color navBarSelectedPillBg = Color(0x1AFF6933);
}
