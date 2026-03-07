import 'package:wisecare_frontend/models/auth/signup_response_model.dart';
import 'package:wisecare_frontend/services/auth_service.dart';

/// Signup data orchestration. Only this layer talks to AuthService.
class SignupRepository {
  Future<SignupResponseModel> signUp({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String city,
    required String role,
  }) async {
    return AuthService.signUpWithEmail(
      fullName: fullName,
      email: email,
      password: password,
      phone: phone,
      city: city,
      role: role,
    );
  }
}
