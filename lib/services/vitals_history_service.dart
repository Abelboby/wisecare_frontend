import 'package:dio/dio.dart';

import 'package:wisecare_frontend/models/vitals/vitals_history_response_model.dart';
import 'package:wisecare_frontend/network/dio_helper.dart';
import 'package:wisecare_frontend/network/endpoints.dart';

/// REST service for GET /vitals/history. No WebSocket.
class VitalsHistoryService {
  /// Fetches vitals history for [userId].
  /// [hours] default 24, max 48 per API.
  /// [limit] max snapshots (default 100).
  Future<VitalsHistoryResponse> getHistory(
    String userId, {
    int hours = 24,
    int limit = 100,
  }) async {
    try {
      final response = await DioHelper.instance.get<Map<String, dynamic>>(
        Endpoints.vitalsHistory,
        queryParameters: <String, dynamic>{
          'userId': userId,
          'hours': hours,
          'limit': limit,
        },
      );
      final data = response.data;
      if (data == null) throw Exception('Invalid response from server.');
      return VitalsHistoryResponse.fromJson(data);
    } on DioException catch (e) {
      throw Exception(_messageFromDioException(e));
    }
  }

  static String _messageFromDioException(DioException e) {
    final msg = e.response?.data;
    if (msg is Map && msg['message'] != null) return msg['message'] as String;
    if (e.message != null && e.message!.isNotEmpty) return e.message!;
    return 'Failed to load vitals history.';
  }
}
