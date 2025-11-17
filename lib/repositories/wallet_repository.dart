import '../../core/network/api_client.dart';
import '../../models/wallet_models.dart';

/// Wallet Repository
class WalletRepository {
  final ApiClient _apiClient;

  WalletRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  /// Get user's wallet balance
  Future<Wallet> getBalance() async {
    try {
      final response = await _apiClient.get('/wallet/balance');
      return Wallet.fromJson(response.data['wallet'] as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Get available credit packages
  Future<List<CreditPackage>> getPackages() async {
    try {
      final response = await _apiClient.get('/wallet/packages');
      final List<dynamic> packages = response.data['packages'];
      return packages
          .map((json) => CreditPackage.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Purchase credits
  Future<PurchaseResponse> purchaseCredits({
    required String packageId,
    required String paymentMethod,
    required String paymentToken,
  }) async {
    try {
      final response = await _apiClient.post(
        '/wallet/purchase',
        data: PurchaseRequest(
          packageId: packageId,
          paymentMethod: paymentMethod,
          paymentToken: paymentToken,
        ).toJson(),
      );

      return PurchaseResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Get transaction history
  Future<TransactionsResponse> getTransactions({
    int page = 1,
    int limit = 20,
    String type = 'all',
  }) async {
    try {
      final response = await _apiClient.get(
        '/wallet/transactions',
        queryParameters: {'page': page, 'limit': limit, 'type': type},
      );

      return TransactionsResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      rethrow;
    }
  }
}
