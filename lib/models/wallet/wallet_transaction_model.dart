/// Single transaction from GET /wallet/transactions.
class WalletTransactionModel {
  const WalletTransactionModel({
    required this.transactionId,
    required this.type,
    required this.amount,
    required this.category,
    this.description,
    this.status,
    this.initiatorName,
    this.timestamp,
    this.userId,
    this.balanceBefore,
    this.balanceAfter,
    this.orderId,
    this.initiatedBy,
  });

  final String transactionId;
  final String type;
  final num amount;
  final String category;
  final String? description;
  final String? status;
  final String? initiatorName;
  final String? timestamp;
  final String? userId;
  final num? balanceBefore;
  final num? balanceAfter;
  final String? orderId;
  final String? initiatedBy;

  bool get isCredit => type.toUpperCase() == 'CREDIT';

  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      transactionId: json['transactionId'] as String? ?? '',
      type: json['type'] as String? ?? 'DEBIT',
      amount: (json['amount'] as num?) ?? 0,
      category: json['category'] as String? ?? 'OTHER',
      description: json['description'] as String?,
      status: json['status'] as String?,
      initiatorName: json['initiatorName'] as String?,
      timestamp: json['timestamp'] as String?,
      userId: json['userId'] as String?,
      balanceBefore: json['balanceBefore'] as num?,
      balanceAfter: json['balanceAfter'] as num?,
      orderId: json['orderId'] as String?,
      initiatedBy: json['initiatedBy'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'type': type,
      'amount': amount,
      'category': category,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (initiatorName != null) 'initiatorName': initiatorName,
      if (timestamp != null) 'timestamp': timestamp,
      if (userId != null) 'userId': userId,
      if (balanceBefore != null) 'balanceBefore': balanceBefore,
      if (balanceAfter != null) 'balanceAfter': balanceAfter,
      if (orderId != null) 'orderId': orderId,
      if (initiatedBy != null) 'initiatedBy': initiatedBy,
    };
  }
}

/// GET /wallet/transactions response wrapper.
class WalletTransactionsResponseModel {
  const WalletTransactionsResponseModel({
    required this.transactions,
    required this.count,
    this.summary,
  });

  final List<WalletTransactionModel> transactions;
  final int count;
  final WalletTransactionsSummaryModel? summary;

  factory WalletTransactionsResponseModel.fromJson(Map<String, dynamic> json) {
    final list = json['transactions'];
    final txList = list is List
        ? (list)
            .map((e) => WalletTransactionModel.fromJson(
                e is Map<String, dynamic> ? e : Map<String, dynamic>.from(e as Map)))
            .toList()
        : <WalletTransactionModel>[];
    final summaryMap = json['summary'];
    return WalletTransactionsResponseModel(
      transactions: txList,
      count: (json['count'] as num?)?.toInt() ?? txList.length,
      summary: summaryMap is Map<String, dynamic>
          ? WalletTransactionsSummaryModel.fromJson(summaryMap)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactions': transactions.map((t) => t.toJson()).toList(),
      'count': count,
      if (summary != null) 'summary': summary!.toJson(),
    };
  }
}

/// Optional summary in transactions response.
class WalletTransactionsSummaryModel {
  const WalletTransactionsSummaryModel({
    this.totalSpent,
    this.totalTopUps,
    this.netBalance,
  });

  final num? totalSpent;
  final num? totalTopUps;
  final num? netBalance;

  factory WalletTransactionsSummaryModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionsSummaryModel(
      totalSpent: json['totalSpent'] as num?,
      totalTopUps: json['totalTopUps'] as num?,
      netBalance: json['netBalance'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (totalSpent != null) 'totalSpent': totalSpent,
      if (totalTopUps != null) 'totalTopUps': totalTopUps,
      if (netBalance != null) 'netBalance': netBalance,
    };
  }
}
