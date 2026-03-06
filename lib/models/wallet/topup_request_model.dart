/// POST /wallet/topup/request response.
class TopupRequestModel {
  const TopupRequestModel({
    required this.requestId,
    required this.amount,
    required this.status,
    this.createdAt,
    this.message,
  });

  final String requestId;
  final num amount;
  final String status;
  final String? createdAt;
  final String? message;

  factory TopupRequestModel.fromJson(Map<String, dynamic> json) {
    return TopupRequestModel(
      requestId: json['requestId'] as String? ?? '',
      amount: (json['amount'] as num?) ?? 0,
      status: json['status'] as String? ?? 'PENDING',
      createdAt: json['createdAt'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'amount': amount,
      'status': status,
      if (createdAt != null) 'createdAt': createdAt,
      if (message != null) 'message': message,
    };
  }
}
