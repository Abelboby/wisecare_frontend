import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/models/meds/meds_schedule_model.dart';
import 'package:wisecare_frontend/repositories/meds_repository.dart';

/// Meds tab state. Holds schedule and loading/error. Load schedule when opening meds tab.
class MedsProvider extends ChangeNotifier {
  MedsProvider({MedsRepository? repository}) : _repository = repository ?? MedsRepository();

  final MedsRepository _repository;

  MedsScheduleModel? _schedule;
  MedsScheduleModel? get schedule => _schedule;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Medication IDs currently being marked as taken (API call in-flight).
  final Set<String> _markingTakenIds = {};

  bool isMarkingTaken(String medicationId) => _markingTakenIds.contains(medicationId);

  Future<void> loadSchedule({String? date}) async {
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      _schedule = await _repository.getSchedule(date: date);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Marks a dose as taken, then silently re-fetches the schedule
  /// so the screen reflects the latest backend state (updated isUpcoming,
  /// next pill becomes active, etc.).
  Future<void> markAsTaken(String medicationId) async {
    if (_markingTakenIds.contains(medicationId)) return;
    _markingTakenIds.add(medicationId);
    _errorMessage = null;
    notifyListeners();
    try {
      await _repository.markAsTaken(medicationId);
      // Re-fetch after success — backend returns updated isUpcoming flags,
      // correct isTakenToday values, and any new dose sections to display.
      await _silentRefresh();
    } catch (e) {
      _errorMessage = e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
      notifyListeners();
    } finally {
      _markingTakenIds.remove(medicationId);
      notifyListeners();
    }
  }

  Future<void> requestRefill(String medicationId) async {
    try {
      await _repository.requestRefill(medicationId);
    } catch (e) {
      _errorMessage = e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
      notifyListeners();
    }
  }

  /// Re-fetches the schedule without showing the full-screen loading indicator.
  /// The existing schedule stays visible while the call is in progress.
  Future<void> _silentRefresh({String? date}) async {
    try {
      final updated = await _repository.getSchedule(date: date);
      _schedule = updated;
      notifyListeners();
    } catch (_) {
      // Swallow silently — the optimistic local state is good enough if
      // the refresh fails. User can pull-to-refresh if needed.
    }
  }
}
