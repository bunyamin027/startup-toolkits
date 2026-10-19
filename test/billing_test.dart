import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/billing/billing_service.dart';
import 'package:startup_toolkits/billing/entitlement.dart';
import 'package:startup_toolkits/billing/entitlement_providers.dart';
import 'package:startup_toolkits/core/analytics.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';
import 'package:startup_toolkits/project/project_store.dart';

import 'helpers.dart';

/// Store double with a controllable subscription state.
class FakeBilling extends PreviewBillingService {
  FakeBilling({this.subscribedAtStart, this.restorable = false})
    : super(delay: Duration.zero);

  final bool? subscribedAtStart;
  final bool restorable;
  final changes = StreamController<bool>.broadcast();

  @override
  Future<bool?> isSubscribed() async => subscribedAtStart;

  @override
  Stream<bool> get subscriptionChanges => changes.stream;

  @override
  Future<bool> restore() async => restorable;
}

/// Stored state of a user whose trial ended (free plan), past onboarding.
Future<MemoryKeyValueStore> freePlanStore() async {
  final kv = MemoryKeyValueStore();
  await EntitlementStore(kv).save(
    Entitlement(firstLaunch: DateTime.now().subtract(const Duration(days: 20))),
  );
  await OnboardingStore(kv).save(true);
  return kv;
}

