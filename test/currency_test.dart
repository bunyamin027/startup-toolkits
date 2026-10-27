import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/core/bootstrap.dart';
import 'package:startup_toolkits/core/currency.dart';
import 'package:startup_toolkits/core/format.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';
import 'package:startup_toolkits/project/project_store.dart';

import 'helpers.dart';

const _nbsp = ' ';

void main() {
  group('amounts follow the currency and the language', () {
    test('symbol and placement', () {
      expect(Fmt.of('tr', 'TRY').money(120000), '₺120.000');
      expect(Fmt.of('de', 'EUR').money(120000), '120.000$_nbsp€');
      expect(Fmt.of('en', 'GBP').money(49.5), '£49.50');
      expect(Fmt.of('en', 'USD').money(120000), r'$120,000');
      expect(Fmt.en.money(120000), r'$120,000');
    });

    test('letter codes get a gap, dollar variants do not', () {
      expect(Fmt.of('en', 'CHF').money(1200), 'CHF${_nbsp}1,200');
      expect(Fmt.of('en', 'CHF').money(-1200), '-CHF${_nbsp}1,200');
      expect(Fmt.of('en', 'CAD').money(1200), r'CA$1,200');
    });

    test('yen has no decimals', () {
      expect(Fmt.of('en', 'JPY').money(1200.4), '¥1,200');
    });

    test('unknown currency falls back to dollars', () {
      expect(Fmt.of('en', 'XYZ').symbol, r'$');
    });

    test('device region picks the default', () {
      expect(currencyForRegion('TR'), 'TRY');
      expect(currencyForRegion('de'), 'EUR');
      expect(currencyForRegion('BR'), 'BRL');
      expect(currencyForRegion('ZZ'), 'USD');
      expect(currencyForRegion(null), 'USD');
    });
  });

  testWidgets('currency picked in Profile shows in tools and sticks', (
    tester,
  ) async {
    final kv = MemoryKeyValueStore();
    await OnboardingStore(kv).save(true);
    final region = [regionProvider.overrideWithValue('US')];
    await pumpRoot(tester, kv: kv, services: region);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Currency'));
    await tester.pumpAndSettle();
    // Automatic follows the region until something is picked.
    expect(find.text(r'USD · $'), findsOneWidget);
    expect(find.textContaining('Follows your region.'), findsOneWidget);

    await tester.tap(find.text('Currency'));
    await tester.pumpAndSettle();
    expect(find.text(r'Automatic (USD · $)'), findsOneWidget);
    await tester.tap(find.text('TRY · ₺'));
    await tester.pumpAndSettle();
    expect(find.text('TRY · ₺'), findsOneWidget);

    // A calculator now writes amounts and inputs in lira.
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Search tools'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'runway');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Runway & burn rate'));
    await tester.pumpAndSettle();
    expect(find.text('₺10,500'), findsOneWidget);
    expect(find.text('₺120,000'), findsOneWidget);
    expect(find.textContaining(r'$'), findsNothing);

    // Kept across launches.
    await pumpRoot(tester, kv: kv, services: region);
    expect(await CurrencyStore(kv).load(), 'TRY');
  });

  test('delete all data keeps the currency setting', () async {
    final kv = MemoryKeyValueStore();
    await CurrencyStore(kv).save('EUR');
    final overrides = await resetAppState(kv, DateTime(2026, 10, 26));
    expect(overrides, isNotEmpty);
    expect(await CurrencyStore(kv).load(), 'EUR');
  });
}
