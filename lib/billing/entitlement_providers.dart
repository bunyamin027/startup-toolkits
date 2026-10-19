import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/analytics.dart';
import '../core/storage/storage_providers.dart';
import 'billing_service.dart';
import 'entitlement.dart';

/// Loaded (and the trial clock started) before the first frame.
final initialEntitlementProvider = Provider<Entitlement>(
  (ref) => Entitlement(firstLaunch: DateTime.now()),
);

/// Clock seam so tests can pin "now".
final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

final entitlementProvider = NotifierProvider<EntitlementNotifier, Entitlement>(
  EntitlementNotifier.new,
);

class EntitlementNotifier extends Notifier<Entitlement> {
  @override
  Entitlement build() => ref.read(initialEntitlementProvider);

  void _set(Entitlement e) {
    state = e;
    unawaited(EntitlementStore(ref.read(keyValueStoreProvider)).save(e));
  }

  /// Mirrors the store. Logs the end of a subscription (cancelled and
  /// expired, or refunded).
  void setSubscribed(bool subscribed) {
    if (state.subscribed == subscribed) return;
    if (!subscribed) {
      ref.read(analyticsProvider).log(AnalyticsEvent.subscriptionEnded);
    }
    _set(state.copyWith(subscribed: subscribed));
  }

  /// Records a tool open; claims today's tool on the free plan. Callers
  /// gate with [Entitlement.canOpen] first (see `openTool`).
  void open(String toolId) {
    final now = ref.read(clockProvider)();
    if (!state.canOpen(toolId, now)) return;
    final next = state.open(toolId, now);
    if (!identical(next, state)) _set(next);
  }
}

/// Overridden in `main` with the store picked by [BillingConfig].
final billingServiceProvider = Provider<BillingService>(
  (ref) => UnavailableBillingService(),
);

/// Starts the store and keeps [entitlementProvider] in sync with it.
/// Watched by the app so it lives as long as the provider scope.
final billingSyncProvider = Provider<void>((ref) {
  final billing = ref.watch(billingServiceProvider);
  final entitlement = ref.read(entitlementProvider.notifier);
  final sub = billing.subscriptionChanges.listen(entitlement.setSubscribed);
  ref.onDispose(sub.cancel);
  unawaited(() async {
    try {
      await billing.init();
      final subscribed = await billing.isSubscribed();
      if (ref.mounted && subscribed != null) {
        entitlement.setSubscribed(subscribed);
      }
    } on Exception catch (e) {
      // Store problems must never block the app; tools keep working on
      // the last known plan.
      debugPrint('Billing init failed: $e');
    }
  }());
});
