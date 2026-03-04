/// Response from POST /sos.
class SosResponseModel {
  const SosResponseModel({
    required this.success,
    required this.requestId,
    required this.alertId,
    required this.message,
    required this.timestamp,
  });

  final bool success;

  /// ID of the ServiceRequest created — use immediately to start polling
  final String requestId;

  /// ID of the Alert created — visible via GET /alerts/user/{userId}.
  final String alertId;

  final String message;

  /// UTC ISO-8601 timestamp of when the SOS was triggered.
  final String timestamp;

  factory SosResponseModel.fromJson(Map<String, dynamic> json) {
    return SosResponseModel(
      success: json['success'] as bool? ?? false,
      requestId: json['requestId'] as String? ?? '',
      alertId: json['alertId'] as String? ?? '',
      message: json['message'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
    );
  }
}
