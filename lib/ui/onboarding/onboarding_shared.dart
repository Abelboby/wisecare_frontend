import 'package:flutter/material.dart';

/// Shared layout and color constants for onboarding (main screen + all slides).
/// Used by onboarding_screen and slides. Prefer [Co] / [Skin.color] for new tokens per NEW_SCREEN_DEV.md.
class OnboardingShared {
  OnboardingShared._();
}

class OnboardingDimens {
  OnboardingDimens._();

  static const double headerPaddingH = 16;
  static const double headerPaddingTop = 16;
  static const double headerPaddingBottom = 8;
  static const double progressSectionPadding = 24;
  static const double progressSectionGap = 12;
  static const double greetingPaddingTop = 16;
  static const double greetingPaddingH = 24;
  static const double greetingGap = 8;
  static const double formPaddingBottom = 128;
  static const double formFieldGap = 24;
  static const double labelInputGap = 8;
  static const double inputBorderRadius = 24;
  static const double inputHeight = 56;
  static const double textareaHeight = 112;
  static const double bottomButtonPadding = 24;
  static const double bottomButtonHeight = 64;
  static const double bottomButtonRadius = 24;
  static const double toggleGap = 16;
  static const double conditionsTagPaddingV = 8;
  static const double conditionsTagPaddingH = 16;
  static const double conditionsTagRadius = 9999;
}

class OnboardingColors {
  OnboardingColors._();

  static const Color background = Color(0xFFF8F9FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFFFF6B35);
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textHint = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);
  static const Color border = Color(0xFFE2E8F0);

  static const Color medicationsBackground = Color(0xFFF8F6F5);
  static const Color medicationsTextDark = Color(0xFF0F172A);
  static const Color medicationsPrimary = Color(0xFFFF6933);
  static const Color medicationsInputBg = Color(0xFFF8FAFC);
  static const Color medicationsDashedBorder = Color(0xFFCBD5E1);
  static const Color medicationsAddButtonBg = Color(0xFFF1F5F9);
  static const Color medicationsTimeChipBg = Color(0xFFF1F5F9);
  static const Color medicationsTimeChipText = Color(0xFF64748B);
  static const Color medicationsHint = Color(0xFF6B7280);
  static const Color medicationsIconMuted = Color(0xFF94A3B8);
  static const Color medicationsAddButtonText = Color(0xFF1E293B);
}

class MedicationsDimens {
  MedicationsDimens._();

  static const double mainPaddingH = 16;
  static const double mainPaddingV = 24;
  static const double mainGap = 24;
  static const double progressCardRadius = 24;
  static const double progressBarHeight = 16;
  static const double sectionTitleSize = 24;
  static const double addNewButtonRadius = 16;
  static const double cardLeftBorderWidth = 8;
  static const double cardRadius = 24;
  static const double cardPadding = 24;
  static const double pillIconSize = 27;
  static const double pillIconBgSize = 59;
  static const double formInputHeight = 64;
  static const double formInputRadius = 24;
  static const double formLabelSize = 18;
  static const double addAnotherButtonHeight = 64;
  static const double footerSpacerHeight = 96;
  static const double timeChipPaddingV = 2;
  static const double timeChipPaddingH = 8;
  static const double timeChipRadius = 8;
}

class InviteSlideDimens {
  InviteSlideDimens._();

  static const double mainPaddingH = 24;
  static const double mainPaddingV = 16;
  static const double mainGap = 24;
  /// Tighter gap so third slide fits in one screen without scroll.
  static const double mainGapTight = 12;
  static const double cardRadius = 24;
  static const double progressBarHeight = 12;
  /// Overlay circle size (Figma: 192px).
  static const double illustrationSize = 192;
  /// Dashed border circle size (Figma: 211.2px); offset from overlay = 9.6.
  static const double dashedCircleSize = 211.2;
  static const double dashedCircleOffset = 9.6;
  /// Central people icon size (Figma: ~85px).
  static const double centerIconSize = 85;
  /// Badge circle diameter (Figma: 44px); use equal width/height for circle.
  static const double badgeSize = 44;
  static const double footerSpacerHeight = 200;
  static const Color progressLabelColor = Color(0xFF334155);
}
