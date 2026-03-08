import 'package:wisecare_frontend/models/health_history/health_timeline_response_model.dart';
import 'package:wisecare_frontend/services/health_timeline_service.dart';

/// Health timeline data. Only this layer talks to HealthTimelineService.
class HealthTimelineRepository {
  HealthTimelineRepository({HealthTimelineService? healthTimelineService})
      : _healthTimelineService =
            healthTimelineService ?? HealthTimelineService();

  final HealthTimelineService _healthTimelineService;

  Future<HealthTimelineResponseModel> getHealthTimeline({
    required String userId,
    int? days,
  }) async {
    return _healthTimelineService.getHealthTimeline(userId: userId, days: days);
  }
}
