part of 'login_screen.dart';

/// Login screen layout constants (from Figma). Colors use [Co] in app_color.dart.
class _LoginDimens {
  _LoginDimens._();

  static const double headerBottomRadius = 40;
  static const double cardRadius = 32;
  static const double cardOverlap = 32;
  static const double buttonRadius = 24;
  static const double inputRadius = 24;
  static const double logoSize = 80;
  static const double cardPadding = 24;
  static const double cardGap = 24;
}

/// Demo credentials for quick login (dev/demo only). Remove in production.
class _LoginDemoCredentials {
  _LoginDemoCredentials._();

  static const String email = 'raghav@example.com';
  static const String password = 'test1234';

  /// Delay per character for demo typewriter animation (milliseconds).
  static const int typingDelayMs = 35;
}
