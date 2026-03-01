import 'package:flutter/foundation.dart';

import '../repositories/splash_repository.dart';

/// Splash screen state. Calls repository only.
class SplashProvider extends ChangeNotifier {
  SplashProvider({SplashRepository? repository})
      : _repository = repository ?? SplashRepository();

  final SplashRepository _repository;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  String? _error;
  String? get error => _error;

  Future<void> loadInitialData() async {
    if (_isInitialized) return;
    try {
      await _repository.initialize();
      _isInitialized = true;
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}