void main() {
  group('offers', () {
    test('yearly savings and monthly equivalent', () async {
      final offers = await PreviewBillingService().offers();
      expect(yearlySavings(offers), closeTo(0.333, 0.001));
      final yearly = offers.firstWhere((o) => o.period == PlanPeriod.yearly);
      expect(yearly.perPeriod, r'$79.99/year');
      expect(yearly.monthlyEquivalent, r'$6.67/month');
      expect(
        offers
            .firstWhere((o) => o.period == PlanPeriod.monthly)
            .monthlyEquivalent,
        isNull,
      );
    });

    test('no savings badge when yearly is not cheaper', () {
      const offers = [
        PlanOffer(
          id: 'm',
          period: PlanPeriod.monthly,
          price: 5,
          priceString: r'$5',
          currencyCode: 'USD',
        ),
        PlanOffer(
          id: 'y',
          period: PlanPeriod.yearly,
          price: 60,
          priceString: r'$60',
          currencyCode: 'USD',
        ),
      ];
      expect(yearlySavings(offers), isNull);
    });
  });

  group('store sync', () {
    test('store state wins over the stored flag; unknown keeps it', () async {
      Future<bool> syncedWith(bool? store, {required bool stored}) async {
        final container = ProviderContainer.test(
          overrides: [
            ...await keyValueOverride(),
            initialEntitlementProvider.overrideWithValue(
              Entitlement(firstLaunch: DateTime.now(), subscribed: stored),
            ),
            billingServiceProvider.overrideWithValue(
              FakeBilling(subscribedAtStart: store),
            ),
          ],
        );
        container.read(billingSyncProvider);
        await pumpEventQueue();
        return container.read(entitlementProvider).subscribed;
      }

      expect(await syncedWith(true, stored: false), isTrue);
      expect(await syncedWith(false, stored: true), isFalse);
      expect(await syncedWith(null, stored: true), isTrue);
    });

    test('a subscription ending is logged once', () async {
      final analytics = RecordingAnalytics();
      final billing = FakeBilling(subscribedAtStart: true);
      final container = ProviderContainer.test(
        overrides: [
          ...await keyValueOverride(),
          analyticsProvider.overrideWithValue(analytics),
          billingServiceProvider.overrideWithValue(billing),
        ],
      );
      container.read(billingSyncProvider);
      await pumpEventQueue();
      billing.changes
        ..add(false)
        ..add(false);
      await pumpEventQueue();
      expect(container.read(entitlementProvider).subscribed, isFalse);
      expect(
        analytics.names.where((e) => e == AnalyticsEvent.subscriptionEnded),
        hasLength(1),
      );
    });
  });

  group('free plan', () {
    testWidgets('one tool a day, then the free limit sheet', (tester) async {
      final analytics = RecordingAnalytics();
      await pumpRoot(
        tester,
        kv: await freePlanStore(),
        services: [
          billingServiceProvider.overrideWithValue(FakeBilling()),
          analyticsProvider.overrideWithValue(analytics),
        ],
      );
      expect(find.text('Free plan'), findsOneWidget);
      expect(find.text('Your trial has ended'), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsNothing);
      await scrollTo(tester, find.text('Lean Canvas').hitTestable());

      // First tool of the day opens and becomes today's tool.
      await tester.tap(find.text('Lean Canvas').hitTestable().first);
      await tester.pumpAndSettle();
      expect(find.textContaining('LEAN CANVAS'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.lock_outline), findsWidgets);

      // Any other tool shows the sheet instead.
      await tester.tap(find.text('Runway & burn rate').hitTestable());
      await tester.pumpAndSettle();
      expect(find.text("You've used today's free tool"), findsOneWidget);
      expect(
        find.textContaining('Lean Canvas stays open all day'),
        findsOneWidget,
      );
      expect(find.textContaining('to reset'), findsOneWidget);
      expect(analytics.names, contains(AnalyticsEvent.freeLimitHit));

      await tester.tap(find.text('Come back tomorrow'));
      await tester.pumpAndSettle();
      expect(find.text("You've used today's free tool"), findsNothing);

      // Today's tool still opens.
      await tester.tap(find.text('Lean Canvas').hitTestable().first);
      await tester.pumpAndSettle();
      expect(find.textContaining('LEAN CANVAS'), findsOneWidget);
    });

    testWidgets('go unlimited: paywall purchase unlocks every tool', (
      tester,
    ) async {
      final analytics = RecordingAnalytics();
      await pumpRoot(
        tester,
        kv: await freePlanStore(),
        services: [
          billingServiceProvider.overrideWithValue(FakeBilling()),
          analyticsProvider.overrideWithValue(analytics),
        ],
      );
      await scrollTo(tester, find.text('Lean Canvas').hitTestable());
      await tester.tap(find.text('Lean Canvas').hitTestable().first);
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Runway & burn rate').hitTestable());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Go unlimited'));
      await tester.pumpAndSettle();

      // Paywall: yearly preselected, store prices, required terms and links.
      expect(find.text('Every tool.\nEvery day.'), findsOneWidget);
      expect(find.text('Save 33%'), findsOneWidget);
      expect(find.text(r'$79.99/year'), findsOneWidget);
      expect(find.text('Start 14-day free trial'), findsOneWidget);
      expect(
        find.textContaining(
          r'14 days free, then $79.99 per year. Renews automatically',
        ),
        findsOneWidget,
      );
      expect(find.text('Restore Purchases'), findsOneWidget);
      expect(find.text('Terms of Use'), findsOneWidget);
      expect(find.text('Privacy Policy'), findsOneWidget);

      await scrollTo(tester, find.text('Monthly'));
      await tester.tap(find.text('Monthly'));
      await tester.pumpAndSettle();
      expect(find.textContaining(r'then $9.99 per month'), findsOneWidget);
      await tester.tap(find.text('Yearly'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Start 14-day free trial'));
      await tester.pumpAndSettle();
      expect(find.text('Every tool.\nEvery day.'), findsNothing);
      // Back on Home, scrolled earlier: return to the top to see the badge.
      await tester.drag(
        find.byType(ListView).hitTestable().first,
        const Offset(0, 2000),
      );
      await tester.pumpAndSettle();
      expect(find.text('Pro'), findsOneWidget);
      expect(find.text('Your trial has ended'), findsNothing);
      await tester.tap(find.text('Search 45 tools'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'runway');
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.lock_outline), findsNothing);
      await tester.tap(find.text('Runway & burn rate'));
      await tester.pumpAndSettle();
      expect(find.text('11.4 months'), findsOneWidget);

      expect(
        analytics.names,
        containsAllInOrder([
          AnalyticsEvent.freeLimitHit,
          AnalyticsEvent.paywallViewed,
          AnalyticsEvent.planSelected,
          AnalyticsEvent.trialStarted,
          AnalyticsEvent.toolOpened,
        ]),
      );
    });

    testWidgets('restore finds nothing and says so', (tester) async {
      await pumpRoot(
        tester,
        kv: await freePlanStore(),
        services: [billingServiceProvider.overrideWithValue(FakeBilling())],
      );
      await tester.tap(find.text('See plans'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Restore Purchases'));
      await tester.pumpAndSettle();
      expect(
        find.text('No active subscription found for this account.'),
        findsOneWidget,
      );
    });

    testWidgets('restore with a subscription unlocks Pro', (tester) async {
      await pumpRoot(
        tester,
        kv: await freePlanStore(),
        services: [
          billingServiceProvider.overrideWithValue(
            FakeBilling(restorable: true),
          ),
        ],
      );
      await tester.tap(find.text('See plans'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Restore Purchases'));
      await tester.pumpAndSettle();
      expect(find.text('Pro'), findsOneWidget);
    });
  });

  testWidgets(
    'without a store the paywall says subscriptions are unavailable',
    (tester) async {
      await pumpRoot(
        tester,
        kv: await freePlanStore(),
        services: [
          billingServiceProvider.overrideWithValue(UnavailableBillingService()),
        ],
      );
      await tester.tap(find.text('See plans'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Subscriptions are not available right now'),
        findsOneWidget,
      );
      final buy = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Subscribe'),
      );
      expect(buy.onPressed, isNull);
    },
  );

  testWidgets('during the trial nothing is locked', (tester) async {
    final kv = MemoryKeyValueStore();
    await OnboardingStore(kv).save(true);
    await pumpRoot(
      tester,
      kv: kv,
      services: [billingServiceProvider.overrideWithValue(FakeBilling())],
    );
    await tester.tap(find.text('Lean Canvas').hitTestable().first);
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.lock_outline), findsNothing);
    await tester.tap(find.text('Runway & burn rate').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('11.4 months'), findsOneWidget);
  });
}
