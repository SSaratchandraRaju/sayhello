import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/wallet_models.dart';
import '../repositories/wallet_repository.dart';
import '../core/exceptions/api_exceptions.dart';

/// Wallet Controller
class WalletController extends GetxController {
  final WalletRepository _walletRepository;
  final Logger _logger = Logger();

  WalletController({WalletRepository? walletRepository})
    : _walletRepository = walletRepository ?? WalletRepository();

  // Observable state
  final Rx<Wallet?> wallet = Rx<Wallet?>(null);
  final RxList<CreditPackage> packages = <CreditPackage>[].obs;
  final RxList<Transaction> transactions = <Transaction>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingPackages = false.obs;
  final RxBool isLoadingTransactions = false.obs;
  final RxString error = ''.obs;

  // Pagination
  final RxInt currentPage = 1.obs;
  final RxInt totalPages = 1.obs;
  final RxBool hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadBalance();
  }

  /// Get current balance
  double get balance => wallet.value?.balance ?? 0.0;

  /// Load wallet balance
  Future<void> loadBalance() async {
    try {
      isLoading.value = true;
      error.value = '';

      final walletData = await _walletRepository.getBalance();
      wallet.value = walletData;
      _logger.i('Wallet balance loaded: ${walletData.balance}');
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to load wallet balance', error: e);
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error loading wallet', error: e);
    } finally {
      isLoading.value = false;
    }
  }

  /// Load credit packages
  Future<void> loadPackages() async {
    try {
      isLoadingPackages.value = true;
      error.value = '';

      final packageList = await _walletRepository.getPackages();
      packages.value = packageList;
      _logger.i('Loaded ${packageList.length} credit packages');
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to load packages', error: e);
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error loading packages', error: e);
    } finally {
      isLoadingPackages.value = false;
    }
  }

  /// Purchase credits
  Future<bool> purchaseCredits({
    required String packageId,
    required String paymentMethod,
    required String paymentToken,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';

      final response = await _walletRepository.purchaseCredits(
        packageId: packageId,
        paymentMethod: paymentMethod,
        paymentToken: paymentToken,
      );

      if (response.success) {
        // Update wallet balance
        if (wallet.value != null) {
          wallet.value = wallet.value!.copyWith(balance: response.newBalance);
        }
        _logger.i('Credits purchased: ${response.creditsAdded}');
        return true;
      }
      return false;
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to purchase credits', error: e);
      return false;
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error purchasing credits', error: e);
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Load transaction history
  Future<void> loadTransactions({
    bool refresh = false,
    String type = 'all',
  }) async {
    try {
      if (refresh) {
        currentPage.value = 1;
        transactions.clear();
      }

      isLoadingTransactions.value = true;
      error.value = '';

      final response = await _walletRepository.getTransactions(
        page: currentPage.value,
        limit: 20,
        type: type,
      );

      if (refresh) {
        transactions.value = response.transactions;
      } else {
        transactions.addAll(response.transactions);
      }

      totalPages.value = response.totalPages;
      hasMore.value = currentPage.value < totalPages.value;

      _logger.i('Loaded ${response.transactions.length} transactions');
    } on ApiException catch (e) {
      error.value = e.message;
      _logger.e('Failed to load transactions', error: e);
    } catch (e) {
      error.value = 'An unexpected error occurred';
      _logger.e('Unexpected error loading transactions', error: e);
    } finally {
      isLoadingTransactions.value = false;
    }
  }

  /// Load more transactions
  Future<void> loadMoreTransactions({String type = 'all'}) async {
    if (!hasMore.value || isLoadingTransactions.value) return;

    currentPage.value++;
    await loadTransactions(type: type);
  }

  /// Deduct credits locally (will be synced from backend)
  void deductCredits(double amount) {
    if (wallet.value != null) {
      final newBalance = wallet.value!.balance - amount;
      wallet.value = wallet.value!.copyWith(balance: newBalance);
    }
  }

  /// Add credits locally (will be synced from backend)
  void addCredits(double amount) {
    if (wallet.value != null) {
      final newBalance = wallet.value!.balance + amount;
      wallet.value = wallet.value!.copyWith(balance: newBalance);
    }
  }

  /// Refresh all wallet data
  Future<void> refreshAll() async {
    await Future.wait([loadBalance(), loadTransactions(refresh: true)]);
  }

  /// Clear error message
  void clearError() {
    error.value = '';
  }
}
