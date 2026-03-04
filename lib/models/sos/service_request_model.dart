/// One item from GET /service-requests `requests` array.
class ServiceRequestModel {
  const ServiceRequestModel({
    required this.requestId,
    required this.status,
    required this.requestType,
    required this.category,
    required this.title,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
    this.elderlyUserId,
    this.elderlyName,
    this.elderlyCity,
    this.elderlyAddress,
    this.description,
    this.rawMessage,
    this.assignedAgentId,
    this.assignedAgentName,
    this.assignedAt,
    this.agentNotes,
    this.completedAt,
    this.sessionId,
  });

  final String requestId;
  final String status;
  final String requestType;
  final String category;
  final String title;
  final String priority;
  final String createdAt;
  final String updatedAt;

  final String? elderlyUserId;
  final String? elderlyName;
  final String? elderlyCity;
  final String? elderlyAddress;
  final String? description;
  final String? rawMessage;
  final String? assignedAgentId;
  final String? assignedAgentName;
  final String? assignedAt;
  final String? agentNotes;
  final String? completedAt;
  final String? sessionId;

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return ServiceRequestModel(
      requestId: json['requestId'] as String? ?? '',
      status: json['status'] as String? ?? statusPending,
      requestType: json['requestType'] as String? ?? '',
      category: json['category'] as String? ?? '',
      title: json['title'] as String? ?? '',
      priority: json['priority'] as String? ?? 'NORMAL',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      elderlyUserId: json['elderlyUserId'] as String?,
      elderlyName: json['elderlyName'] as String?,
      elderlyCity: json['elderlyCity'] as String?,
      elderlyAddress: json['elderlyAddress'] as String?,
      description: json['description'] as String?,
      rawMessage: json['rawMessage'] as String?,
      assignedAgentId: json['assignedAgentId'] as String?,
      assignedAgentName: json['assignedAgentName'] as String?,
      assignedAt: json['assignedAt'] as String?,
      agentNotes: json['agentNotes'] as String?,
      completedAt: json['completedAt'] as String?,
      sessionId: json['sessionId'] as String?,
    );
  }

  // ── Status constants ───────────────────────────────────────────────────────
  static const String statusPending = 'PENDING';
  static const String statusAssigned = 'ASSIGNED';
  static const String statusAccepted = 'ACCEPTED';
  static const String statusRejected = 'REJECTED';
  static const String statusInProgress = 'IN_PROGRESS';
  static const String statusCompleted = 'COMPLETED';
}
