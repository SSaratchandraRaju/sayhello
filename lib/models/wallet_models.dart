import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_models.freezed.dart';
part 'wallet_models.g.dart';

/// Wallet Model
@freezed
class Wallet with _$Wallet {
  const factory Wallet({
    required String userId,
    required double balance,
    required double lifetimeSpent,
    required double lifetimeEarned,
    DateTime? lastUpdated,
  }) = _Wallet;

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
}

/// Credit Package Model
@freezed
class CreditPackage with _$CreditPackage {
  const factory CreditPackage({
    required String id,
    required String name,
    required double credits,
    required double price,
    required String currency,
    double? bonus,
    bool? isPopular,
    String? description,
  }) = _CreditPackage;

  factory CreditPackage.fromJson(Map<String, dynamic> json) =>
      _$CreditPackageFromJson(json);
}

/// Purchase Request Model
@freezed
class PurchaseRequest with _$PurchaseRequest {
  const factory PurchaseRequest({
    required String packageId,
    required String paymentMethod,
    required String paymentToken,
  }) = _PurchaseRequest;

  factory PurchaseRequest.fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestFromJson(json);
}

/// Purchase Response Model
@freezed
class PurchaseResponse with _$PurchaseResponse {
  const factory PurchaseResponse({
    required bool success,
    required String message,
    required String transactionId,
    required double creditsAdded,
    required double newBalance,
  }) = _PurchaseResponse;

  factory PurchaseResponse.fromJson(Map<String, dynamic> json) =>
      _$PurchaseResponseFromJson(json);
}

/// Transaction Model
@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required String userId,
    required String type,
    required double amount,
    required double balanceBefore,
    required double balanceAfter,
    required DateTime createdAt,
    String? description,
    String? referenceId,
    String? status,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}

/// Transactions List Response Model
@freezed
class TransactionsResponse with _$TransactionsResponse {
  const factory TransactionsResponse({
    required List<Transaction> transactions,
    required int total,
    required int page,
    required int limit,
    required int totalPages,
  }) = _TransactionsResponse;

  factory TransactionsResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionsResponseFromJson(json);
}
