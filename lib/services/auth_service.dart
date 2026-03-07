import 'package:dio/dio.dart';

import 'package:wisecare_frontend/models/auth/login_response_model.dart';
import 'package:wisecare_frontend/models/auth/signup_response_model.dart';
import 'package:wisecare_frontend/network/endpoints.dart';
import 'package:wisecare_frontend/network/dio_helper.dart';
import 'package:wisecare_frontend/services/auth_storage_service.dart';

/// Auth API: signin and signup. Uses [DioHelper.instance].
/// All error responses from the server use the `error` key: {"error": "..."}.
class AuthService {
  AuthService._();

  static Future<LoginResponseModel> signInWithEmail(
      String email, String password) async {
    try {
      final dio = DioHelper.instance;
      final response = await dio.post<Map<String, dynamic>>(
        Endpoints.authSignin,
        data: <String, String>{
          'email': email,
          'password': password,
        },
        options: Options(contentType: Headers.jsonContentType),
      );
      final data = response.data;
      if (data == null) {
        throw Exception('Invalid response from server.');
      }
      final model = LoginResponseModel.fromJson(
        Map<String, dynamic>.from(data),
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

  /// Extracts a human-readable message from a [DioException].
  /// Checks the `error` key first (signup/general API), then `message` (legacy).
  static String _messageFromDioException(DioException e) {
    final response = e.response;
    if (response?.data is Map<String, dynamic>) {
      final data = response!.data as Map<String, dynamic>;
      final serverMsg = (data['error'] as String?)?.trim() ??
          (data['message'] as String?)?.trim();
      if (serverMsg != null && serverMsg.isNotEmpty) return serverMsg;
    }
    if (response?.statusCode != null) {
      switch (response!.statusCode!) {
        case 400:
          return 'Please check your details and try again.';
        case 401:
          return 'Invalid email or password.';
        case 403:
          return 'This role is not available for public signup.';
        case 409:
          return 'An account with this email already exists. Please sign in.';
        default:
          if (response.statusCode! >= 500) {
            return 'Server error. Please try again later.';
          }
      }
    }
    if (response == null ||
        e.type == DioExceptionType.connectionError ||
        (e.message?.contains('XMLHttpRequest') ?? false)) {
      return 'Network error. Please check your connection and try again.';
    }
    return e.message ?? 'Something went wrong. Please try again.';
  }

  /// Signs up a new user. `role` must be `ELDERLY` or `FAMILY`.
  /// `phone` is the 10-digit mobile number (without country code);
  /// the +91 prefix is added here before sending.
  static Future<SignupResponseModel> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String city,
    required String role,
  }) async {
    try {
      final dio = DioHelper.instance;
      final body = <String, String>{
        'name': fullName.trim(),
        'email': email.trim().toLowerCase(),
        'password': password,
        'role': role,
      };
      if (phone.trim().isNotEmpty) {
        body['phone'] = '+91${phone.trim()}';
      }
      if (city.trim().isNotEmpty) {
        body['city'] = city.trim();
      }
      final response = await dio.post<Map<String, dynamic>>(
        Endpoints.authSignup,
        data: body,
        options: Options(contentType: Headers.jsonContentType),
      );
      final data = response.data;
      if (data == null) {
        throw Exception('Invalid response from server.');
      }
      final model = SignupResponseModel.fromJson(
        Map<String, dynamic>.from(data),
      );
      await AuthStorageService.saveAuthTokens(
        model.accessToken,
        model.refreshToken ?? '',
      );
      return model;
    } on DioException catch (e) {
      final message = _messageFromDioException(e);
      throw Exception(message);
    }
  }

  /// Revokes refresh token on server, then clears local tokens.
  /// If no refresh token or API fails, still clears local tokens.
  static Future<void> signOut() async {
    final refreshToken = AuthStorageService.getStoredRefreshToken();
    try {
      if (refreshToken != null && refreshToken.isNotEmpty) {
        final dio = DioHelper.instance;
        await dio.post<Map<String, dynamic>>(
          Endpoints.authSignout,
          data: <String, String>{'refreshToken': refreshToken},
          options: Options(contentType: Headers.jsonContentType),
        );
      }
    } on DioException catch (_) {
      // Best effort: still clear tokens and sign out locally
    } finally {
      await AuthStorageService.clearAuthTokens();
    }
  }
}
