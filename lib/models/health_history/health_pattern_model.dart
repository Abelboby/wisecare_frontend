/// Detected pattern from GET /memory/health-timeline (patterns[]).
class HealthPatternModel {
  const HealthPatternModel({
    required this.symptom,
    required this.occurrences,
    required this.frequency,
    this.dates,
    this.severity,
  });

  final String symptom;
  final int occurrences;
  final String frequency;
  final List<String>? dates;
  final String? severity;

  factory HealthPatternModel.fromJson(Map<String, dynamic> json) {
    List<String>? datesList;
    final datesRaw = json['dates'];
    if (datesRaw is List) {
      datesList = datesRaw
          .map((e) => e?.toString() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
    }
    return HealthPatternModel(
      symptom: json['symptom'] as String? ?? '',
      occurrences: (json['occurrences'] is num)
          ? (json['occurrences'] as num).toInt()
          : 0,
      frequency: json['frequency'] as String? ?? '',
      dates: datesList,
      severity: json['severity'] as String?,
    );
  }
}
