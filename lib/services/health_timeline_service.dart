import 'package:dio/dio.dart';

import 'package:wisecare_frontend/models/health_history/health_timeline_response_model.dart';
import 'package:wisecare_frontend/network/dio_helper.dart';
import 'package:wisecare_frontend/network/endpoints.dart';

/// GET /memory/health-timeline/{userId}. Auth via JwtInterceptor.
/// Query params per API: days, startDate, endDate, eventType, limit.
class HealthTimelineService {
  /// Fetches health timeline for [userId].
  /// Optional: [days], [startDate], [endDate] (ISO 8601), [eventType] (ALERT, SERVICE_REQUEST, MEMORY, MEDICATION), [limit].
  Future<HealthTimelineResponseModel> getHealthTimeline({
    required String userId,
    int? days,
    String? startDate,
    String? endDate,
    String? eventType,
    int? limit,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (days != null) queryParams['days'] = days;
      if (startDate != null && startDate.isNotEmpty) queryParams['startDate'] = startDate;
      if (endDate != null && endDate.isNotEmpty) queryParams['endDate'] = endDate;
      if (eventType != null && eventType.isNotEmpty) queryParams['eventType'] = eventType;
      if (limit != null) queryParams['limit'] = limit;
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

  /// Extracts error message from API response. API uses key "error" (see health-timeline-api.md).
  static String _messageFromDioException(DioException e) {
    final response = e.response;
    if (response?.data is Map<String, dynamic>) {
      final data = response!.data as Map<String, dynamic>;
      final errorMsg = data['error'] as String? ?? data['message'] as String?;
      if (errorMsg != null && errorMsg.isNotEmpty) return errorMsg;
    }
    if (response?.statusCode != null) {
      if (response!.statusCode! == 403) return 'You do not have permission to view this timeline.';
      if (response.statusCode! == 404) return 'User not found.';
      if (response.statusCode! == 405) return 'Method not allowed.';
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
