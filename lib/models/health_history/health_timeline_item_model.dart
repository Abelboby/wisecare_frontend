/// Single timeline entry from GET /memory/health-timeline/{userId}.
class HealthTimelineItemModel {
  const HealthTimelineItemModel({
    required this.date,
    required this.time,
    required this.event,
    required this.confidence,
    required this.source,
  });

  final String date;
  final String time;
  final String event;
  final String confidence;
  final String source;

  factory HealthTimelineItemModel.fromJson(Map<String, dynamic> json) {
    return HealthTimelineItemModel(
      date: json['date'] as String? ?? '',
      time: json['time'] as String? ?? '',
      event: json['event'] as String? ?? '',
      confidence: json['confidence'] as String? ?? 'MEDIUM',
      source: json['source'] as String? ?? '',
    );
  }
}
