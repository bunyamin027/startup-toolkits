import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/billing/entitlement_providers.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';
import 'package:startup_toolkits/core/theme/app_theme.dart';
import 'package:startup_toolkits/core/theme/app_tokens.dart';
import 'package:startup_toolkits/features/onboarding/welcome_screen.dart';
import 'package:startup_toolkits/features/paywall/paywall_screen.dart';
import 'package:startup_toolkits/features/shell/app_shell.dart';
import 'package:startup_toolkits/features/tool/tool_screen.dart';
import 'package:startup_toolkits/tools/catalog/catalog.dart';

import 'billing_test.dart' show FakeBilling;
import 'helpers.dart';

/// WCAG 2.x contrast ratio of two opaque colors.
double contrast(Color a, Color b) {
  double lum(Color c) {
    double ch(double v) =>
        v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4) * 1.0;
    return 0.2126 * ch(c.r) + 0.7152 * ch(c.g) + 0.0722 * ch(c.b);
  }

  final (x, y) = (lum(a), lum(b));
  return (math.max(x, y) + 0.05) / (math.min(x, y) + 0.05);
}

void main() {
  for (final (name, theme) in [
    ('dark', AppTheme.dark),
    ('light', AppTheme.light),
  ]) {
    test('$name colors pass WCAG AA', () {
      final t = theme.extension<AppTokens>()!;
      final error = theme.colorScheme.error;
      for (final surface in [t.bg, t.surface1, t.surface2]) {
        for (final (role, color) in [
          ('text', t.text),
          ('muted', t.muted),
          ('accent', t.accent),
          ('blue', t.blue),
          ('error', error),
        ]) {
          expect(
            contrast(color, surface),
            greaterThanOrEqualTo(4.5),
            reason: '$role on $surface',
          );
        }
      }
      expect(contrast(t.onAccent, t.accent), greaterThanOrEqualTo(4.5));
      expect(
        contrast(theme.colorScheme.onError, error),
        greaterThanOrEqualTo(4.5),
      );
    });
  }

  group('light theme renders', () {
    final light = AppTheme.light;

    testWidgets('welcome', (tester) async {
      await pumpApp(tester, const WelcomeScreen(), theme: light);
      expect(
        Theme.of(tester.element(find.byType(WelcomeScreen))).brightness,
        Brightness.light,
      );
    });

    for (var i = 0; i < 4; i++) {
      testWidgets('tab $i', (tester) async {
        await pumpApp(tester, const AppShell(), theme: light);
        await tester.tap(find.byType(NavigationDestination).at(i));
        await tester.pumpAndSettle();
      });
    }

    testWidgets('paywall', (tester) async {
      await pumpApp(
        tester,
        const PaywallScreen(),
        overrides: [billingServiceProvider.overrideWithValue(FakeBilling())],
        theme: light,
      );
    });

    for (final tool in allTools) {
      testWidgets(tool.id, (tester) async {
        await pumpApp(tester, ToolScreen(toolId: tool.id), theme: light);
      });
    }
  });

  testWidgets('appearance picked in Profile applies and sticks', (
    tester,
  ) async {
    Brightness brightness() =>
        Theme.of(tester.element(find.byType(AppShell))).brightness;

    final kv = MemoryKeyValueStore();
    await pumpRoot(tester, kv: kv);
    await onboard(tester);
    // Test devices report light mode; the default follows the system.
    expect(brightness(), Brightness.light);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Appearance'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Appearance'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dark').last);
    await tester.pumpAndSettle();
    expect(brightness(), Brightness.dark);
    expect(find.text('Dark'), findsOneWidget);

    await pumpRoot(tester, kv: kv);
    expect(brightness(), Brightness.dark);
  });
}
