import 'dart:developer' as dev;

import 'package:dio/dio.dart';

import 'package:wisecare_frontend/models/sos/service_request_model.dart';
import 'package:wisecare_frontend/models/sos/sos_response_model.dart';
import 'package:wisecare_frontend/network/dio_helper.dart';
import 'package:wisecare_frontend/network/endpoints.dart';

/// SOS and service request APIs.
/// Request/response logging is handled centrally by JwtInterceptor.
class SosService {
  SosService._();

  static const String _tag = 'SosService';

  // ── POST /sos ─────────────────────────────────────────────────────────────

  /// Triggers SOS. ELDERLY only. No body.
  /// Returns [SosResponseModel] containing [requestId] — use it to start polling.
  static Future<SosResponseModel> triggerSos() async {
    try {
      dev.log('triggerSos() → POST ${Endpoints.sos}', name: _tag);
      final response = await DioHelper.instance
          .post<Map<String, dynamic>>(Endpoints.sos);
      final data = response.data;
      if (data == null) throw Exception('Invalid response from server.');
      final model = SosResponseModel.fromJson(Map<String, dynamic>.from(data));
      dev.log(
        'triggerSos() success — requestId=${model.requestId}'
        ' alertId=${model.alertId} success=${model.success}',
        name: _tag,
      );
      return model;
    } on DioException catch (e) {
      throw Exception(_messageFromDioException(e));
    }
  }

  // ── GET /service-requests?requestId=<id> ─────────────────────────────────

  /// GET /service-requests/{requestId} — fetches a single request by id.
  /// Returns the [ServiceRequestModel] or null if not found yet (404).
  static Future<ServiceRequestModel?> pollServiceRequest(
      String requestId) async {
    try {
      final path = Endpoints.serviceRequest(requestId);
      dev.log('pollServiceRequest($requestId) → GET $path', name: _tag);

      final response = await DioHelper.instance
          .get<Map<String, dynamic>>(path);

      final data = response.data;
      if (data == null) throw Exception('Invalid response from server.');

      final model = ServiceRequestModel.fromJson(
        Map<String, dynamic>.from(data),
      );
      dev.log(
        'pollServiceRequest($requestId): status=${model.status}'
        ' agent=${model.assignedAgentName}',
        name: _tag,
      );
      return model;
    } on DioException catch (e) {
      // 404 means not created yet — keep polling.
      if (e.response?.statusCode == 404) return null;
      throw Exception(_messageFromDioException(e));
    }
  }

  // ── Error helper ──────────────────────────────────────────────────────────

  static String _messageFromDioException(DioException e) {
    final response = e.response;
    if (response?.data is Map<String, dynamic>) {
      final data = response!.data as Map<String, dynamic>;
      final msg = data['message'] as String?;
      if (msg != null && msg.isNotEmpty) return msg;
    }
    if (response?.statusCode != null) {
      if (response!.statusCode! >= 500) {
        return 'Server error. Please try again later.';
      }
    }
    if (response == null ||
        e.type == DioExceptionType.connectionError ||
        (e.message?.contains('XMLHttpRequest') ?? false)) {
      return 'Network error. Please check your connection and try again.';
    }
    return e.message ?? 'Something went wrong. Please try again.';
  }
}
