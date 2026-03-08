import 'package:dio/dio.dart';

import 'package:wisecare_frontend/models/health_history/health_timeline_response_model.dart';
import 'package:wisecare_frontend/network/dio_helper.dart';
import 'package:wisecare_frontend/network/endpoints.dart';

/// GET /memory/health-timeline/{userId}. Auth via JwtInterceptor.
class HealthTimelineService {
  /// Fetches health timeline for [userId]. Optional [days] (default 30).
  Future<HealthTimelineResponseModel> getHealthTimeline({
    required String userId,
    int? days,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (days != null) queryParams['days'] = days;
      final response = await DioHelper.instance.get<Map<String, dynamic>>(
        Endpoints.healthTimeline(userId),
        queryParameters:
            queryParams.isNotEmpty ? queryParams : null,
      );
      final data = response.data;
      if (data == null) throw Exception('Invalid response from server.');
      return HealthTimelineResponseModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(_messageFromDioException(e));
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
      if (response!.statusCode! == 404) return 'Health timeline not found.';
      if (response.statusCode! >= 500) {
        return 'Server error. Please try again later.';
      }
    }
    if (response == null || e.type == DioExceptionType.connectionError) {
      return 'Network error. Please check your connection.';
    }
    return e.message ?? 'Something went wrong. Please try again.';
  }
}
