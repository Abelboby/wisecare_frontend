import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/navigation/app_navigator.dart';
import 'package:wisecare_frontend/navigation/routes.dart';
import 'package:wisecare_frontend/repositories/login_repository.dart';
import 'package:wisecare_frontend/repositories/profile_repository.dart';

/// Login screen state. Calls repository only.
/// Routes by [onboardingStep]: COMPLETE → home; otherwise → onboarding at that step.
/// Uses login response first; if onboardingStep is missing, fetches profile so INVITE_FAMILY etc. are respected.
class LoginProvider extends ChangeNotifier {
  LoginProvider({LoginRepository? repository}) : _repository = repository ?? LoginRepository();

  final LoginRepository _repository;
  final ProfileRepository _profileRepository = ProfileRepository();

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
      final model = await _repository.signIn(_email, _password);
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
      // Use login response step; if missing, fetch profile so INVITE_FAMILY / MEDICATIONS etc. are not treated as COMPLETE
      var step = model.onboardingStep?.trim().toUpperCase();
      if (step == null || step.isEmpty) {
        try {
          final profile = await _profileRepository.getProfile();
          step = profile.onboardingStep.trim().toUpperCase();
        } catch (_) {
          step = 'COMPLETE';
        }
      }
      if (step.isEmpty || step == 'COMPLETE') {
        AppNavigator.navigate(AppRoutes.home);
      } else {
        AppNavigator.navigateToOnboarding(step);
      }
    } catch (e) {
      _errorMessage = e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
}
