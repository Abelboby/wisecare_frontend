import 'package:hive_flutter/hive_flutter.dart';

import '../utils/storage_keys.dart';

/// Splash initialization: Hive, prefs, etc.
class SplashService {
  Future<void> initialize() async {
    try {
      await Hive.initFlutter();
      await Hive.openBox<dynamic>(StorageKeys.settingsBox);
    } catch (_) {
      // Continue; boxes may already be open
    }
  }
}
