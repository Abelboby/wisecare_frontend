import 'package:dio/dio.dart';

import 'package:wisecare_frontend/models/wallet/topup_request_model.dart';
import 'package:wisecare_frontend/models/wallet/wallet_summary_model.dart';
import 'package:wisecare_frontend/models/wallet/wallet_transaction_model.dart';
import 'package:wisecare_frontend/network/dio_helper.dart';
import 'package:wisecare_frontend/network/endpoints.dart';

/// Wallet API service. Calls real backend endpoints.
/// Auth token is injected automatically by DioHelper's JwtInterceptor.
class WalletService {
  /// GET /wallet/summary — balance and limits (frontend format).
  Future<WalletSummaryModel> getWalletSummary() async {
    try {
      final response = await DioHelper.instance.get<Map<String, dynamic>>(
        Endpoints.walletSummary,
      );
      final data = response.data;
      if (data == null) throw Exception('Invalid response from server.');
      return WalletSummaryModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(_messageFromDioException(e));
    }
  }

  /// GET /wallet/transactions — transaction history. Use limit + offset for pagination.
  Future<WalletTransactionsResponseModel> getTransactions({
    int? limit,
    int? offset,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (limit != null) queryParams['limit'] = limit;
      if (offset != null) queryParams['offset'] = offset;
      final response = await DioHelper.instance.get<Map<String, dynamic>>(
        Endpoints.walletTransactions,
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
      );
      final data = response.data;
      if (data == null) throw Exception('Invalid response from server.');
      return WalletTransactionsResponseModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(_messageFromDioException(e));
    }
  }

  /// POST /wallet/topup/request — elderly request top-up.
  Future<TopupRequestModel> requestTopup({
    required int amount,
    String? message,
  }) async {
    try {
      final body = <String, dynamic>{'amount': amount};
      if (message != null && message.isNotEmpty) body['message'] = message;
      final response = await DioHelper.instance.post<Map<String, dynamic>>(
        Endpoints.walletTopupRequest,
        data: body,
        options: Options(contentType: Headers.jsonContentType),
      );
      final data = response.data;
      if (data == null) throw Exception('Invalid response from server.');
      return TopupRequestModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(_messageFromDioException(e));
    }
  }

  static String _messageFromDioException(DioException e) {
    final response = e.response;
    if (response?.data is Map<String, dynamic>) {
      final data = response!.data as Map<String, dynamic>;
      final msg = data['message'] as String?;
      if (msg != null && msg.isNotEmpty) return msg;
    }
    if (response?.statusCode != null) {
      if (response!.statusCode! == 400) return 'Invalid amount. Please try again.';
      if (response.statusCode! == 403) return 'You do not have permission to access this wallet.';
      if (response.statusCode! == 404) return 'Wallet not found.';
      if (response.statusCode! >= 500) return 'Server error. Please try again later.';
    }
    if (response == null || e.type == DioExceptionType.connectionError) {
      return 'Network error. Please check your connection.';
    }
    return e.message ?? 'Something went wrong. Please try again.';
  }
}
