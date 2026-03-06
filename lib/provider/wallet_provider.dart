import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/models/wallet/wallet_summary_model.dart';
import 'package:wisecare_frontend/models/wallet/wallet_transaction_model.dart';
import 'package:wisecare_frontend/repositories/wallet_repository.dart';

/// Wallet screen state. Holds summary, transactions, loading and error.
class WalletProvider extends ChangeNotifier {
  WalletProvider({WalletRepository? repository})
      : _repository = repository ?? WalletRepository();

  final WalletRepository _repository;

  WalletSummaryModel? _summary;
  WalletSummaryModel? get summary => _summary;

  List<WalletTransactionModel> _transactions = [];
  List<WalletTransactionModel> get transactions => List.unmodifiable(_transactions);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isTopupLoading = false;
  bool get isTopupLoading => _isTopupLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// Loads wallet summary and transactions. Call when opening wallet screen.
  Future<void> loadWallet() async {
    _errorMessage = null;
    _isLoading = true;
    notifyListeners();
    try {
      final results = await Future.wait<dynamic>([
        _repository.getWalletSummary(),
        _repository.getTransactions(limit: 50),
      ]);
      _summary = results[0] as WalletSummaryModel;
      final txResponse = results[1] as WalletTransactionsResponseModel;
      _transactions = txResponse.transactions;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Requests a top-up (elderly). Then silently refreshes summary.
  Future<void> requestTopup(int amount, String? message) async {
    if (_isTopupLoading || amount <= 0) return;
    _isTopupLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await _repository.requestTopup(amount: amount, message: message);
      await _silentRefresh();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      _isTopupLoading = false;
      notifyListeners();
    }
  }

  /// Re-fetches summary and transactions without full-screen loading.
  Future<void> _silentRefresh() async {
    try {
      final summary = await _repository.getWalletSummary();
      final txResponse = await _repository.getTransactions(limit: 50);
      _summary = summary;
      _transactions = txResponse.transactions;
      notifyListeners();
    } catch (_) {
      // Swallow silently; user can pull or re-open to refresh.
    }
  }
}
