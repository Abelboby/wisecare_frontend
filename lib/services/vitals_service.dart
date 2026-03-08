import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:wisecare_frontend/models/vitals/vitals_model.dart';

/// Manages the WebSocket connection to the real-time vitals stream.
class VitalsService {
  static const String _wsUrl =
      'wss://3jvp5p6mz3.execute-api.ap-south-1.amazonaws.com/production';

  static const Duration _pingInterval = Duration(seconds: 30);
  static const Duration _reconnectDelay = Duration(seconds: 5);

  final String userId;

  VitalsService({required this.userId});

  final _controller = StreamController<VitalsModel>.broadcast();
  Stream<VitalsModel> get stream => _controller.stream;

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _channelSub;
  Timer? _pingTimer;
  Timer? _reconnectTimer;

  bool _disposed = false;
  bool _connected = false;
  bool get isConnected => _connected;

  void connect() {
    if (_disposed || _connected) return;
    _doConnect();
  }

  void _doConnect() {
    if (_disposed) return;
    final uri = Uri.parse('$_wsUrl?userId=$userId');
    try {
      _channel = WebSocketChannel.connect(uri);
      _connected = true;
      debugPrint('[VitalsWS] ✅ Connected (userId: $userId)');

      _channelSub = _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: false,
      );

      _startPing();
    } catch (e) {
      debugPrint('[VitalsWS] ❌ Connection failed: $e');
      _connected = false;
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic raw) {
    try {
      final map = json.decode(raw as String) as Map<String, dynamic>;
      if (map['type'] == 'vitals_update') {
        final vitals = VitalsModel.fromJson(
          map['data'] as Map<String, dynamic>,
        );
        debugPrint(
          '[VitalsWS] 💓 HR: ${vitals.heartRate} bpm | '
          'BP: ${vitals.bpLabel} mmHg | '
          'O2: ${vitals.oxygenSaturation}% | '
          'Risk: ${vitals.risk}',
        );
        if (!_controller.isClosed) _controller.add(vitals);
      }
    } catch (e) {
      debugPrint('[VitalsWS] ⚠️ Failed to parse frame: $e');
    }
  }

  void _onError(dynamic error) {
    debugPrint('[VitalsWS] ❌ Stream error: $error');
    _connected = false;
    _cleanupChannel();
    _scheduleReconnect();
  }

  void _onDone() {
    debugPrint('[VitalsWS] 🔌 Disconnected');
    _connected = false;
    _cleanupChannel();
    _scheduleReconnect();
  }

  void _startPing() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(_pingInterval, (_) => _sendPing());
  }

  void _sendPing() {
    try {
      _channel?.sink.add(json.encode({'action': 'ping'}));
    } catch (_) {}
  }

  void _scheduleReconnect() {
    if (_disposed) return;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(_reconnectDelay, () {
      if (!_disposed && !_connected) _doConnect();
    });
  }

  void _cleanupChannel() {
    _pingTimer?.cancel();
    _channelSub?.cancel();
    try {
      _channel?.sink.close();
    } catch (_) {}
    _channel = null;
    _channelSub = null;
  }

  void dispose() {
    _disposed = true;
    _reconnectTimer?.cancel();
    _cleanupChannel();
    _controller.close();
  }
}
