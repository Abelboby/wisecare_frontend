/// Single timeline entry from GET /memory/health-timeline/{userId}.
/// API shape: eventId, type, category, title, description, severity, timestamp, metadata.
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
    String date = json['date'] as String? ?? '';
    String time = json['time'] as String? ?? '';
    final timestamp = json['timestamp'];
    if (timestamp != null && date.isEmpty && time.isEmpty) {
      try {
        final dt = DateTime.parse(timestamp.toString());
        date = '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
        time = '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      } catch (_) {}
    }
    final title = json['title'] as String? ?? json['event'] as String? ?? '';
    final severity = json['severity'] as String? ?? json['confidence'] as String? ?? 'MEDIUM';
    final type = json['type'] as String? ?? json['source'] as String? ?? '';
    return HealthTimelineItemModel(
      date: date,
      time: time,
      event: title,
      confidence: severity,
      source: type,
    );
  }
}
