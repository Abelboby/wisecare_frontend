import 'package:dio/dio.dart';

import '../utils/static_values.dart';
import 'jwt_interceptor.dart';

/// Singleton Dio instance with base URL, timeouts, and JWT interceptor.
class DioHelper {
  DioHelper._();

  static Dio? _dio;

  static Dio get instance {
    if (_dio != null) return _dio!;
    _dio = Dio(
      BaseOptions(
        baseUrl: StaticValues.apiBaseUrl,
        connectTimeout:
            Duration(milliseconds: StaticValues.connectTimeout),
        receiveTimeout:
            Duration(milliseconds: StaticValues.receiveTimeout),
      ),
    );
    _dio!.interceptors.add(
      JwtInterceptor(
        getToken: getStoredAuthToken,
        onUnauthorized: _handleUnauthorized,
      ),
    );
    return _dio!;
  }

  static Future<bool> _handleUnauthorized() async {
    // Todo: refresh token using StorageKeys.refreshToken, then save new auth token.
    return false;
  }
}
