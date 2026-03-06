part of 'meds_tab_screen.dart';

class _MedsColors {
  _MedsColors._();

  static const Color background = Color(0xFFFDF8F6);
  static const Color headerNavy = Color(0xFF1E293B);
  static const Color headerTitle = Color(0xFFFFFFFF);
  static const Color greetingText = Color(0xFF64748B);
  static const Color scheduleTitleText = Color(0xFF1E293B);
  static const Color doseSectionTitle = Color(0xFF1E293B);
  static const Color doseTimeText = Color(0xFF64748B);
  static const Color morningSunIcon = Color(0xFFFF6933);
  static const Color afternoonSunIcon = Color(0xFFFB923C);
  static const Color eveningIcon = Color(0xFFEA580C);
  static const Color nightIcon = Color(0xFF6366F1);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color afterBreakfastBadgeBg = Color(0xE6FFFFFF);
  static const Color afterBreakfastBadgeText = Color(0xFF1E293B);
  static const Color drugNameText = Color(0xFF1E293B);
  static const Color dosageBadgeBg = Color(0xFFFFEDD5);
  static const Color dosageBadgeText = Color(0xFFE5501A);
  static const Color instructionText = Color(0xFF64748B);
  static const Color warningBg = Color(0xFFFEFCE8);
  static const Color warningBorder = Color(0xFFB45309);
  static const Color warningIcon = Color(0xFFB45309);
  static const Color warningText = Color(0xFFB45309);
  static const Color markTakenBorder = Color(0xFFFF6933);
  static const Color markTakenIcon = Color(0xFFFF6933);
  static const Color markTakenText = Color(0xFFFF6933);
  static const Color aspirinNameText = Color(0xFF1E293B);
  static const Color aspirinSubText = Color(0xFF64748B);
  static const Color aspirinImageBg = Color(0xFFF1F5F9);
  static const Color aspirinCheckBorder = Color(0xFFCBD5E1);
  static const Color aspirinCheckIcon = Color(0xFFCBD5E1);
  static const Color takenBadgeBg = Color(0xFFDCFCE7);
  static const Color takenBadgeText = Color(0xFF16A34A);
  static const Color takenBadgeIcon = Color(0xFF16A34A);
  static const Color refillIconBg = Color(0xFFFFEDD5);
  static const Color refillIcon = Color(0xFFFF6933);
  static const Color refillTitleText = Color(0xFF1E293B);
  static const Color refillSubText = Color(0xFF64748B);
  static const Color refillArrow = Color(0xFFFF6933);
}

class _MedsDimens {
  _MedsDimens._();

  static const double headerPaddingHorizontal = 16;
  static const double headerPaddingBottom = 24;
  static const double cardRadius = 32;
  static const double imageHeight = 192;
  static const double contentPaddingH = 16;
  static const double contentPaddingTop = 16;
  static const double contentPaddingBottom = 96;
  static const double sectionGap = 24;
  static const double cardGap = 16;
  static const double doseSectionIconSize = 25.67;
  static const double aspirinImageSize = 80;
  static const double aspirinImageRadius = 24;
  static const double aspirinCheckSize = 48;
  static const double refillIconCircleSize = 56;
  static const double errorStatePadding = 24;
  static const double refillSectionTopPadding = 8;
}

class _MedsTextSizes {
  _MedsTextSizes._();

  static const double errorMessage = 16;
}

typedef _RefillOnConfirmCallback = Future<void> Function(List<String> medicationIds);
