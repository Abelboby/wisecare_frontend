import 'package:wisecare_frontend/models/meds/medication_model.dart';

/// One time block in the schedule (e.g. "Morning Dose" at "8:00 AM") with its medications.
class DoseSectionModel {
  const DoseSectionModel({
    required this.label,
    required this.time,
    required this.medications,
    this.isUpcoming = false,
  });

  /// e.g. "Morning Dose", "Afternoon Dose"
  final String label;
  /// e.g. "8:00 AM", "1:00 PM"
  final String time;
  final List<MedicationModel> medications;
  /// If true, section can be shown dimmed (e.g. afternoon not yet due).
  final bool isUpcoming;

  factory DoseSectionModel.fromJson(Map<String, dynamic> json) {
    final list = json['medications'];
    final items = list is List
        ? list
            .map((e) => MedicationModel.fromJson(
                e is Map<String, dynamic> ? e : Map<String, dynamic>.from(e as Map)))
            .toList()
        : <MedicationModel>[];
    return DoseSectionModel(
      label: json['label'] as String? ?? '',
      time: json['time'] as String? ?? '',
      medications: items,
      isUpcoming: json['isUpcoming'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'time': time,
      'medications': medications.map((m) => m.toJson()).toList(),
      'isUpcoming': isUpcoming,
    };
  }
}
