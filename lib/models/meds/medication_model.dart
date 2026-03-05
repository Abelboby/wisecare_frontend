/// Single medication item for the meds schedule (from backend or mock).
/// Maps to: drug name, dosage, when to take, instruction, low-stock warning, taken state.
class MedicationModel {
  const MedicationModel({
    required this.id,
    required this.name,
    required this.dosageDisplay,
    required this.whenToTake,
    required this.scheduledTime,
    this.instruction,
    this.pillsRemaining,
    this.isTakenToday = false,
    this.cardType = MedsCardType.featured,
  });

  final String id;
  final String name;
  /// e.g. "500mg", "81mg"
  final String dosageDisplay;
  /// e.g. "After Breakfast", "After Lunch"
  final String whenToTake;
  /// e.g. "8:00 AM"
  final String scheduledTime;
  /// e.g. "Take 1 tablet with water."
  final String? instruction;
  /// Null = no warning; set to show "X pills left - Reorder soon"
  final int? pillsRemaining;
  final bool isTakenToday;
  /// "featured" = large card with image; "compact" = small row card
  final MedsCardType cardType;

  factory MedicationModel.fromJson(Map<String, dynamic> json) {
    return MedicationModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      dosageDisplay: json['dosageDisplay'] as String? ?? '',
      whenToTake: json['whenToTake'] as String? ?? '',
      scheduledTime: json['scheduledTime'] as String? ?? '',
      instruction: json['instruction'] as String?,
      pillsRemaining: json['pillsRemaining'] as int?,
      isTakenToday: json['isTakenToday'] as bool? ?? false,
      cardType: _parseCardType(json['cardType']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosageDisplay': dosageDisplay,
      'whenToTake': whenToTake,
      'scheduledTime': scheduledTime,
      'instruction': instruction,
      'pillsRemaining': pillsRemaining,
      'isTakenToday': isTakenToday,
      'cardType': cardType.name,
    };
  }

  static MedsCardType _parseCardType(dynamic v) {
    if (v == null) return MedsCardType.featured;
    final s = v.toString().toLowerCase();
    if (s == 'compact') return MedsCardType.compact;
    return MedsCardType.featured;
  }

  /// Copy with updated isTakenToday (after marking as taken).
  MedicationModel copyWith({bool? isTakenToday}) {
    return MedicationModel(
      id: id,
      name: name,
      dosageDisplay: dosageDisplay,
      whenToTake: whenToTake,
      scheduledTime: scheduledTime,
      instruction: instruction,
      pillsRemaining: pillsRemaining,
      isTakenToday: isTakenToday ?? this.isTakenToday,
      cardType: cardType,
    );
  }
}

enum MedsCardType { featured, compact }
