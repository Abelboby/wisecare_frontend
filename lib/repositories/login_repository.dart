import 'package:wisecare_frontend/models/auth/login_response_model.dart';
import 'package:wisecare_frontend/services/auth_service.dart';

/// Login data orchestration. Only this layer talks to AuthService.
class LoginRepository {
  Future<LoginResponseModel> signIn(String email, String password) async {
    return AuthService.signInWithEmail(email, password);
  }
}
