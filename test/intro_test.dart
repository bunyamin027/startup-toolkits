import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/core/bootstrap.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';
import 'package:startup_toolkits/core/theme/app_theme.dart';
import 'package:startup_toolkits/features/onboarding/intro.dart';
import 'package:startup_toolkits/features/onboarding/welcome_screen.dart';
import 'package:startup_toolkits/l10n/locale_providers.dart';
import 'package:startup_toolkits/main.dart';

import 'helpers.dart';

/// The first-run story: three slides before the goal question.
void main() {
  testWidgets('slides tell the story, then ask for the goal', (tester) async {
    await pumpApp(tester, const WelcomeScreen());
    expect(find.text('Every tool your startup needs. In one app.'), findsOne);
    expect(find.text('45'), findsWidgets);
    expect(find.text('Raise funding'), findsNothing);

    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Type it once. Every tool fills itself.'), findsOne);
    // The demo lands the example name in real tools.
    expect(find.text('Pitch deck wizard'), findsOne);
    expect(find.text('Nimbly'), findsWidgets);

    await tester.tap(find.widgetWithText(FilledButton, 'Continue'));
    await tester.pumpAndSettle();
    expect(find.text('Know your numbers before investors ask.'), findsOne);
    // Real calculator output, not a picture.
    expect(find.text('11.4 months'), findsOne);
    expect(find.text('No account. Your data stays on your device.'), findsOne);

    await tester.tap(find.widgetWithText(FilledButton, "Let's get started"));
    await tester.pumpAndSettle();
    expect(find.text('Raise funding'), findsOne);

    // Back returns to the last slide.
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.text('Know your numbers before investors ask.'), findsOne);
  });

  testWidgets('swiping moves between slides', (tester) async {
    await pumpApp(tester, const WelcomeScreen());
    await tester.fling(find.byType(PageView), const Offset(-400, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.text('Type it once. Every tool fills itself.'), findsOne);
    expect(find.bySemanticsLabel('Step 2 of 3'), findsOne);
  });

  testWidgets('Skip on the intro goes to the goal question', (tester) async {
    await pumpApp(tester, const WelcomeScreen());
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Raise funding'), findsOne);
  });

  for (final code in languageNames.keys) {
    for (final (name, theme) in [
      ('dark', AppTheme.dark),
      ('light', AppTheme.light),
    ]) {
      testWidgets('every slide fits an iPhone SE at 2× text ($code, $name)', (
        tester,
      ) async {
        await pumpApp(
          tester,
          const WelcomeScreen(),
          locale: Locale(code),
          screen: iPhoneSE,
          textScale: 2,
          theme: theme,
        );
        for (var i = 0; i < 2; i++) {
          await tester.fling(
            find.byType(PageView),
            const Offset(-400, 0),
            1000,
          );
          await tester.pumpAndSettle();
        }
        // Overflows fail the test on their own.
      });
    }
  }

  testWidgets('with motion on, the intro animates and stays error-free', (
    tester,
  ) async {
    setScreen(tester, iPhone15, 1);
    final kv = MemoryKeyValueStore();
    await tester.pumpWidget(
      AppRoot(kv: kv, overrides: await loadAppState(kv, DateTime.now())),
    );
    // Orbit, glow and counters keep ticking; walk all slides mid-motion.
    for (var i = 0; i < introSlideCount; i++) {
      await tester.pump(const Duration(milliseconds: 1600));
      expect(tester.binding.hasScheduledFrame, isTrue);
      await tester.tap(find.byType(FilledButton));
      await tester.pump(const Duration(milliseconds: 600));
    }
    expect(find.text('Raise funding'), findsOne);
    expect(tester.takeException(), isNull);
    // Unmount so endless animations stop before the test ends.
    await tester.pumpWidget(const SizedBox());
  });
}
