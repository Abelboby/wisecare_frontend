import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/navigation/app_navigator.dart';
import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/repositories/login_repository.dart';

/// Login screen state. Calls repository only.
class LoginProvider extends ChangeNotifier {
  LoginProvider({LoginRepository? repository})
      : _repository = repository ?? LoginRepository();

  final LoginRepository _repository;

  String _email = '';
  String get email => _email;
  set email(String value) {
    if (_email != value) {
      _email = value;
      // Do not notifyListeners() — avoids rebuilding inputs on web and keeps focus.
    }
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    if (_password != value) {
      _password = value;
      // Do not notifyListeners() — avoids rebuilding inputs on web and keeps focus.
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  Future<void> signIn() async {
    if (_isLoading) return;
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.signIn(_email, _password);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      AppNavigator.navigate(AppRoutes.home);
    } catch (e) {
      _errorMessage = e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
