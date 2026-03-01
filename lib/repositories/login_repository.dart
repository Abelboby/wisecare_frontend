import 'package:wisecare_frontend/services/auth_service.dart';

/// Login data orchestration. Only this layer talks to AuthService.
class LoginRepository {
  Future<void> signIn(String email, String password) async {
    await AuthService.signInWithEmail(email, password);
  }
}
