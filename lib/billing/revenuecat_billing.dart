import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'billing_config.dart';
import 'billing_service.dart';

/// RevenueCat-backed store. Expects one offering ("current") with a monthly
/// and an annual package, each optionally carrying a free-trial intro offer.
class RevenueCatBillingService extends BillingService {
  RevenueCatBillingService(this.apiKey);

  final String apiKey;
  final _changes = StreamController<bool>.broadcast();
  final _packages = <String, Package>{};
  bool _configured = false;

  @override
  bool get available => true;

  @override
  Future<void> init() async {
    // The app root may rebuild its provider scope; configure only once.
    if (_configured) return;
    _configured = true;
    await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.warn);
    await Purchases.configure(PurchasesConfiguration(apiKey));
    Purchases.addCustomerInfoUpdateListener(
      (info) => _changes.add(_isPro(info)),
    );
  }

  static bool _isPro(CustomerInfo info) =>
      info.entitlements.active.containsKey(BillingConfig.entitlementId);

  @override
  Future<List<PlanOffer>> offers() async {
    try {
      final offering = (await Purchases.getOfferings()).current;
      if (offering == null) return const [];
      final packages = [?offering.annual, ?offering.monthly];
      final eligibility = await _eligibility(packages);
      _packages
        ..clear()
        ..addEntries(packages.map((p) => MapEntry(p.identifier, p)));
      return [
        for (final p in packages)
          PlanOffer(
            id: p.identifier,
            period: p.packageType == PackageType.annual
                ? PlanPeriod.yearly
                : PlanPeriod.monthly,
            price: p.storeProduct.price,
            priceString: p.storeProduct.priceString,
            currencyCode: p.storeProduct.currencyCode,
            freeTrialDays: eligibility[p.storeProduct.identifier] == false
                ? null
                : _freeTrialDays(p.storeProduct.introductoryPrice),
          ),
      ];
    } on PlatformException {
      return const [];
    }
  }

  /// iOS reports eligibility; Android only shows offers the user can get,
  /// so unknown counts as eligible.
  Future<Map<String, bool>> _eligibility(List<Package> packages) async {
    if (defaultTargetPlatform != TargetPlatform.iOS) return const {};
    final ids = [for (final p in packages) p.storeProduct.identifier];
    final result = await Purchases.checkTrialOrIntroductoryPriceEligibility(
      ids,
    );
    return {
      for (final e in result.entries)
        e.key:
            e.value.status !=
            IntroEligibilityStatus.introEligibilityStatusIneligible,
    };
  }

  static int? _freeTrialDays(IntroductoryPrice? intro) {
    if (intro == null || intro.price > 0) return null;
    final n = intro.periodNumberOfUnits * intro.cycles;
    return switch (intro.periodUnit) {
      PeriodUnit.day => n,
      PeriodUnit.week => n * 7,
      PeriodUnit.month => n * 30,
      PeriodUnit.year => n * 365,
      PeriodUnit.unknown => null,
    };
  }

  @override
  Future<bool?> isSubscribed() async {
    try {
      // Served from RevenueCat's cache when offline.
      return _isPro(await Purchases.getCustomerInfo());
    } on PlatformException {
      return null;
    }
  }

  @override
  Stream<bool> get subscriptionChanges => _changes.stream;

  @override
  Future<PurchaseOutcome> purchase(PlanOffer offer) async {
    final package = _packages[offer.id];
    if (package == null) return PurchaseOutcome.failed;
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      return _isPro(result.customerInfo)
          ? PurchaseOutcome.success
          : PurchaseOutcome.failed;
    } on PlatformException catch (e) {
      return PurchasesErrorHelper.getErrorCode(e) ==
              PurchasesErrorCode.purchaseCancelledError
          ? PurchaseOutcome.cancelled
          : PurchaseOutcome.failed;
    }
  }

  @override
  Future<bool> restore() async {
    try {
      return _isPro(await Purchases.restorePurchases());
    } on PlatformException {
      return false;
    }
  }
}
