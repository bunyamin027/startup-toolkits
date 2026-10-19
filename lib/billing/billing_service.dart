import 'dart:async';

import 'package:flutter/foundation.dart';

import '../core/format.dart';

enum PlanPeriod { monthly, yearly }

/// One subscription option as the store reports it. Prices always come
/// from the store (App Review 3.1.2), never from app constants.
@immutable
class PlanOffer {
  const PlanOffer({
    required this.id,
    required this.period,
    required this.price,
    required this.priceString,
    required this.currencyCode,
    this.freeTrialDays,
  });

  final String id;
  final PlanPeriod period;
  final double price;

  /// Localized full price, e.g. "$79.99".
  final String priceString;
  final String currencyCode;

  /// Length of the free intro offer, when the user is eligible for it.
  final int? freeTrialDays;

  String get perPeriod =>
      period == PlanPeriod.yearly ? '$priceString/year' : '$priceString/month';

  /// Monthly equivalent of a yearly plan, shown smaller than the billed
  /// amount. Formatted with the currency code because the store does not
  /// localize derived prices.
  String? get monthlyEquivalent {
    if (period != PlanPeriod.yearly) return null;
    return '${currencyCode == 'USD' ? r'$' : '$currencyCode '}'
        '${Fmt.number(price / 12, decimals: 2)}/month';
  }
}

/// Yearly discount against twelve monthly payments, e.g. 0.33.
double? yearlySavings(List<PlanOffer> offers) {
  final monthly = offers
      .where((o) => o.period == PlanPeriod.monthly)
      .firstOrNull;
  final yearly = offers.where((o) => o.period == PlanPeriod.yearly).firstOrNull;
  if (monthly == null || yearly == null || monthly.price <= 0) return null;
  final saving = 1 - yearly.price / (monthly.price * 12);
  return saving > 0 ? saving : null;
}

enum PurchaseOutcome { success, cancelled, failed }

/// Store abstraction so the paywall works with RevenueCat, the debug
/// preview store, or no store at all.
abstract class BillingService {
  /// False when purchases cannot be made (no key in a release build).
  bool get available;

  /// True when the price labels are placeholders (debug preview store).
  bool get isPreview => false;

  Future<void> init();

  /// Monthly and yearly offers, empty when the store has none.
  Future<List<PlanOffer>> offers();

  /// Null when the store cannot tell right now (offline, not configured);
  /// callers then keep the last known state.
  Future<bool?> isSubscribed();

  /// Emits when the subscription turns on or off outside a purchase call
  /// (renewal, expiry, family sharing).
  Stream<bool> get subscriptionChanges;

  Future<PurchaseOutcome> purchase(PlanOffer offer);

  /// Returns whether an active subscription was found.
  Future<bool> restore();
}

/// Release build without a RevenueCat key: the paywall explains that
/// subscriptions are unavailable instead of showing fake prices.
class UnavailableBillingService extends BillingService {
  @override
  bool get available => false;

  @override
  Future<void> init() async {}

  @override
  Future<List<PlanOffer>> offers() async => const [];

  @override
  Future<bool?> isSubscribed() async => null;

  @override
  Stream<bool> get subscriptionChanges => const Stream.empty();

  @override
  Future<PurchaseOutcome> purchase(PlanOffer offer) async =>
      PurchaseOutcome.failed;

  @override
  Future<bool> restore() async => false;
}

/// Debug-only store with the plan's assumed prices ($9.99 / $79.99, 14-day
/// trial), so the paywall can be built and tested before App Store Connect
/// products exist. Purchases succeed after a short delay and live in memory.
class PreviewBillingService extends BillingService {
  PreviewBillingService({this.delay = const Duration(milliseconds: 600)});

  final Duration delay;
  bool _subscribed = false;
  final _changes = StreamController<bool>.broadcast();

  @override
  bool get available => true;

  @override
  bool get isPreview => true;

  @override
  Future<void> init() async {}

  @override
  Future<List<PlanOffer>> offers() async => const [
    PlanOffer(
      id: 'preview_yearly',
      period: PlanPeriod.yearly,
      price: 79.99,
      priceString: r'$79.99',
      currencyCode: 'USD',
      freeTrialDays: 14,
    ),
    PlanOffer(
      id: 'preview_monthly',
      period: PlanPeriod.monthly,
      price: 9.99,
      priceString: r'$9.99',
      currencyCode: 'USD',
      freeTrialDays: 14,
    ),
  ];

  @override
  Future<bool?> isSubscribed() async => _subscribed;

  @override
  Stream<bool> get subscriptionChanges => _changes.stream;

  @override
  Future<PurchaseOutcome> purchase(PlanOffer offer) async {
    await Future<void>.delayed(delay);
    _subscribed = true;
    _changes.add(true);
    return PurchaseOutcome.success;
  }

  @override
  Future<bool> restore() async {
    await Future<void>.delayed(delay);
    return _subscribed;
  }
}
