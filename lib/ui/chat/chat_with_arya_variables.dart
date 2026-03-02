part of 'chat_with_arya_screen.dart';

/// Chat screen layout and color constants (from Figma).
class _ChatDimens {
  _ChatDimens._();

  static const double statusBarHeight = 48;
  static const double topBarHeight = 80;
  static const double avatarSize = 48;
  static const double messageBubbleRadius = 16;
  static const double chipBorderRadius = 9999;
  static const double inputAreaPadding = 16;
  static const double inputAreaBottomPadding = 32;
  static const double horizontalPadding = 16;
  static const double homeIndicatorWidth = 128;
  static const double homeIndicatorHeight = 4;
  static const double homeIndicatorBottom = 4;
  static const double messageGap = 12;
  static const double senderNameGap = 4;
  static const double sendButtonSize = 56;
  static const double addButtonSize = 49;
  static const double textInputBorderRadius = 24;
}

/// Chat screen colors (from Figma).
class _ChatColors {
  _ChatColors._();

  static const Color mainBackground = Color(0xFFF8F6F5);
  // static const Color statusBarBackground = Color(0xFF1A2E40);
  static const Color topBarBackground = Color(0xFF1A2E40);
  static const Color topBarText = Color(0xFFFFFFFF);
  static const Color onlineIndicator = Color(0xFF4ADE80);
  static const Color dateDividerBg = Color(0xFFE7E5E4);
  static const Color dateDividerText = Color(0xFF57534E);
  static const Color senderNameText = Color(0xFF78716C);
  static const Color aryaBubbleBg = Color(0xFFFFFFFF);
  static const Color aryaBubbleBorder = Color(0xFFF5F5F4);
  static const Color aryaBubbleText = Color(0xFF0F172A);
  static const Color userBubbleBg = Color(0xFFFF6933);
  static const Color userBubbleText = Color(0xFFFFFFFF);
  static const Color chipPrimaryText = Color(0xFFFF6933);
  static const Color inputAreaBg = Color(0xFFFFFFFF);
  static const Color inputAreaBorder = Color(0xFFE7E5E4);
  static const Color textInputBg = Color(0xFFF5F5F4);
  static const Color textInputPlaceholder = Color(0xFFA8A29E);
  static const Color iconMuted = Color(0xFFA8A29E);
  static const Color sendButtonBg = Color(0xFFFF6933);
  static const Color homeIndicator = Color(0x80D6D3D1);
}
