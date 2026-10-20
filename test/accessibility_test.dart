import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/billing/entitlement_providers.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';
import 'package:startup_toolkits/features/paywall/free_limit_sheet.dart';
import 'package:startup_toolkits/features/paywall/paywall_screen.dart';
import 'package:startup_toolkits/features/tool/tool_screen.dart';
import 'package:startup_toolkits/project/project_store.dart';
import 'package:startup_toolkits/tools/catalog/catalog.dart';

import 'billing_test.dart' show FakeBilling;
import 'helpers.dart';

/// Small phone with large Dynamic Type: the hardest layout case we ship.
const _tight = (iPhoneSE, 2.0);

/// HIG and WCAG checks: 44 pt targets, labelled buttons, 4.5:1 contrast.
Future<void> expectGuidelines(WidgetTester tester) async {
  final handle = tester.ensureSemantics();
  await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
  await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  await expectLater(tester, meetsGuideline(textContrastGuideline));
  handle.dispose();
}

Future<MemoryKeyValueStore> onboardedStore() async {
  final kv = MemoryKeyValueStore();
  await OnboardingStore(kv).save(true);
  return kv;
}

void main() {
  group('main screens fit an iPhone SE at 2× text', () {
    testWidgets('welcome', (tester) async {
      await pumpRoot(tester, screen: _tight.$1, textScale: _tight.$2);
      await passIntro(tester);
      await scrollTo(tester, find.text('Raise funding'));
      await tester.tap(find.text('Raise funding'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      // Layout overflows fail the test on their own, with details.
    });

    for (final (i, tab) in ['Home', 'Project', 'My tools', 'Profile'].indexed) {
      testWidgets(tab, (tester) async {
        await pumpRoot(
          tester,
          kv: await onboardedStore(),
          screen: _tight.$1,
          textScale: _tight.$2,
        );
        if (i > 0) {
          await tester.tap(find.byType(NavigationDestination).at(i));
          await tester.pumpAndSettle();
        }
      });
    }

    testWidgets('paywall', (tester) async {
      await pumpApp(
        tester,
        const PaywallScreen(),
        overrides: [billingServiceProvider.overrideWithValue(FakeBilling())],
        screen: _tight.$1,
        textScale: _tight.$2,
      );
    });

    testWidgets('free limit sheet', (tester) async {
      await pumpApp(
        tester,
        Builder(
          builder: (context) => TextButton(
            onPressed: () =>
                showFreeLimitSheet(context, todaysToolId: 'runway'),
            child: const Text('open'),
          ),
        ),
        screen: _tight.$1,
        textScale: _tight.$2,
      );
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
    });
  });

  group('every tool fits an iPhone SE at 2× text', () {
    for (final tool in allTools) {
      testWidgets(tool.id, (tester) async {
        await pumpApp(
          tester,
          ToolScreen(toolId: tool.id),
          screen: _tight.$1,
          textScale: _tight.$2,
        );
      });
    }
  });

  group('accessibility guidelines', () {
    testWidgets('home', (tester) async {
      await pumpRoot(tester, kv: await onboardedStore());
      await expectGuidelines(tester);
    });

    testWidgets('project', (tester) async {
      await pumpRoot(tester, kv: await onboardedStore());
      await tester.tap(find.byType(NavigationDestination).at(1));
      await tester.pumpAndSettle();
      await expectGuidelines(tester);
    });

    testWidgets('profile', (tester) async {
      await pumpRoot(tester, kv: await onboardedStore());
      await tester.tap(find.byType(NavigationDestination).at(3));
      await tester.pumpAndSettle();
      await expectGuidelines(tester);
    });

    testWidgets('welcome', (tester) async {
      await pumpRoot(tester);
      await expectGuidelines(tester);
    });

    testWidgets('paywall', (tester) async {
      await pumpApp(
        tester,
        const PaywallScreen(),
        overrides: [billingServiceProvider.overrideWithValue(FakeBilling())],
      );
      await expectGuidelines(tester);
    });

    for (final id in ['runway', 'onePager', 'investorTracker']) {
      testWidgets('tool $id', (tester) async {
        await pumpApp(tester, ToolScreen(toolId: id));
        await expectGuidelines(tester);
      });
    }
  });

  group('VoiceOver', () {
    testWidgets('sliders announce their field and formatted value', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await pumpApp(tester, const ToolScreen(toolId: 'runway'));
      expect(
        tester.getSemantics(find.bySemanticsLabel('Cash in bank').last),
        matchesSemantics(
          label: 'Cash in bank',
          value: r'$120,000',
          increasedValue: r'$125,000',
          decreasedValue: r'$115,000',
          isSlider: true,
          isEnabled: true,
          isFocusable: true,
          hasEnabledState: true,
          hasIncreaseAction: true,
          hasDecreaseAction: true,
          hasFocusAction: true,
        ),
      );
      handle.dispose();
    });

    testWidgets('calculator result is read as one phrase', (tester) async {
      final handle = tester.ensureSemantics();
      await pumpApp(tester, const ToolScreen(toolId: 'runway'));
      expect(find.bySemanticsLabel('Runway: 11.4 months'), findsOneWidget);
      handle.dispose();
    });
  });

  group('Reduce Motion', () {
    // Test helpers turn Reduce Motion on, like the iOS setting.
    testWidgets('home has no running animations', (tester) async {
      await pumpRoot(tester, kv: await onboardedStore());
      expect(tester.binding.hasScheduledFrame, isFalse);
    });

    testWidgets('paywall has no running animations', (tester) async {
      await pumpApp(
        tester,
        const PaywallScreen(),
        overrides: [billingServiceProvider.overrideWithValue(FakeBilling())],
      );
      expect(tester.binding.hasScheduledFrame, isFalse);
    });
  });
}
