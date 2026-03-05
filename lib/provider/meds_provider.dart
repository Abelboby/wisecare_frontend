import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/models/meds/dose_section_model.dart';
import 'package:wisecare_frontend/models/meds/meds_schedule_model.dart';
import 'package:wisecare_frontend/repositories/meds_repository.dart';

/// Meds tab state. Holds schedule and loading/error. Load schedule when opening meds tab.
class MedsProvider extends ChangeNotifier {
  MedsProvider({MedsRepository? repository})
      : _repository = repository ?? MedsRepository();

  final MedsRepository _repository;

  MedsScheduleModel? _schedule;
  MedsScheduleModel? get schedule => _schedule;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadSchedule({String? date}) async {
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      _schedule = await _repository.getSchedule(date: date);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> markAsTaken(String medicationId) async {
    try {
      await _repository.markAsTaken(medicationId);
      _updateMedicationTaken(medicationId, true);
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
      notifyListeners();
    }
  }

  Future<void> requestRefill(String medicationId) async {
    try {
      await _repository.requestRefill(medicationId);
      notifyListeners();
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
      notifyListeners();
    }
  }

  void _updateMedicationTaken(String medicationId, bool taken) {
    if (_schedule == null) return;
    final sections = _schedule!.doseSections.map((section) {
      final meds = section.medications.map((m) {
        if (m.id == medicationId) return m.copyWith(isTakenToday: taken);
        return m;
      }).toList();
      return DoseSectionModel(
        label: section.label,
        time: section.time,
        medications: meds,
        isUpcoming: section.isUpcoming,
      );
    }).toList();
    _schedule = MedsScheduleModel(
      userName: _schedule!.userName,
      date: _schedule!.date,
      doseSections: sections,
      refillSuggestions: _schedule!.refillSuggestions,
    );
    notifyListeners();
  }
}
