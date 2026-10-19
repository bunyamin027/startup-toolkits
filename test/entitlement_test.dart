import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/billing/entitlement.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';

void main() {
  final launch = DateTime(2026, 10, 1, 9);
  final afterTrial = DateTime(2026, 10, 20, 10);

  group('access level', () {
    test('trial for 14 days, then free', () {
      final e = Entitlement(firstLaunch: launch);
      expect(e.level(launch), AccessLevel.trial);
      expect(e.level(DateTime(2026, 10, 15, 8, 59)), AccessLevel.trial);
      expect(e.level(DateTime(2026, 10, 15, 9)), AccessLevel.free);
    });

    test('subscriber regardless of dates', () {
      final e = Entitlement(firstLaunch: launch, subscribed: true);
      expect(e.level(afterTrial), AccessLevel.subscriber);
    });

    test('trial days left rounds up', () {
      final e = Entitlement(firstLaunch: launch);
      expect(e.trialDaysLeft(launch), 14);
      expect(e.trialDaysLeft(DateTime(2026, 10, 14, 10)), 1);
      expect(e.trialDaysLeft(afterTrial), 0);
    });
  });

  group('free plan: one tool per day', () {
    final free = Entitlement(firstLaunch: launch);

    test('first tool opened becomes today\'s tool, others lock', () {
      expect(free.canOpen('runway', afterTrial), isTrue);
      final claimed = free.open('runway', afterTrial);
      expect(claimed.todaysTool(afterTrial), 'runway');
      expect(
        claimed.canOpen('runway', afterTrial.add(const Duration(hours: 5))),
        isTrue,
      );
      expect(claimed.canOpen('swot', afterTrial), isFalse);
      expect(() => claimed.open('swot', afterTrial), throwsStateError);
    });

    test('resets at local midnight', () {
      final claimed = free.open('runway', afterTrial);
      final nextDay = DateTime(2026, 10, 21, 0, 0, 1);
      expect(claimed.canOpen('swot', nextDay), isTrue);
      expect(claimed.open('swot', nextDay).todaysTool(nextDay), 'swot');
      expect(Entitlement.nextReset(afterTrial), DateTime(2026, 10, 21));
    });

    test('opening during trial does not claim a daily tool', () {
      final e = free.open('runway', launch);
      expect(e.dailyToolId, isNull);
    });
  });

  test('json round trip', () {
    final e = Entitlement(
      firstLaunch: launch,
      subscribed: true,
      dailyToolId: 'runway',
      dailyDate: '2026-10-20',
    );
    expect(Entitlement.fromJson(e.toJson()).toJson(), e.toJson());
  });

  test('store starts the trial on first launch and keeps it', () async {
    final store = EntitlementStore(MemoryKeyValueStore());
    final first = await store.load(launch);
    expect(first.firstLaunch, launch);
    final later = await store.load(afterTrial);
    expect(later.firstLaunch, launch);
  });
}
