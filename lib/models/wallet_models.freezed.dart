// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Wallet _$WalletFromJson(Map<String, dynamic> json) {
  return _Wallet.fromJson(json);
}

/// @nodoc
mixin _$Wallet {
  String get userId => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  double get lifetimeSpent => throw _privateConstructorUsedError;
  double get lifetimeEarned => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this Wallet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletCopyWith<Wallet> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletCopyWith<$Res> {
  factory $WalletCopyWith(Wallet value, $Res Function(Wallet) then) =
      _$WalletCopyWithImpl<$Res, Wallet>;
  @useResult
  $Res call({
    String userId,
    double balance,
    double lifetimeSpent,
    double lifetimeEarned,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class _$WalletCopyWithImpl<$Res, $Val extends Wallet>
    implements $WalletCopyWith<$Res> {
  _$WalletCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? balance = null,
    Object? lifetimeSpent = null,
    Object? lifetimeEarned = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            balance: null == balance
                ? _value.balance
                : balance // ignore: cast_nullable_to_non_nullable
                      as double,
            lifetimeSpent: null == lifetimeSpent
                ? _value.lifetimeSpent
                : lifetimeSpent // ignore: cast_nullable_to_non_nullable
                      as double,
            lifetimeEarned: null == lifetimeEarned
                ? _value.lifetimeEarned
                : lifetimeEarned // ignore: cast_nullable_to_non_nullable
                      as double,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WalletImplCopyWith<$Res> implements $WalletCopyWith<$Res> {
  factory _$$WalletImplCopyWith(
    _$WalletImpl value,
    $Res Function(_$WalletImpl) then,
  ) = __$$WalletImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    double balance,
    double lifetimeSpent,
    double lifetimeEarned,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class __$$WalletImplCopyWithImpl<$Res>
    extends _$WalletCopyWithImpl<$Res, _$WalletImpl>
    implements _$$WalletImplCopyWith<$Res> {
  __$$WalletImplCopyWithImpl(
    _$WalletImpl _value,
    $Res Function(_$WalletImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? balance = null,
    Object? lifetimeSpent = null,
    Object? lifetimeEarned = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _$WalletImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as double,
        lifetimeSpent: null == lifetimeSpent
            ? _value.lifetimeSpent
            : lifetimeSpent // ignore: cast_nullable_to_non_nullable
                  as double,
        lifetimeEarned: null == lifetimeEarned
            ? _value.lifetimeEarned
            : lifetimeEarned // ignore: cast_nullable_to_non_nullable
                  as double,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WalletImpl implements _Wallet {
  const _$WalletImpl({
    required this.userId,
    required this.balance,
    required this.lifetimeSpent,
    required this.lifetimeEarned,
    this.lastUpdated,
  });

  factory _$WalletImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletImplFromJson(json);

  @override
  final String userId;
  @override
  final double balance;
  @override
  final double lifetimeSpent;
  @override
  final double lifetimeEarned;
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'Wallet(userId: $userId, balance: $balance, lifetimeSpent: $lifetimeSpent, lifetimeEarned: $lifetimeEarned, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WalletImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.lifetimeSpent, lifetimeSpent) ||
                other.lifetimeSpent == lifetimeSpent) &&
            (identical(other.lifetimeEarned, lifetimeEarned) ||
                other.lifetimeEarned == lifetimeEarned) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    balance,
    lifetimeSpent,
    lifetimeEarned,
    lastUpdated,
  );

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WalletImplCopyWith<_$WalletImpl> get copyWith =>
      __$$WalletImplCopyWithImpl<_$WalletImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletImplToJson(this);
  }
}

abstract class _Wallet implements Wallet {
  const factory _Wallet({
    required final String userId,
    required final double balance,
    required final double lifetimeSpent,
    required final double lifetimeEarned,
    final DateTime? lastUpdated,
  }) = _$WalletImpl;

  factory _Wallet.fromJson(Map<String, dynamic> json) = _$WalletImpl.fromJson;

  @override
  String get userId;
  @override
  double get balance;
  @override
  double get lifetimeSpent;
  @override
  double get lifetimeEarned;
  @override
  DateTime? get lastUpdated;

  /// Create a copy of Wallet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WalletImplCopyWith<_$WalletImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreditPackage _$CreditPackageFromJson(Map<String, dynamic> json) {
  return _CreditPackage.fromJson(json);
}

/// @nodoc
mixin _$CreditPackage {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get credits => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  double? get bonus => throw _privateConstructorUsedError;
  bool? get isPopular => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this CreditPackage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreditPackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreditPackageCopyWith<CreditPackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreditPackageCopyWith<$Res> {
  factory $CreditPackageCopyWith(
    CreditPackage value,
    $Res Function(CreditPackage) then,
  ) = _$CreditPackageCopyWithImpl<$Res, CreditPackage>;
  @useResult
  $Res call({
    String id,
    String name,
    double credits,
    double price,
    String currency,
    double? bonus,
    bool? isPopular,
    String? description,
  });
}

/// @nodoc
class _$CreditPackageCopyWithImpl<$Res, $Val extends CreditPackage>
    implements $CreditPackageCopyWith<$Res> {
  _$CreditPackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreditPackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? credits = null,
    Object? price = null,
    Object? currency = null,
    Object? bonus = freezed,
    Object? isPopular = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            credits: null == credits
                ? _value.credits
                : credits // ignore: cast_nullable_to_non_nullable
                      as double,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            bonus: freezed == bonus
                ? _value.bonus
                : bonus // ignore: cast_nullable_to_non_nullable
                      as double?,
            isPopular: freezed == isPopular
                ? _value.isPopular
                : isPopular // ignore: cast_nullable_to_non_nullable
                      as bool?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreditPackageImplCopyWith<$Res>
    implements $CreditPackageCopyWith<$Res> {
  factory _$$CreditPackageImplCopyWith(
    _$CreditPackageImpl value,
    $Res Function(_$CreditPackageImpl) then,
  ) = __$$CreditPackageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    double credits,
    double price,
    String currency,
    double? bonus,
    bool? isPopular,
    String? description,
  });
}

/// @nodoc
class __$$CreditPackageImplCopyWithImpl<$Res>
    extends _$CreditPackageCopyWithImpl<$Res, _$CreditPackageImpl>
    implements _$$CreditPackageImplCopyWith<$Res> {
  __$$CreditPackageImplCopyWithImpl(
    _$CreditPackageImpl _value,
    $Res Function(_$CreditPackageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreditPackage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? credits = null,
    Object? price = null,
    Object? currency = null,
    Object? bonus = freezed,
    Object? isPopular = freezed,
    Object? description = freezed,
  }) {
    return _then(
      _$CreditPackageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        credits: null == credits
            ? _value.credits
            : credits // ignore: cast_nullable_to_non_nullable
                  as double,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        bonus: freezed == bonus
            ? _value.bonus
            : bonus // ignore: cast_nullable_to_non_nullable
                  as double?,
        isPopular: freezed == isPopular
            ? _value.isPopular
            : isPopular // ignore: cast_nullable_to_non_nullable
                  as bool?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreditPackageImpl implements _CreditPackage {
  const _$CreditPackageImpl({
    required this.id,
    required this.name,
    required this.credits,
    required this.price,
    required this.currency,
    this.bonus,
    this.isPopular,
    this.description,
  });

  factory _$CreditPackageImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreditPackageImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double credits;
  @override
  final double price;
  @override
  final String currency;
  @override
  final double? bonus;
  @override
  final bool? isPopular;
  @override
  final String? description;

  @override
  String toString() {
    return 'CreditPackage(id: $id, name: $name, credits: $credits, price: $price, currency: $currency, bonus: $bonus, isPopular: $isPopular, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreditPackageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.credits, credits) || other.credits == credits) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.bonus, bonus) || other.bonus == bonus) &&
            (identical(other.isPopular, isPopular) ||
                other.isPopular == isPopular) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    credits,
    price,
    currency,
    bonus,
    isPopular,
    description,
  );

  /// Create a copy of CreditPackage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreditPackageImplCopyWith<_$CreditPackageImpl> get copyWith =>
      __$$CreditPackageImplCopyWithImpl<_$CreditPackageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreditPackageImplToJson(this);
  }
}

abstract class _CreditPackage implements CreditPackage {
  const factory _CreditPackage({
    required final String id,
    required final String name,
    required final double credits,
    required final double price,
    required final String currency,
    final double? bonus,
    final bool? isPopular,
    final String? description,
  }) = _$CreditPackageImpl;

  factory _CreditPackage.fromJson(Map<String, dynamic> json) =
      _$CreditPackageImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get credits;
  @override
  double get price;
  @override
  String get currency;
  @override
  double? get bonus;
  @override
  bool? get isPopular;
  @override
  String? get description;

  /// Create a copy of CreditPackage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreditPackageImplCopyWith<_$CreditPackageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchaseRequest _$PurchaseRequestFromJson(Map<String, dynamic> json) {
  return _PurchaseRequest.fromJson(json);
}

/// @nodoc
mixin _$PurchaseRequest {
  String get packageId => throw _privateConstructorUsedError;
  String get paymentMethod => throw _privateConstructorUsedError;
  String get paymentToken => throw _privateConstructorUsedError;

  /// Serializes this PurchaseRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseRequestCopyWith<PurchaseRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseRequestCopyWith<$Res> {
  factory $PurchaseRequestCopyWith(
    PurchaseRequest value,
    $Res Function(PurchaseRequest) then,
  ) = _$PurchaseRequestCopyWithImpl<$Res, PurchaseRequest>;
  @useResult
  $Res call({String packageId, String paymentMethod, String paymentToken});
}

/// @nodoc
class _$PurchaseRequestCopyWithImpl<$Res, $Val extends PurchaseRequest>
    implements $PurchaseRequestCopyWith<$Res> {
  _$PurchaseRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageId = null,
    Object? paymentMethod = null,
    Object? paymentToken = null,
  }) {
    return _then(
      _value.copyWith(
            packageId: null == packageId
                ? _value.packageId
                : packageId // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentToken: null == paymentToken
                ? _value.paymentToken
                : paymentToken // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PurchaseRequestImplCopyWith<$Res>
    implements $PurchaseRequestCopyWith<$Res> {
  factory _$$PurchaseRequestImplCopyWith(
    _$PurchaseRequestImpl value,
    $Res Function(_$PurchaseRequestImpl) then,
  ) = __$$PurchaseRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String packageId, String paymentMethod, String paymentToken});
}

/// @nodoc
class __$$PurchaseRequestImplCopyWithImpl<$Res>
    extends _$PurchaseRequestCopyWithImpl<$Res, _$PurchaseRequestImpl>
    implements _$$PurchaseRequestImplCopyWith<$Res> {
  __$$PurchaseRequestImplCopyWithImpl(
    _$PurchaseRequestImpl _value,
    $Res Function(_$PurchaseRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageId = null,
    Object? paymentMethod = null,
    Object? paymentToken = null,
  }) {
    return _then(
      _$PurchaseRequestImpl(
        packageId: null == packageId
            ? _value.packageId
            : packageId // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentToken: null == paymentToken
            ? _value.paymentToken
            : paymentToken // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseRequestImpl implements _PurchaseRequest {
  const _$PurchaseRequestImpl({
    required this.packageId,
    required this.paymentMethod,
    required this.paymentToken,
  });

  factory _$PurchaseRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseRequestImplFromJson(json);

  @override
  final String packageId;
  @override
  final String paymentMethod;
  @override
  final String paymentToken;

  @override
  String toString() {
    return 'PurchaseRequest(packageId: $packageId, paymentMethod: $paymentMethod, paymentToken: $paymentToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseRequestImpl &&
            (identical(other.packageId, packageId) ||
                other.packageId == packageId) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentToken, paymentToken) ||
                other.paymentToken == paymentToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, packageId, paymentMethod, paymentToken);

  /// Create a copy of PurchaseRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseRequestImplCopyWith<_$PurchaseRequestImpl> get copyWith =>
      __$$PurchaseRequestImplCopyWithImpl<_$PurchaseRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseRequestImplToJson(this);
  }
}

abstract class _PurchaseRequest implements PurchaseRequest {
  const factory _PurchaseRequest({
    required final String packageId,
    required final String paymentMethod,
    required final String paymentToken,
  }) = _$PurchaseRequestImpl;

  factory _PurchaseRequest.fromJson(Map<String, dynamic> json) =
      _$PurchaseRequestImpl.fromJson;

  @override
  String get packageId;
  @override
  String get paymentMethod;
  @override
  String get paymentToken;

  /// Create a copy of PurchaseRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseRequestImplCopyWith<_$PurchaseRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchaseResponse _$PurchaseResponseFromJson(Map<String, dynamic> json) {
  return _PurchaseResponse.fromJson(json);
}

/// @nodoc
mixin _$PurchaseResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get transactionId => throw _privateConstructorUsedError;
  double get creditsAdded => throw _privateConstructorUsedError;
  double get newBalance => throw _privateConstructorUsedError;

  /// Serializes this PurchaseResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PurchaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PurchaseResponseCopyWith<PurchaseResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseResponseCopyWith<$Res> {
  factory $PurchaseResponseCopyWith(
    PurchaseResponse value,
    $Res Function(PurchaseResponse) then,
  ) = _$PurchaseResponseCopyWithImpl<$Res, PurchaseResponse>;
  @useResult
  $Res call({
    bool success,
    String message,
    String transactionId,
    double creditsAdded,
    double newBalance,
  });
}

/// @nodoc
class _$PurchaseResponseCopyWithImpl<$Res, $Val extends PurchaseResponse>
    implements $PurchaseResponseCopyWith<$Res> {
  _$PurchaseResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PurchaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? transactionId = null,
    Object? creditsAdded = null,
    Object? newBalance = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            transactionId: null == transactionId
                ? _value.transactionId
                : transactionId // ignore: cast_nullable_to_non_nullable
                      as String,
            creditsAdded: null == creditsAdded
                ? _value.creditsAdded
                : creditsAdded // ignore: cast_nullable_to_non_nullable
                      as double,
            newBalance: null == newBalance
                ? _value.newBalance
                : newBalance // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PurchaseResponseImplCopyWith<$Res>
    implements $PurchaseResponseCopyWith<$Res> {
  factory _$$PurchaseResponseImplCopyWith(
    _$PurchaseResponseImpl value,
    $Res Function(_$PurchaseResponseImpl) then,
  ) = __$$PurchaseResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    String message,
    String transactionId,
    double creditsAdded,
    double newBalance,
  });
}

/// @nodoc
class __$$PurchaseResponseImplCopyWithImpl<$Res>
    extends _$PurchaseResponseCopyWithImpl<$Res, _$PurchaseResponseImpl>
    implements _$$PurchaseResponseImplCopyWith<$Res> {
  __$$PurchaseResponseImplCopyWithImpl(
    _$PurchaseResponseImpl _value,
    $Res Function(_$PurchaseResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PurchaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
    Object? transactionId = null,
    Object? creditsAdded = null,
    Object? newBalance = null,
  }) {
    return _then(
      _$PurchaseResponseImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        transactionId: null == transactionId
            ? _value.transactionId
            : transactionId // ignore: cast_nullable_to_non_nullable
                  as String,
        creditsAdded: null == creditsAdded
            ? _value.creditsAdded
            : creditsAdded // ignore: cast_nullable_to_non_nullable
                  as double,
        newBalance: null == newBalance
            ? _value.newBalance
            : newBalance // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseResponseImpl implements _PurchaseResponse {
  const _$PurchaseResponseImpl({
    required this.success,
    required this.message,
    required this.transactionId,
    required this.creditsAdded,
    required this.newBalance,
  });

  factory _$PurchaseResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseResponseImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;
  @override
  final String transactionId;
  @override
  final double creditsAdded;
  @override
  final double newBalance;

  @override
  String toString() {
    return 'PurchaseResponse(success: $success, message: $message, transactionId: $transactionId, creditsAdded: $creditsAdded, newBalance: $newBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.creditsAdded, creditsAdded) ||
                other.creditsAdded == creditsAdded) &&
            (identical(other.newBalance, newBalance) ||
                other.newBalance == newBalance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    message,
    transactionId,
    creditsAdded,
    newBalance,
  );

  /// Create a copy of PurchaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseResponseImplCopyWith<_$PurchaseResponseImpl> get copyWith =>
      __$$PurchaseResponseImplCopyWithImpl<_$PurchaseResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseResponseImplToJson(this);
  }
}

abstract class _PurchaseResponse implements PurchaseResponse {
  const factory _PurchaseResponse({
    required final bool success,
    required final String message,
    required final String transactionId,
    required final double creditsAdded,
    required final double newBalance,
  }) = _$PurchaseResponseImpl;

  factory _PurchaseResponse.fromJson(Map<String, dynamic> json) =
      _$PurchaseResponseImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  String get transactionId;
  @override
  double get creditsAdded;
  @override
  double get newBalance;

  /// Create a copy of PurchaseResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PurchaseResponseImplCopyWith<_$PurchaseResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get balanceBefore => throw _privateConstructorUsedError;
  double get balanceAfter => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get referenceId => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
    Transaction value,
    $Res Function(Transaction) then,
  ) = _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call({
    String id,
    String userId,
    String type,
    double amount,
    double balanceBefore,
    double balanceAfter,
    DateTime createdAt,
    String? description,
    String? referenceId,
    String? status,
  });
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? amount = null,
    Object? balanceBefore = null,
    Object? balanceAfter = null,
    Object? createdAt = null,
    Object? description = freezed,
    Object? referenceId = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            balanceBefore: null == balanceBefore
                ? _value.balanceBefore
                : balanceBefore // ignore: cast_nullable_to_non_nullable
                      as double,
            balanceAfter: null == balanceAfter
                ? _value.balanceAfter
                : balanceAfter // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            referenceId: freezed == referenceId
                ? _value.referenceId
                : referenceId // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
    _$TransactionImpl value,
    $Res Function(_$TransactionImpl) then,
  ) = __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String type,
    double amount,
    double balanceBefore,
    double balanceAfter,
    DateTime createdAt,
    String? description,
    String? referenceId,
    String? status,
  });
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
    _$TransactionImpl _value,
    $Res Function(_$TransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? amount = null,
    Object? balanceBefore = null,
    Object? balanceAfter = null,
    Object? createdAt = null,
    Object? description = freezed,
    Object? referenceId = freezed,
    Object? status = freezed,
  }) {
    return _then(
      _$TransactionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        balanceBefore: null == balanceBefore
            ? _value.balanceBefore
            : balanceBefore // ignore: cast_nullable_to_non_nullable
                  as double,
        balanceAfter: null == balanceAfter
            ? _value.balanceAfter
            : balanceAfter // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        referenceId: freezed == referenceId
            ? _value.referenceId
            : referenceId // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionImpl implements _Transaction {
  const _$TransactionImpl({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.balanceBefore,
    required this.balanceAfter,
    required this.createdAt,
    this.description,
    this.referenceId,
    this.status,
  });

  factory _$TransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String type;
  @override
  final double amount;
  @override
  final double balanceBefore;
  @override
  final double balanceAfter;
  @override
  final DateTime createdAt;
  @override
  final String? description;
  @override
  final String? referenceId;
  @override
  final String? status;

  @override
  String toString() {
    return 'Transaction(id: $id, userId: $userId, type: $type, amount: $amount, balanceBefore: $balanceBefore, balanceAfter: $balanceAfter, createdAt: $createdAt, description: $description, referenceId: $referenceId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.balanceBefore, balanceBefore) ||
                other.balanceBefore == balanceBefore) &&
            (identical(other.balanceAfter, balanceAfter) ||
                other.balanceAfter == balanceAfter) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    type,
    amount,
    balanceBefore,
    balanceAfter,
    createdAt,
    description,
    referenceId,
    status,
  );

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionImplToJson(this);
  }
}

abstract class _Transaction implements Transaction {
  const factory _Transaction({
    required final String id,
    required final String userId,
    required final String type,
    required final double amount,
    required final double balanceBefore,
    required final double balanceAfter,
    required final DateTime createdAt,
    final String? description,
    final String? referenceId,
    final String? status,
  }) = _$TransactionImpl;

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$TransactionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get type;
  @override
  double get amount;
  @override
  double get balanceBefore;
  @override
  double get balanceAfter;
  @override
  DateTime get createdAt;
  @override
  String? get description;
  @override
  String? get referenceId;
  @override
  String? get status;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransactionsResponse _$TransactionsResponseFromJson(Map<String, dynamic> json) {
  return _TransactionsResponse.fromJson(json);
}

/// @nodoc
mixin _$TransactionsResponse {
  List<Transaction> get transactions => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this TransactionsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionsResponseCopyWith<TransactionsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionsResponseCopyWith<$Res> {
  factory $TransactionsResponseCopyWith(
    TransactionsResponse value,
    $Res Function(TransactionsResponse) then,
  ) = _$TransactionsResponseCopyWithImpl<$Res, TransactionsResponse>;
  @useResult
  $Res call({
    List<Transaction> transactions,
    int total,
    int page,
    int limit,
    int totalPages,
  });
}

/// @nodoc
class _$TransactionsResponseCopyWithImpl<
  $Res,
  $Val extends TransactionsResponse
>
    implements $TransactionsResponseCopyWith<$Res> {
  _$TransactionsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactions = null,
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? totalPages = null,
  }) {
    return _then(
      _value.copyWith(
            transactions: null == transactions
                ? _value.transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                      as List<Transaction>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            limit: null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransactionsResponseImplCopyWith<$Res>
    implements $TransactionsResponseCopyWith<$Res> {
  factory _$$TransactionsResponseImplCopyWith(
    _$TransactionsResponseImpl value,
    $Res Function(_$TransactionsResponseImpl) then,
  ) = __$$TransactionsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Transaction> transactions,
    int total,
    int page,
    int limit,
    int totalPages,
  });
}

/// @nodoc
class __$$TransactionsResponseImplCopyWithImpl<$Res>
    extends _$TransactionsResponseCopyWithImpl<$Res, _$TransactionsResponseImpl>
    implements _$$TransactionsResponseImplCopyWith<$Res> {
  __$$TransactionsResponseImplCopyWithImpl(
    _$TransactionsResponseImpl _value,
    $Res Function(_$TransactionsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactions = null,
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? totalPages = null,
  }) {
    return _then(
      _$TransactionsResponseImpl(
        transactions: null == transactions
            ? _value._transactions
            : transactions // ignore: cast_nullable_to_non_nullable
                  as List<Transaction>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        limit: null == limit
            ? _value.limit
            : limit // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionsResponseImpl implements _TransactionsResponse {
  const _$TransactionsResponseImpl({
    required final List<Transaction> transactions,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  }) : _transactions = transactions;

  factory _$TransactionsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionsResponseImplFromJson(json);

  final List<Transaction> _transactions;
  @override
  List<Transaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  final int total;
  @override
  final int page;
  @override
  final int limit;
  @override
  final int totalPages;

  @override
  String toString() {
    return 'TransactionsResponse(transactions: $transactions, total: $total, page: $page, limit: $limit, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsResponseImpl &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_transactions),
    total,
    page,
    limit,
    totalPages,
  );

  /// Create a copy of TransactionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsResponseImplCopyWith<_$TransactionsResponseImpl>
  get copyWith =>
      __$$TransactionsResponseImplCopyWithImpl<_$TransactionsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionsResponseImplToJson(this);
  }
}

abstract class _TransactionsResponse implements TransactionsResponse {
  const factory _TransactionsResponse({
    required final List<Transaction> transactions,
    required final int total,
    required final int page,
    required final int limit,
    required final int totalPages,
  }) = _$TransactionsResponseImpl;

  factory _TransactionsResponse.fromJson(Map<String, dynamic> json) =
      _$TransactionsResponseImpl.fromJson;

  @override
  List<Transaction> get transactions;
  @override
  int get total;
  @override
  int get page;
  @override
  int get limit;
  @override
  int get totalPages;

  /// Create a copy of TransactionsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsResponseImplCopyWith<_$TransactionsResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
