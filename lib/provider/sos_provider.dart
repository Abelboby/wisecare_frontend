import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/models/sos/service_request_model.dart';
import 'package:wisecare_frontend/services/sos_service.dart';

/// Phases the SOS button goes through.
enum SosPhase {
  idle,
  holding,
  sending,
  alerting, // PENDING  — finding agent
  assigned, // ASSIGNED — agent assigned, not yet confirmed
  accepted, // ACCEPTED — agent confirmed, on the way
  inProgress, // IN_PROGRESS
  completed, // COMPLETED
  rejected, // REJECTED — agent rejected, being reassigned
  error,
}

/// SOS flow state: hold-to-trigger, send SOS, poll service request status.
class SosProvider extends ChangeNotifier {
  static const Duration pollInterval = Duration(seconds: 3);
  static const String _tag = 'SosProvider';

  SosPhase _phase = SosPhase.idle;
  SosPhase get phase => _phase;

  bool get isLoading => _phase == SosPhase.sending;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _requestId;
  String? get requestId => _requestId;

  String _status = '';
  String get status => _status;

  String? _assignedAgentName;
  String? get assignedAgentName => _assignedAgentName;

  Timer? _pollTimer;

  double _holdProgress = 0;
  double get holdProgress => _holdProgress;

  Timer? _holdTickTimer;

  static const Duration holdDuration = Duration(seconds: 3);
  static const int _holdTickMs = 50;

  // ── User-facing status text ───────────────────────────────────────────────

  String? get statusMessage {
    switch (_phase) {
      case SosPhase.idle:
      case SosPhase.holding:
        return null;
      case SosPhase.sending:
        return 'Sending SOS signal...';
      case SosPhase.alerting:
        return 'Alerting your family and finding help…';
      case SosPhase.assigned:
        final name = _assignedAgentName?.trim();
        return name != null && name.isNotEmpty ? 'Agent $name has been assigned!' : 'Help is on the way!';
      case SosPhase.accepted:
        final name = _assignedAgentName?.trim();
        return name != null && name.isNotEmpty
            ? '$name has confirmed. Help is coming!'
            : 'Help is confirmed and coming!';
      case SosPhase.inProgress:
        return 'Help is almost there — stay calm.';
      case SosPhase.completed:
        return "You're safe. The request has been resolved.";
      case SosPhase.rejected:
        return 'This request is being reassigned. Please wait.';
      case SosPhase.error:
        return null;
    }
  }

  bool get hasActiveRequest =>
      _requestId != null && _requestId!.isNotEmpty && _phase != SosPhase.completed && _phase != SosPhase.idle;

  // ── Hold gesture ──────────────────────────────────────────────────────────

  void startHold() {
    if (_phase != SosPhase.idle) return;
    _holdProgress = 0;
    _phase = SosPhase.holding;
    notifyListeners();

    _holdTickTimer?.cancel();
    _holdTickTimer = Timer.periodic(
      const Duration(milliseconds: _holdTickMs),
      _onHoldTick,
    );
  }

  void _onHoldTick(Timer timer) {
    _holdProgress += _holdTickMs / holdDuration.inMilliseconds;
    if (_holdProgress >= 1.0) {
      _holdProgress = 1.0;
      timer.cancel();
      _holdTickTimer = null;
      notifyListeners();
      triggerSos();
      return;
    }
    notifyListeners();
  }

  void cancelHold() {
    _holdTickTimer?.cancel();
    _holdTickTimer = null;
    if (_phase == SosPhase.holding) {
      _holdProgress = 0;
      _phase = SosPhase.idle;
      notifyListeners();
    }
  }

  // ── SOS trigger ───────────────────────────────────────────────────────────

  Future<void> triggerSos() async {
    if (_phase == SosPhase.sending) return;
    _errorMessage = null;
    _phase = SosPhase.sending;
    notifyListeners();
    dev.log('Triggering SOS...', name: _tag);

    try {
      final response = await SosService.triggerSos();
      dev.log(
        'SOS response: success=${response.success}'
        ' requestId=${response.requestId} alertId=${response.alertId}',
        name: _tag,
      );

      if (!response.success || response.requestId.isEmpty) {
        _errorMessage = response.message.isNotEmpty ? response.message : 'Failed to send SOS. Please try again.';
        _phase = SosPhase.error;
        notifyListeners();
        return;
      }

      _requestId = response.requestId;
      _status = ServiceRequestModel.statusPending;
      _assignedAgentName = null;
      _phase = SosPhase.alerting;
      notifyListeners();
      _startPolling();
    } catch (e) {
      dev.log('SOS trigger failed: $e', name: _tag, error: e);
      _errorMessage = e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
      _phase = SosPhase.error;
      notifyListeners();
    }
  }

  // ── Polling ───────────────────────────────────────────────────────────────

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(pollInterval, (_) => _pollOnce());
  }

  Future<void> _pollOnce() async {
    final id = _requestId;
    if (id == null || id.isEmpty) {
      _pollTimer?.cancel();
      _pollTimer = null;
      return;
    }

    try {
      final request = await SosService.pollServiceRequest(id);

      // Not in list yet — stay on alerting and keep polling.
      if (request == null) return;

      final newStatus = request.status;
      final newName = request.assignedAgentName;

      dev.log('Poll result: status=$newStatus agent=$newName', name: _tag);

      final prevPhase = _phase;
      final prevName = _assignedAgentName;
      _status = newStatus;
      _assignedAgentName = newName;

      switch (newStatus) {
        case ServiceRequestModel.statusPending:
          _phase = SosPhase.alerting;
          break;
        case ServiceRequestModel.statusAssigned:
          _phase = SosPhase.assigned;
          break;
        case ServiceRequestModel.statusAccepted:
          _phase = SosPhase.accepted;
          break;
        case ServiceRequestModel.statusRejected:
          // Being reassigned — go back to alerting and keep polling.
          _phase = SosPhase.rejected;
          break;
        case ServiceRequestModel.statusInProgress:
          _phase = SosPhase.inProgress;
          break;
        case ServiceRequestModel.statusCompleted:
          _phase = SosPhase.completed;
          break;
        default:
          _phase = SosPhase.alerting;
      }

      if (_phase != prevPhase || newName != prevName) {
        notifyListeners();
      }

      // Stop polling on terminal states.
      if (newStatus == ServiceRequestModel.statusCompleted || newStatus == ServiceRequestModel.statusInProgress) {
        _pollTimer?.cancel();
        _pollTimer = null;
      }
    } catch (_) {
      // Keep polling on transient errors.
    }
  }

  // ── Misc ──────────────────────────────────────────────────────────────────

  void clearError() {
    if (_errorMessage != null || _phase == SosPhase.error) {
      _errorMessage = null;
      _phase = SosPhase.idle;
      notifyListeners();
    }
  }

  /// Cancels all timers and resets state without notifying listeners.
  /// Called from the screen's dispose — the widget tree is already tearing
  /// down so notifyListeners() would throw "widget tree is locked".
  void reset() {
    _pollTimer?.cancel();
    _pollTimer = null;
    _holdTickTimer?.cancel();
    _holdTickTimer = null;
    _requestId = null;
    _status = '';
    _assignedAgentName = null;
    _errorMessage = null;
    _holdProgress = 0;
    _phase = SosPhase.idle;
    // intentionally no notifyListeners() here
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    _holdTickTimer?.cancel();
    super.dispose();
  }
}
