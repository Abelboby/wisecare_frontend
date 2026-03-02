import 'package:dio/dio.dart';

import 'package:wisecare_frontend/models/chat/chat_response_model.dart';
import 'package:wisecare_frontend/network/dio_helper.dart';
import 'package:wisecare_frontend/network/endpoints.dart';

/// Companion chat API: POST /companion/chat.
class ChatService {
  ChatService._();

  static Future<ChatResponseModel> sendMessage(
    String message, {
    String? sessionId,
  }) async {
    try {
      final dio = DioHelper.instance;
      final data = <String, dynamic>{
        'message': message,
      };
      if (sessionId != null && sessionId.isNotEmpty) {
        data['sessionId'] = sessionId;
      }
      final response = await dio.post<Map<String, dynamic>>(
        Endpoints.companionChat,
        data: data,
        options: Options(contentType: Headers.jsonContentType),
      );
      final respData = response.data;
      if (respData == null) {
        throw Exception('Invalid response from server.');
      }
      return ChatResponseModel.fromJson(
        Map<String, dynamic>.from(respData),
      );
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
