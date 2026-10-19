import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/storage/storage_providers.dart';
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

  /// Records a tool open; claims today's tool on the free plan.
  /// Gating (paywall, free limit sheet) arrives in Sprint 4.
  void open(String toolId) {
    final now = ref.read(clockProvider)();
    if (!state.canOpen(toolId, now)) return;
    final next = state.open(toolId, now);
    if (!identical(next, state)) _set(next);
  }
}
