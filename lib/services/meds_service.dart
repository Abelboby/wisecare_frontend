import 'package:dio/dio.dart';

import 'package:wisecare_frontend/models/meds/meds_schedule_model.dart';
import 'package:wisecare_frontend/network/dio_helper.dart';
import 'package:wisecare_frontend/network/endpoints.dart';

/// Meds API service. Calls real backend endpoints.
/// Auth token is injected automatically by DioHelper's JwtInterceptor.
class MedsService {
  /// GET /meds/schedule?date=YYYY-MM-DD
  /// Returns today's schedule: dose sections, medications, refill suggestions.
  Future<MedsScheduleModel> getSchedule({String? date}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (date != null) queryParams['date'] = date;
      final response = await DioHelper.instance.get<Map<String, dynamic>>(
        Endpoints.medsSchedule,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );
      final data = response.data;
      if (data == null) throw Exception('Invalid response from server.');
      return MedsScheduleModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(_messageFromDioException(e));
    }
  }

  /// POST /meds/medications/:id/taken — body: { "takenAt": "ISO8601" }
  /// Marks a dose as taken for today.
  Future<void> markAsTaken(String medicationId) async {
    try {
      await DioHelper.instance.post<Map<String, dynamic>>(
        Endpoints.medsTaken(medicationId),
        data: {'takenAt': DateTime.now().toUtc().toIso8601String()},
        options: Options(contentType: Headers.jsonContentType),
      );
    } on DioException catch (e) {
      throw Exception(_messageFromDioException(e));
    }
  }

  /// POST /meds/refill-requests — body: { "medicationId": "..." }
  /// Requests a refill for the medication.
  Future<void> requestRefill(String medicationId) async {
    try {
      await DioHelper.instance.post<Map<String, dynamic>>(
        Endpoints.medsRefillRequests,
        data: {'medicationId': medicationId},
        options: Options(contentType: Headers.jsonContentType),
      );
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
      if (response!.statusCode! == 400) return 'Invalid request. Please try again.';
      if (response.statusCode! == 403) return 'You do not have permission for this action.';
      if (response.statusCode! == 404) return 'Medication not found.';
      if (response.statusCode! >= 500) return 'Server error. Please try again later.';
    }
    if (response == null || e.type == DioExceptionType.connectionError) {
      return 'Network error. Please check your connection.';
    }
    return e.message ?? 'Something went wrong. Please try again.';
  }
}
