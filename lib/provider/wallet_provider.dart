import 'package:flutter/foundation.dart';

import 'package:wisecare_frontend/models/wallet/wallet_summary_model.dart';
import 'package:wisecare_frontend/models/wallet/wallet_transaction_model.dart';
import 'package:wisecare_frontend/repositories/wallet_repository.dart';

/// Wallet screen state. Holds summary, transactions, loading and error.
class WalletProvider extends ChangeNotifier {
  WalletProvider({WalletRepository? repository}) : _repository = repository ?? WalletRepository();

  final WalletRepository _repository;

  WalletSummaryModel? _summary;
  WalletSummaryModel? get summary => _summary;

  List<WalletTransactionModel> _transactions = [];
  List<WalletTransactionModel> get transactions => List.unmodifiable(_transactions);

  List<WalletTransactionModel> _historyTransactions = [];
  List<WalletTransactionModel> get historyTransactions =>
      List.unmodifiable(_historyTransactions);

  bool _historyHasMore = true;
  bool get historyHasMore => _historyHasMore;

  bool _historyLoadingMore = false;
  bool get historyLoadingMore => _historyLoadingMore;

  bool _historyInitialLoading = false;
  bool get historyInitialLoading => _historyInitialLoading;

  String? _historyError;
  String? get historyError => _historyError;

  static const int _historyPageSize = 20;

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
      _errorMessage = e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Requests a top-up (elderly). Returns success message to show, or null on error.
  Future<String?> requestTopup(int amount, String? message) async {
    if (_isTopupLoading || amount <= 0) return null;
    _isTopupLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final result = await _repository.requestTopup(amount: amount, message: message);
      await _silentRefresh();
      _errorMessage = null;
      return result.message ?? 'Top-up request sent to your family members.';
    } catch (e) {
      _errorMessage = e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString();
      return null;
    } finally {
      _isTopupLoading = false;
      notifyListeners();
    }
  }

  /// Loads first page of transaction history (for View All screen).
  Future<void> loadTransactionHistory() async {
    _historyTransactions = [];
    _historyHasMore = true;
    _historyError = null;
    _historyInitialLoading = true;
    notifyListeners();
    try {
      final response = await _repository.getTransactions(
        limit: _historyPageSize,
        offset: 0,
      );
      _historyTransactions = response.transactions;
      _historyHasMore = response.transactions.length >= _historyPageSize;
      _historyError = null;
    } catch (e) {
      _historyError = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      _historyInitialLoading = false;
      notifyListeners();
    }
  }

  /// Appends next page for infinite scroll. No-op if loading or no more data.
  Future<void> loadMoreTransactions() async {
    if (_historyLoadingMore || !_historyHasMore) return;
    _historyLoadingMore = true;
    _historyError = null;
    notifyListeners();
    try {
      final offset = _historyTransactions.length;
      final response = await _repository.getTransactions(
        limit: _historyPageSize,
        offset: offset,
      );
      _historyTransactions = [..._historyTransactions, ...response.transactions];
      _historyHasMore = response.transactions.length >= _historyPageSize;
      _historyError = null;
    } catch (e) {
      _historyError = e is Exception
          ? e.toString().replaceFirst('Exception: ', '')
          : e.toString();
    } finally {
      _historyLoadingMore = false;
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
