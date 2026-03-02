/// Response from POST /companion/chat.
class ChatResponseModel {
  const ChatResponseModel({
    required this.reply,
    required this.healthFlagged,
    required this.serviceRequestCreated,
    this.serviceRequestId,
    this.serviceRequestType,
    this.serviceRequestTitle,
    this.sessionId,
  });

  final String reply;
  final bool healthFlagged;
  final bool serviceRequestCreated;
  final String? serviceRequestId;
  final String? serviceRequestType;
  final String? serviceRequestTitle;
  final String? sessionId;

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      reply: json['reply'] as String? ?? '',
      healthFlagged: json['healthFlagged'] as bool? ?? false,
      serviceRequestCreated: json['serviceRequestCreated'] as bool? ?? false,
      serviceRequestId: json['serviceRequestId'] as String?,
      serviceRequestType: json['serviceRequestType'] as String?,
      serviceRequestTitle: json['serviceRequestTitle'] as String?,
      sessionId: json['sessionId'] as String?,
    );
  }
}
