import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/billing/entitlement_providers.dart';
import 'package:startup_toolkits/features/onboarding/welcome_screen.dart';
import 'package:startup_toolkits/features/paywall/paywall_screen.dart';
import 'package:startup_toolkits/features/shell/app_shell.dart';
import 'package:startup_toolkits/features/tool/tool_screen.dart';
import 'package:startup_toolkits/tools/tool_providers.dart';
import 'package:startup_toolkits/l10n/l10n.dart';
import 'package:startup_toolkits/l10n/locale_providers.dart';
import 'package:startup_toolkits/tools/catalog/catalog.dart';

import 'billing_test.dart' show FakeBilling;
import 'helpers.dart';

/// Every screen in every language, on the small iPhone SE. Overflows from
/// longer translations (German, French) fail these tests on their own.
void main() {
  test('every supported language has a name in Profile', () {
    expect(
      AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet(),
      languageNames.keys.toSet(),
    );
  });

  for (final code in languageNames.keys.where((c) => c != 'en')) {
    final locale = Locale(code);

    group('$code renders', () {
      testWidgets('welcome', (tester) async {
        await pumpApp(
          tester,
          const WelcomeScreen(),
          locale: locale,
          screen: iPhoneSE,
        );
      });

      for (var i = 0; i < 4; i++) {
        testWidgets('tab $i', (tester) async {
          await pumpApp(
            tester,
            const AppShell(),
            locale: locale,
            screen: iPhoneSE,
          );
          await tester.tap(find.byType(NavigationDestination).at(i));
          await tester.pumpAndSettle();
        });
      }

      testWidgets('paywall', (tester) async {
        await pumpApp(
          tester,
          const PaywallScreen(),
          overrides: [billingServiceProvider.overrideWithValue(FakeBilling())],
          locale: locale,
          screen: iPhoneSE,
        );
      });

      for (final tool in allTools) {
        testWidgets(tool.id, (tester) async {
          await pumpApp(
            tester,
            ToolScreen(toolId: tool.id),
            locale: locale,
            screen: iPhoneSE,
          );
        });
      }
    });
  }

  testWidgets('language picked in Profile sticks across launches', (
    tester,
  ) async {
    final kv = await pumpRoot(tester);
    await onboard(tester);
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Türkçe'));
    await tester.pumpAndSettle();

    expect(find.text('Profil'), findsWidgets);
    expect(find.text('Ana sayfa'), findsOneWidget);
    // Tool names follow too, e.g. in Home's Start here list.
    await tester.tap(find.text('Ana sayfa'));
    await tester.pumpAndSettle();
    expect(find.text('Sunum sihirbazı'), findsWidgets);

    await pumpRoot(tester, kv: kv);
    expect(find.text('Ana sayfa'), findsOneWidget);
  });

  group('tools switch language while open', () {
    Future<void> switchTo(
      WidgetTester tester,
      ProviderContainer container,
      String code,
    ) async {
      container.read(localeProvider.notifier).set(Locale(code));
      await tester.pumpAndSettle();
    }

    testWidgets('calculator labels, numbers and verdict', (tester) async {
      final c = await pumpApp(tester, const ToolScreen(toolId: 'runway'));
      expect(find.text('Runway & burn rate'), findsOneWidget);
      expect(find.text(r'$120,000'), findsOneWidget);

      await switchTo(tester, c, 'de');
      expect(find.text('Runway & Burn Rate'), findsOneWidget);
      expect(find.text('Kontostand'), findsOneWidget);
      // German puts a no-break space before the currency sign.
      expect(find.text('120.000\u00a0\$'), findsOneWidget);
      expect(find.textContaining('Monate'), findsWidgets);

      await switchTo(tester, c, 'tr');
      expect(find.text('Pist ve yakım hızı'), findsOneWidget);
      expect(find.text(r'$120.000'), findsOneWidget);
    });

    testWidgets('document output and examples', (tester) async {
      final c = await pumpApp(tester, const ToolScreen(toolId: 'leanCanvas'));
      expect(find.textContaining('CUSTOMER SEGMENT'), findsOneWidget);

      await switchTo(tester, c, 'fr');
      expect(find.textContaining('SEGMENT DE CLIENTÈLE'), findsOneWidget);
      expect(find.textContaining('en France'), findsOneWidget);
      expect(find.text('Modifier'), findsOneWidget);
    });

    testWidgets('edited values stay, examples follow', (tester) async {
      final c = await pumpApp(tester, const ToolScreen(toolId: 'leanCanvas'));
      c.read(toolValuesProvider('leanCanvas').notifier).set('uvp', 'Our own');
      await tester.pumpAndSettle();

      await switchTo(tester, c, 'es');
      final out = find.textContaining('PROPUESTA DE VALOR ÚNICA');
      expect(out, findsOneWidget);
      expect(find.textContaining('Our own'), findsOneWidget);
      expect(find.textContaining('en España'), findsOneWidget);
    });

    testWidgets('choices show translated, templates follow', (tester) async {
      final c = await pumpApp(tester, const ToolScreen(toolId: 'appPrivacy'));
      await switchTo(tester, c, 'tr');
      final output = tester.widget<SelectableText>(find.byType(SelectableText));
      // The stored choice is English; the policy shows it in Turkish.
      expect(output.data, contains('HESAPLAR\nHesap yok.'));
      expect(output.data, endsWith('Kullanmadan önce bir avukata inceletin.'));
      await tester.tap(find.text('Düzenle'));
      await tester.pumpAndSettle();
      expect(find.text('Hesap yok'), findsOneWidget);
    });

    testWidgets('tracker stages and untouched samples', (tester) async {
      final c = await pumpApp(tester, const ToolScreen(toolId: 'kanban'));
      // Moving a sample on keeps it a sample; it still follows the language.
      c.read(listItemsProvider('kanban').notifier).advance('sample-1');
      await tester.pumpAndSettle();

      await switchTo(tester, c, 'tr');
      expect(find.text('Yapılıyor  2'), findsOneWidget);
      expect(find.text('Banka senkronizasyonu hata yönetimi'), findsOneWidget);
      expect(find.text('Ekle: görev'), findsOneWidget);

      await switchTo(tester, c, 'de');
      expect(find.text('Aufgabe hinzufügen'), findsOneWidget);
      expect(find.text('Fehlerbehandlung beim Bankabgleich'), findsOneWidget);
    });
  });
}
