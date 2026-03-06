/// Nested limit object for daily/monthly spending (GET /wallet/summary).
class WalletLimitModel {
  const WalletLimitModel({
    required this.limit,
    required this.spent,
    required this.remaining,
  });

  final int limit;
  final int spent;
  final int remaining;

  factory WalletLimitModel.fromJson(Map<String, dynamic> json) {
    return WalletLimitModel(
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      spent: (json['spent'] as num?)?.toInt() ?? 0,
      remaining: (json['remaining'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'spent': spent,
      'remaining': remaining,
    };
  }
}
