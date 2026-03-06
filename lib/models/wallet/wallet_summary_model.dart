import 'package:wisecare_frontend/models/wallet/wallet_limit_model.dart';

/// GET /wallet/summary response (balance + limits).
class WalletSummaryModel {
  const WalletSummaryModel({
    required this.balance,
    required this.currency,
    required this.dailyLimit,
    required this.monthlyLimit,
    this.accountLabel,
  });

  final num balance;
  final String currency;
  final WalletLimitModel dailyLimit;
  final WalletLimitModel monthlyLimit;
  final String? accountLabel;

  factory WalletSummaryModel.fromJson(Map<String, dynamic> json) {
    final limits = json['limits'] as Map<String, dynamic>?;
    final daily = limits?['daily'];
    final monthly = limits?['monthly'];
    return WalletSummaryModel(
      balance: (json['balance'] as num?) ?? 0,
      currency: json['currency'] as String? ?? 'INR',
      dailyLimit: daily is Map<String, dynamic>
          ? WalletLimitModel.fromJson(daily)
          : const WalletLimitModel(limit: 0, spent: 0, remaining: 0),
      monthlyLimit: monthly is Map<String, dynamic>
          ? WalletLimitModel.fromJson(monthly)
          : const WalletLimitModel(limit: 0, spent: 0, remaining: 0),
      accountLabel: json['accountLabel'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'currency': currency,
      'limits': {
        'daily': dailyLimit.toJson(),
        'monthly': monthlyLimit.toJson(),
      },
      if (accountLabel != null) 'accountLabel': accountLabel,
    };
  }
}
