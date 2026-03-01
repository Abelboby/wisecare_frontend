/// Persistent storage key constants (SharedPreferences, Hive boxes).
/// No magic strings in the rest of the app.
class StorageKeys {
  StorageKeys._();

  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String themeMode = 'theme_mode';
  static const String userBox = 'user_box';
  static const String settingsBox = 'settings_box';
}
