import 'package:wisecare_frontend/models/wallet/topup_request_model.dart';
import 'package:wisecare_frontend/models/wallet/wallet_summary_model.dart';
import 'package:wisecare_frontend/models/wallet/wallet_transaction_model.dart';
import 'package:wisecare_frontend/services/wallet_service.dart';

/// Wallet data orchestration. Only this layer talks to WalletService.
class WalletRepository {
  WalletRepository({WalletService? walletService})
      : _walletService = walletService ?? WalletService();

  final WalletService _walletService;

  Future<WalletSummaryModel> getWalletSummary() async {
    return _walletService.getWalletSummary();
  }

  Future<WalletTransactionsResponseModel> getTransactions({int? limit}) async {
    return _walletService.getTransactions(limit: limit);
  }

  Future<TopupRequestModel> requestTopup({
    required int amount,
    String? message,
  }) async {
    return _walletService.requestTopup(amount: amount, message: message);
  }
}
