import 'package:wisecare_frontend/models/health_history/health_pattern_model.dart';
import 'package:wisecare_frontend/models/health_history/health_recommendation_model.dart';
import 'package:wisecare_frontend/models/health_history/health_timeline_item_model.dart';

/// Response from GET /memory/health-timeline/{userId}.
/// Supports Format A (summary, patterns, recommendations) and Format B (timeline + dateRange only).
class HealthTimelineResponseModel {
  const HealthTimelineResponseModel({
    required this.userId,
    required this.userName,
    this.age,
    required this.dateRangeFrom,
    required this.dateRangeTo,
    this.totalHealthEvents,
    this.patternsDetected,
    this.highConfidenceEvents,
    required this.timeline,
    this.patterns,
    this.recommendations,
  });

  final String userId;
  final String userName;
  final int? age;
  final String dateRangeFrom;
  final String dateRangeTo;
  final int? totalHealthEvents;
  final int? patternsDetected;
  final int? highConfidenceEvents;
  final List<HealthTimelineItemModel> timeline;
  final List<HealthPatternModel>? patterns;
  final List<HealthRecommendationModel>? recommendations;

  factory HealthTimelineResponseModel.fromJson(Map<String, dynamic> json) {
    final dateRange = json['dateRange'] as Map<String, dynamic>?;
    final summary = json['summary'] as Map<String, dynamic>?;

    final from = _dateRangeValue(dateRange, 'from', 'startDate');
    final to = _dateRangeValue(dateRange, 'to', 'endDate');

    final timelineRaw = json['timeline'];
    List<HealthTimelineItemModel> timelineList = [];
    if (timelineRaw is List) {
      for (final e in timelineRaw) {
        if (e is Map<String, dynamic>) {
          timelineList.add(HealthTimelineItemModel.fromJson(e));
        }
      }
    }

    List<HealthPatternModel>? patternsList;
    final patternsRaw = json['patterns'];
    if (patternsRaw is List) {
      patternsList = patternsRaw
          .whereType<Map<String, dynamic>>()
          .map(HealthPatternModel.fromJson)
          .toList();
    }

    List<HealthRecommendationModel>? recsList;
    final recsRaw = json['recommendations'];
    if (recsRaw is List) {
      recsList = recsRaw
          .whereType<Map<String, dynamic>>()
          .map(HealthRecommendationModel.fromJson)
          .toList();
    }

    int? totalEvents = summary != null && summary['totalHealthEvents'] is num
        ? (summary['totalHealthEvents'] as num).toInt()
        : null;
    if (totalEvents == null && json['count'] is num) {
      totalEvents = (json['count'] as num).toInt();
    }

    int? patternsCount = summary != null && summary['patternsDetected'] is num
        ? (summary['patternsDetected'] as num).toInt()
        : null;
    if (patternsCount == null && patternsList != null && patternsList.isNotEmpty) {
      patternsCount = patternsList.length;
    }

    return HealthTimelineResponseModel(
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      age: json['age'] is num ? (json['age'] as num).toInt() : null,
      dateRangeFrom: from,
      dateRangeTo: to,
      totalHealthEvents: totalEvents,
      patternsDetected: patternsCount,
      highConfidenceEvents:
          summary != null && summary['highConfidenceEvents'] is num
              ? (summary['highConfidenceEvents'] as num).toInt()
              : null,
      timeline: timelineList,
      patterns: patternsList?.isEmpty == true ? null : patternsList,
      recommendations: recsList?.isEmpty == true ? null : recsList,
    );
  }

  static String _dateRangeValue(
    Map<String, dynamic>? dateRange,
    String key1,
    String key2,
  ) {
    if (dateRange == null) return '';
    final v = dateRange[key1] ?? dateRange[key2];
    if (v == null) return '';
    return v is String ? v : v.toString();
  }
}
