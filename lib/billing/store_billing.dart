import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/store_kit_2_wrappers.dart';

import 'billing_config.dart';
import 'billing_service.dart';

/// App Store / Google Play subscriptions without a backend. The
/// subscription state is read on the device: StoreKit 2 transactions
/// (signed by Apple) on iOS, active purchases from Play Billing on Android.
class StoreBillingService extends BillingService {
  StoreBillingService([InAppPurchase? iap]) : _iapOverride = iap;

  final InAppPurchase? _iapOverride;
  InAppPurchase get _iap => _iapOverride ?? InAppPurchase.instance;

  final _changes = StreamController<bool>.broadcast();
  final _products = <String, ProductDetails>{};
  StreamSubscription<List<PurchaseDetails>>? _updates;
  Completer<PurchaseOutcome>? _pending;
  bool _ready = false;

  @override
  bool get available => true;

  @override
  Future<void> init() async {
    // The app root may rebuild its provider scope; listen only once.
    if (_updates != null) return;
    _updates = _iap.purchaseStream.listen(
      _onUpdates,
      onError: (Object e) => debugPrint('Purchase stream error: $e'),
    );
    _ready = await _iap.isAvailable();
  }

  static PlanPeriod? _periodOf(String productId) => switch (productId) {
    BillingConfig.yearlyId => PlanPeriod.yearly,
    BillingConfig.monthlyId => PlanPeriod.monthly,
    _ => null,
  };

  @override
  Future<List<PlanOffer>> offers() async {
    if (!_ready) return const [];
    try {
      final response = await _iap.queryProductDetails(BillingConfig.productIds);
      _products.clear();
      // Play lists one entry per base plan and offer; keep the first.
      for (final p in response.productDetails) {
        _products.putIfAbsent(p.id, () => p);
      }
      final offers = [
        for (final p in _products.values)
          if (_periodOf(p.id) case final period?)
            PlanOffer(
              id: p.id,
              period: period,
              price: p.rawPrice,
              priceString: p.price,
              currencyCode: p.currencyCode,
            ),
      ];
      // Yearly first, as the paywall shows it.
      return offers..sort((a, b) => a.period == PlanPeriod.yearly ? -1 : 1);
    } on PlatformException {
      return const [];
    }
  }

  @override
  Future<bool?> isSubscribed() async {
    if (!_ready) return null;
    try {
      return switch (defaultTargetPlatform) {
        TargetPlatform.iOS || TargetPlatform.macOS => await _appleActive(),
        TargetPlatform.android => await _googleActive(),
        _ => null,
      };
    } on PlatformException {
      return null;
    }
  }

  /// Any of our subscriptions with an expiry still ahead. `Transaction.all`
  /// needs no sign-in and works offline from the device's copy.
  Future<bool> _appleActive() async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final transactions = await SK2Transaction.transactions();
    return transactions.any(
      (t) =>
          BillingConfig.productIds.contains(t.productId) &&
          (int.tryParse(t.expirationDate ?? '') ?? 0) > now,
    );
  }

  /// Play only returns subscriptions that are currently active.
  Future<bool?> _googleActive() async {
    final addition = _iap
        .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
    final response = await addition.queryPastPurchases();
    if (response.error != null) return null;
    var active = false;
    for (final p in response.pastPurchases) {
      if (!BillingConfig.productIds.contains(p.productID)) continue;
      if (p.status != PurchaseStatus.purchased) continue;
      // Unacknowledged Play purchases are refunded after three days.
      if (p.pendingCompletePurchase) await _iap.completePurchase(p);
      active = true;
    }
    return active;
  }

  @override
  Stream<bool> get subscriptionChanges => _changes.stream;

  Future<void> _onUpdates(List<PurchaseDetails> updates) async {
    for (final p in updates) {
      if (!BillingConfig.productIds.contains(p.productID)) continue;
      if (p.pendingCompletePurchase) await _iap.completePurchase(p);
      switch (p.status) {
        case PurchaseStatus.purchased:
          _changes.add(true);
          _finish(PurchaseOutcome.success);
        // A restored transaction may be an expired one; read the state.
        case PurchaseStatus.restored:
          if (await isSubscribed() case final active?) _changes.add(active);
        case PurchaseStatus.canceled:
          _finish(PurchaseOutcome.cancelled);
        case PurchaseStatus.error:
          _finish(PurchaseOutcome.failed);
        case PurchaseStatus.pending:
          break;
      }
    }
  }

  void _finish(PurchaseOutcome outcome) {
    final pending = _pending;
    _pending = null;
    if (pending != null && !pending.isCompleted) pending.complete(outcome);
  }

  @override
  Future<PurchaseOutcome> purchase(PlanOffer offer) async {
    final product = _products[offer.id];
    if (product == null) return PurchaseOutcome.failed;
    _finish(PurchaseOutcome.cancelled);
    final result = _pending = Completer<PurchaseOutcome>();
    try {
      await _iap.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: product),
      );
    } on PlatformException catch (e) {
      _finish(
        e.code.contains('cancel')
            ? PurchaseOutcome.cancelled
            : PurchaseOutcome.failed,
      );
    }
    return result.future;
  }

  @override
  Future<bool> restore() async {
    if (!_ready) return false;
    try {
      // Syncs with the store (may ask the user to sign in on iOS), then
      // reads the state the same way as at launch.
      await _iap.restorePurchases();
      return await isSubscribed() ?? false;
    } on PlatformException {
      return false;
    }
  }
}
