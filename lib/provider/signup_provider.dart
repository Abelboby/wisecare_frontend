import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/navigation/app_navigator.dart';
import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/repositories/signup_repository.dart';

enum UserRole { sevakar, familyMember }

/// Signup screen state. Calls repository only.
class SignupProvider extends ChangeNotifier {
  SignupProvider({SignupRepository? repository})
      : _repository = repository ?? SignupRepository();

  final SignupRepository _repository;

  String _fullName = '';
  String get fullName => _fullName;
  set fullName(String value) {
    if (_fullName != value) _fullName = value;
  }

  String _email = '';
  String get email => _email;
  set email(String value) {
    if (_email != value) _email = value;
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    if (_password != value) _password = value;
  }

  String _mobile = '';
  String get mobile => _mobile;
  set mobile(String value) {
    if (_mobile != value) _mobile = value;
  }

  String? _city;
  String? get city => _city;

  UserRole _role = UserRole.sevakar;
  UserRole get role => _role;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void selectRole(UserRole role) {
    if (_role != role) {
      _role = role;
      notifyListeners();
    }
  }

  void selectCity(String city) {
    _city = city;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  Future<void> signUp() async {
    if (_isLoading) return;
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      await _repository.signUp(
        fullName: _fullName,
        email: _email,
        password: _password,
        phone: _mobile,
        city: _city ?? '',
        role: _role == UserRole.sevakar ? 'ELDERLY' : 'FAMILY',
      );
      _isLoading = false;
      notifyListeners();
      AppNavigator.navigate(AppRoutes.home);
    } catch (e) {
      _errorMessage =
          e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
