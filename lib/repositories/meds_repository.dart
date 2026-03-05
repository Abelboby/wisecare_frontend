import 'package:wisecare_frontend/models/meds/meds_schedule_model.dart';
import 'package:wisecare_frontend/services/meds_service.dart';

/// Meds data orchestration. Only this layer talks to MedsService.
class MedsRepository {
  MedsRepository({MedsService? medsService}) : _medsService = medsService ?? MedsService();

  final MedsService _medsService;

  Future<MedsScheduleModel> getSchedule({String? date}) async {
    return _medsService.getSchedule(date: date);
  }

  Future<void> markAsTaken(String medicationId) async {
    await _medsService.markAsTaken(medicationId);
  }

  Future<void> requestRefill(String medicationId) async {
    await _medsService.requestRefill(medicationId);
  }
}
