// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletImpl _$$WalletImplFromJson(Map<String, dynamic> json) => _$WalletImpl(
  userId: json['userId'] as String,
  balance: (json['balance'] as num).toDouble(),
  lifetimeSpent: (json['lifetimeSpent'] as num).toDouble(),
  lifetimeEarned: (json['lifetimeEarned'] as num).toDouble(),
  lastUpdated: json['lastUpdated'] == null
      ? null
      : DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$$WalletImplToJson(_$WalletImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'balance': instance.balance,
      'lifetimeSpent': instance.lifetimeSpent,
      'lifetimeEarned': instance.lifetimeEarned,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
    };

_$CreditPackageImpl _$$CreditPackageImplFromJson(Map<String, dynamic> json) =>
    _$CreditPackageImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      credits: (json['credits'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      bonus: (json['bonus'] as num?)?.toDouble(),
      isPopular: json['isPopular'] as bool?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$CreditPackageImplToJson(_$CreditPackageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'credits': instance.credits,
      'price': instance.price,
      'currency': instance.currency,
      'bonus': instance.bonus,
      'isPopular': instance.isPopular,
      'description': instance.description,
    };

_$PurchaseRequestImpl _$$PurchaseRequestImplFromJson(
  Map<String, dynamic> json,
) => _$PurchaseRequestImpl(
  packageId: json['packageId'] as String,
  paymentMethod: json['paymentMethod'] as String,
  paymentToken: json['paymentToken'] as String,
);

Map<String, dynamic> _$$PurchaseRequestImplToJson(
  _$PurchaseRequestImpl instance,
) => <String, dynamic>{
  'packageId': instance.packageId,
  'paymentMethod': instance.paymentMethod,
  'paymentToken': instance.paymentToken,
};

_$PurchaseResponseImpl _$$PurchaseResponseImplFromJson(
  Map<String, dynamic> json,
) => _$PurchaseResponseImpl(
  success: json['success'] as bool,
  message: json['message'] as String,
  transactionId: json['transactionId'] as String,
  creditsAdded: (json['creditsAdded'] as num).toDouble(),
  newBalance: (json['newBalance'] as num).toDouble(),
);

Map<String, dynamic> _$$PurchaseResponseImplToJson(
  _$PurchaseResponseImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'transactionId': instance.transactionId,
  'creditsAdded': instance.creditsAdded,
  'newBalance': instance.newBalance,
};

_$TransactionImpl _$$TransactionImplFromJson(Map<String, dynamic> json) =>
    _$TransactionImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      balanceBefore: (json['balanceBefore'] as num).toDouble(),
      balanceAfter: (json['balanceAfter'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String?,
      referenceId: json['referenceId'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': instance.type,
      'amount': instance.amount,
      'balanceBefore': instance.balanceBefore,
      'balanceAfter': instance.balanceAfter,
      'createdAt': instance.createdAt.toIso8601String(),
      'description': instance.description,
      'referenceId': instance.referenceId,
      'status': instance.status,
    };

_$TransactionsResponseImpl _$$TransactionsResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TransactionsResponseImpl(
  transactions: (json['transactions'] as List<dynamic>)
      .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
      .toList(),
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
);

Map<String, dynamic> _$$TransactionsResponseImplToJson(
  _$TransactionsResponseImpl instance,
) => <String, dynamic>{
  'transactions': instance.transactions,
  'total': instance.total,
  'page': instance.page,
  'limit': instance.limit,
  'totalPages': instance.totalPages,
};
