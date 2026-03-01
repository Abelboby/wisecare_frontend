import 'package:dio/dio.dart';

/// Dio interceptor that attaches JWT and handles 401 (e.g. refresh).
class JwtInterceptor extends Interceptor {
  JwtInterceptor({this.getToken, this.onUnauthorized});

  final String? Function()? getToken;
  final Future<bool> Function()? onUnauthorized;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final token = getToken?.call();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    if (err.response?.statusCode == 401) {
      onUnauthorized?.call().then((refreshed) {
        if (refreshed) {
          // Retry with new token: caller can retry via Dio
          handler.next(err);
        } else {
          handler.next(err);
        }
      });
      return;
    }
    handler.next(err);
  }
}

/// Reads token from a storage abstraction. For now use a simple getter.
String? getStoredAuthToken() {
  // In a real app, read from SharedPreferences or Hive using StorageKeys.authToken.
  return null;
}
