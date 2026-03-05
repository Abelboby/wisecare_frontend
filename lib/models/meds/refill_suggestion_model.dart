/// Suggestion to refill a medication (low stock or recurring).
class RefillSuggestionModel {
  const RefillSuggestionModel({
    required this.medicationId,
    required this.medicationName,
  });

  final String medicationId;
  final String medicationName;

  factory RefillSuggestionModel.fromJson(Map<String, dynamic> json) {
    return RefillSuggestionModel(
      medicationId: json['medicationId'] as String? ?? '',
      medicationName: json['medicationName'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'medicationId': medicationId,
      'medicationName': medicationName,
    };
  }
}
