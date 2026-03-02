import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/navigation/app_navigator.dart';
import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/services/auth_service.dart';

/// Profile tab state. Handles sign out and navigation.
class ProfileProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> signOut() async {
    if (_isLoading) return;
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      await AuthService.signOut();
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      AppNavigator.navigate(AppRoutes.login);
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
