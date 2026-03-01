import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../storage_keys.dart';
import 'colors/app_color.dart';
import 'package:wisecare_frontend/enums/app_enums.dart';

/// Theme state via ValueNotifier. Persists mode using StorageKeys.themeMode.
/// Not a Provider — use ValueListenableBuilder or listen to themeModeNotifier.
class Skin {
  Skin._();

  static final ValueNotifier<AppThemeMode> themeModeNotifier =
      ValueNotifier<AppThemeMode>(AppThemeMode.light);

  static bool get isDark {
    switch (themeModeNotifier.value) {
      case AppThemeMode.dark:
        return true;
      case AppThemeMode.light:
        return false;
      case AppThemeMode.system:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark;
    }
  }

  /// Resolves Co to Color for the current theme.
  static Color color(Co co) => resolveColor(co, isDark);

  static Future<void> loadSavedTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final index = prefs.getInt(StorageKeys.themeMode);
      if (index != null && index >= 0 && index < AppThemeMode.values.length) {
        themeModeNotifier.value = AppThemeMode.values[index];
      }
    } catch (_) {
      // Keep default light
    }
  }

  static Future<void> setThemeMode(AppThemeMode mode) async {
    themeModeNotifier.value = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(
          StorageKeys.themeMode, AppThemeMode.values.indexOf(mode));
    } catch (_) {}
  }
}
