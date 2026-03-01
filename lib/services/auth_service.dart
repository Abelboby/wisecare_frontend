import 'package:dio/dio.dart';

import 'package:wisecare_frontend/models/auth/login_response_model.dart';
import 'package:wisecare_frontend/network/endpoints.dart';
import 'package:wisecare_frontend/services/auth_storage_service.dart';
import 'package:wisecare_frontend/network/dio_helper.dart';

/// Auth API: login (email/password). Uses [DioHelper.instance].
class AuthService {
  AuthService._();

  static Future<LoginResponseModel> signInWithEmail(String email, String password) async {
    try {
      final dio = DioHelper.instance;
      final response = await dio.post<Map<String, dynamic>>(
        Endpoints.authLogin,
        data: <String, String>{
          'email': email,
          'password': password,
        },
      );
      final data = response.data;
      if (data == null) {
        throw Exception('Invalid response from server.');
      }
      final status = data['status'] as String?;
      if (status == 'error') {
        final message = data['message'] as String? ?? 'Invalid email or password.';
        throw Exception(message);
      }
      final dataObj = data['data'] as Map<String, dynamic>?;
      if (dataObj == null) {
        throw Exception('Invalid response from server.');
      }
      final model = LoginResponseModel.fromJson(
        Map<String, dynamic>.from(dataObj),
      );
      if (model.accessToken.isEmpty) {
        throw Exception('Invalid response from server.');
      }
      await AuthStorageService.saveAuthTokens(
        model.accessToken,
        model.refreshToken,
      );
      return model;
    } on DioException catch (e) {
      final message = _messageFromDioException(e);
      throw Exception(message);
    }
  }

  static String _messageFromDioException(DioException e) {
    final response = e.response;
    if (response?.data is Map<String, dynamic>) {
      final data = response!.data as Map<String, dynamic>;
      final msg = data['message'] as String?;
      if (msg != null && msg.isNotEmpty) return msg;
    }
    if (response?.statusCode != null) {
      if (response!.statusCode! == 401) return 'Invalid email or password.';
      if (response.statusCode! >= 500) return 'Server error. Please try again later.';
    }
    return e.message ?? 'Something went wrong. Please try again.';
  }
}
