import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:wisecare_frontend/models/vitals/vitals_model.dart';
import 'package:wisecare_frontend/services/vitals_service.dart';

/// Holds the latest real-time vitals data pushed from the backend WebSocket.
///
/// Lifecycle:
///   - Call [init] once the userId is known (e.g. after profile loads).
///   - The provider manages its own [VitalsService] internally.
///   - Call [dispose] (handled automatically by ChangeNotifierProvider).
class VitalsProvider extends ChangeNotifier {
  VitalsModel? _vitals;
  VitalsModel? get vitals => _vitals;

  bool _connected = false;
  bool get isConnected => _connected;

  VitalsService? _service;
  StreamSubscription<VitalsModel>? _sub;
  String? _initializedUserId;

  /// Starts (or re-starts) the WebSocket for [userId].
  /// Safe to call multiple times; subsequent calls with the same userId are no-ops.
  void init(String userId) {
    if (_initializedUserId == userId) return;
    _dispose();

    _initializedUserId = userId;
    _service = VitalsService(userId: userId);
    _sub = _service!.stream.listen(_onVitals);
    _service!.connect();
    _connected = _service!.isConnected;
    notifyListeners();
  }

  void _onVitals(VitalsModel vitals) {
    _vitals = vitals;
    _connected = true;
    notifyListeners();
  }

  void _dispose() {
    _sub?.cancel();
    _service?.dispose();
    _sub = null;
    _service = null;
    _initializedUserId = null;
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }
}
