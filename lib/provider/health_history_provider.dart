import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/models/health_history/health_pattern_model.dart';
import 'package:wisecare_frontend/models/health_history/health_recommendation_model.dart';
import 'package:wisecare_frontend/models/health_history/health_timeline_item_model.dart';
import 'package:wisecare_frontend/models/health_history/health_timeline_response_model.dart';
import 'package:wisecare_frontend/repositories/health_timeline_repository.dart';

/// My Health History screen state. Loads health timeline from API.
class HealthHistoryProvider extends ChangeNotifier {
  HealthHistoryProvider({HealthTimelineRepository? repository})
      : _repository = repository ?? HealthTimelineRepository();

  final HealthTimelineRepository _repository;

  HealthTimelineResponseModel? _data;
  HealthTimelineResponseModel? get data => _data;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Timeline entries (convenience).
  List<HealthTimelineItemModel> get timeline => _data?.timeline ?? [];

  /// Detected patterns (convenience).
  List<HealthPatternModel> get patterns => _data?.patterns ?? [];

  /// Recommendations (convenience).
  List<HealthRecommendationModel> get recommendations =>
      _data?.recommendations ?? [];

  /// Total health events from summary.
  int get totalHealthEvents => _data?.totalHealthEvents ?? 0;

  /// Patterns count from summary.
  int get patternsDetected => _data?.patternsDetected ?? 0;

  /// Date range label (e.g. "Last 7 Days" or "Feb 6 – Mar 7, 2026").
  String get dateRangeLabel {
    final from = _data?.dateRangeFrom;
    final to = _data?.dateRangeTo;
    if (from == null || from.isEmpty || to == null || to.isEmpty) {
      return 'Last 30 Days';
    }
    try {
      final fromDt = DateTime.parse(from);
      final toDt = DateTime.parse(to);
      final days = toDt.difference(fromDt).inDays;
      if (days <= 7) return 'Last 7 Days';
      if (days <= 30) return 'Last 30 Days';
      return '${_formatShort(fromDt)} – ${_formatShort(toDt)}';
    } catch (_) {
      return 'Last 30 Days';
    }
  }

  static String _formatShort(DateTime d) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final m = d.month >= 1 && d.month <= 12 ? months[d.month - 1] : '';
    return '$m ${d.day}, ${d.year}';
  }

  /// Loads health timeline for [userId]. Optional [days] (default 30).
  Future<void> loadHealthTimeline({required String userId, int? days}) async {
    if (userId.isEmpty) {
      _errorMessage = 'User not found.';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      _data = await _repository.getHealthTimeline(userId: userId, days: days);
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
}
