import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/models/chat/chat_message_model.dart';
import 'package:wisecare_frontend/services/chat_service.dart';

/// Chat with Arya state. Messages, sessionId, sendMessage, loading, error.
class ChatProvider extends ChangeNotifier {
  final List<ChatMessageModel> _messages = [];
  List<ChatMessageModel> get messages => List.unmodifiable(_messages);

  String? _sessionId;
  String? get sessionId => _sessionId;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Sends [message] to Arya, appends user message, fetches reply, appends Arya reply.
  Future<void> sendMessage(String message) async {
    final trimmed = message.trim();
    if (trimmed.isEmpty || _isLoading) return;

    _errorMessage = null;
    _messages.add(ChatMessageModel(text: trimmed, isFromUser: true));
    notifyListeners();

    _isLoading = true;
    notifyListeners();

    try {
      final response = await ChatService.sendMessage(
        trimmed,
        sessionId: _sessionId,
      );
      _sessionId = response.sessionId;
      _messages.add(ChatMessageModel(text: response.reply, isFromUser: false));
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }
}
