/// Recommendation from GET /memory/health-timeline (recommendations[]).
class HealthRecommendationModel {
  const HealthRecommendationModel({
    required this.type,
    required this.priority,
    required this.reason,
    required this.action,
  });

  final String type;
  final String priority;
  final String reason;
  final String action;

  factory HealthRecommendationModel.fromJson(Map<String, dynamic> json) {
    return HealthRecommendationModel(
      type: json['type'] as String? ?? '',
      priority: json['priority'] as String? ?? 'MEDIUM',
      reason: json['reason'] as String? ?? '',
      action: json['action'] as String? ?? '',
    );
  }
}
