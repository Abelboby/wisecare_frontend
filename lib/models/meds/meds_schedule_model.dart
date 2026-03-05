import 'package:wisecare_frontend/models/meds/dose_section_model.dart';
import 'package:wisecare_frontend/models/meds/refill_suggestion_model.dart';

/// Top-level response for "today's meds schedule" API.
/// GET /meds/schedule or GET /users/me/meds/today
class MedsScheduleModel {
  const MedsScheduleModel({
    required this.userName,
    required this.date,
    required this.doseSections,
    this.refillSuggestions = const [],
  });

  /// For greeting: "Hello, {userName}"
  final String userName;

  /// Schedule date (ISO date string or YYYY-MM-DD).
  final String date;

  /// Ordered list of dose blocks (Morning, Afternoon, etc.).
  final List<DoseSectionModel> doseSections;

  /// Medications to show in "Refill Prescription" (e.g. low stock).
  final List<RefillSuggestionModel> refillSuggestions;

  factory MedsScheduleModel.fromJson(Map<String, dynamic> json) {
    final sections = json['doseSections'];
    final sectionList = sections is List
        ? (sections)
            .map((e) => DoseSectionModel.fromJson(e is Map<String, dynamic> ? e : Map<String, dynamic>.from(e as Map)))
            .toList()
        : <DoseSectionModel>[];
    final refills = json['refillSuggestions'];
    final refillList = refills is List
        ? (refills)
            .map((e) =>
                RefillSuggestionModel.fromJson(e is Map<String, dynamic> ? e : Map<String, dynamic>.from(e as Map)))
            .toList()
        : <RefillSuggestionModel>[];
    return MedsScheduleModel(
      userName: json['userName'] as String? ?? '',
      date: json['date'] as String? ?? '',
      doseSections: sectionList,
      refillSuggestions: refillList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'date': date,
      'doseSections': doseSections.map((s) => s.toJson()).toList(),
      'refillSuggestions': refillSuggestions.map((r) => r.toJson()).toList(),
    };
  }
}
