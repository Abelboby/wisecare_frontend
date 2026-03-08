import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/models/vitals/vitals_history_response_model.dart';
import 'package:wisecare_frontend/services/vitals_history_service.dart';

/// Holds vitals history from GET /vitals/history. Used by Health tab (no WebSocket).
class VitalsHistoryProvider extends ChangeNotifier {
  VitalsHistoryProvider({VitalsHistoryService? service})
      : _service = service ?? VitalsHistoryService();

  final VitalsHistoryService _service;

  VitalsHistoryResponse? _history;
  VitalsHistoryResponse? get history => _history;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Selected hours for API: 24 (7 Days) or 48 (30 Days / 3 Months). API max is 48.
  int _selectedHours = 24;
  int get selectedHours => _selectedHours;

  /// Selected range index: 0 = 7 Days, 1 = 30 Days, 2 = 3 Months. Used so 30 Days and 3 Months (both 48h) show the correct chip.
  int _selectedRangeIndex = 0;
  int get selectedRangeIndex => _selectedRangeIndex;

  int _fetchId = 0;

  /// 24 = 7 Days, 48 = 30 Days or 3 Months.
  void setSelectedHours(int hours) {
    if (hours == _selectedHours) return;
    _selectedHours = hours.clamp(24, 48);
    notifyListeners();
  }

  /// Sets both range index and hours so the correct chip is highlighted (30 Days vs 3 Months both use 48h).
  void setSelectedRange(int rangeIndex, int hours) {
    if (rangeIndex == _selectedRangeIndex && hours == _selectedHours) return;
    _selectedRangeIndex = rangeIndex.clamp(0, 2);
    _selectedHours = hours.clamp(24, 48);
    notifyListeners();
  }

  /// Fetches history for [userId]. Uses [hours] if provided, otherwise [selectedHours].
  /// Ignores out-of-order responses so switching filters quickly won't show stale data.
  Future<void> fetchHistory(String userId, {int? hours}) async {
    if (userId.isEmpty) return;
    final effectiveHours = hours ?? _selectedHours;
    _fetchId += 1;
    final thisFetchId = _fetchId;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final result = await _service.getHistory(userId, hours: effectiveHours);
      if (thisFetchId != _fetchId) return;
      _history = result;
      _selectedHours = effectiveHours;
      _errorMessage = null;
    } catch (e) {
      if (thisFetchId != _fetchId) return;
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      if (thisFetchId == _fetchId) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  void clearError() {
    if (_errorMessage == null) return;
    _errorMessage = null;
    notifyListeners();
  }
}
