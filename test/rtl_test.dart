import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/billing/entitlement_providers.dart';
import 'package:startup_toolkits/features/onboarding/welcome_screen.dart';
import 'package:startup_toolkits/features/paywall/paywall_screen.dart';
import 'package:startup_toolkits/features/shell/app_shell.dart';
import 'package:startup_toolkits/features/tool/tool_screen.dart';
import 'package:startup_toolkits/tools/catalog/catalog.dart';

import 'billing_test.dart' show FakeBilling;
import 'helpers.dart';

/// The plan targets Arabic after launch (§13), so every screen must lay out
/// right to left already. Overflows fail these tests on their own.
void main() {
  const rtl = TextDirection.rtl;

  group('main screens render right to left', () {
    testWidgets('welcome', (tester) async {
      await pumpApp(
        tester,
        const WelcomeScreen(),
        direction: rtl,
      ); // Skip sits at the end of the top bar, which is the left in RTL.
      expect(tester.getCenter(find.text('Skip')).dx, lessThan(100));
    });

    for (final (i, tab) in ['Home', 'Project', 'My tools', 'Profile'].indexed) {
      testWidgets(tab, (tester) async {
        await pumpApp(tester, const AppShell(), direction: rtl);
        await tester.tap(find.byType(NavigationDestination).at(i));
        await tester.pumpAndSettle();
      });
    }

    testWidgets('home header and tool tiles mirror', (tester) async {
      await pumpApp(tester, const AppShell(), direction: rtl);
      final header = tester.getTopRight(find.text('MISSION CONTROL'));
      expect(header.dx, closeTo(iPhone15.width - 20, 1));
      // The chevron sits at the start (left) of a tile in RTL.
      final tile = tester.getRect(find.text('Lean Canvas').first);
      final chevron = tester.getCenter(find.byIcon(Icons.chevron_right).first);
      expect(chevron.dx, lessThan(tile.left));
    });

    testWidgets('paywall', (tester) async {
      await pumpApp(
        tester,
        const PaywallScreen(),
        overrides: [billingServiceProvider.overrideWithValue(FakeBilling())],
        direction: rtl,
      );
    });
  });

  group('every tool renders right to left', () {
    for (final tool in allTools) {
      testWidgets(tool.id, (tester) async {
        await pumpApp(tester, ToolScreen(toolId: tool.id), direction: rtl);
      });
    }
  });
}
