import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/features/onboarding/onboarding_steps.dart';
import 'package:startup_toolkits/core/theme/app_theme.dart';
import 'package:startup_toolkits/features/onboarding/welcome_screen.dart';
import 'package:startup_toolkits/l10n/l10n.dart';
import 'package:startup_toolkits/project/project.dart';
import 'package:startup_toolkits/tools/tool_def.dart';

import 'helpers.dart';

void main() {
  testWidgets('continue appears only after a goal, which shows its tools', (
    tester,
  ) async {
    await pumpApp(tester, const WelcomeScreen());
    await passIntro(tester);

    expect(find.text('Step 1 of 2'), findsNothing); // label is semantic only
    final cta = find.widgetWithText(FilledButton, 'Continue');
    expect(
      find
          .ancestor(of: cta, matching: find.byType(IgnorePointer))
          .evaluate()
          .any((e) => (e.widget as IgnorePointer).ignoring),
      isTrue,
    );
    expect(find.text('READY FOR YOU'), findsNothing);

    await tester.tap(find.text('Raise funding'));
    await tester.pumpAndSettle();
    expect(find.text('READY FOR YOU'), findsOneWidget);
    expect(find.text('Pitch deck wizard'), findsOneWidget);
    expect(find.text('Runway & burn rate'), findsOneWidget);

    await tester.tap(find.text('Launch my app'));
    await tester.pumpAndSettle();
    expect(find.text('Store listing writer'), findsOneWidget);
    expect(find.text('Pitch deck wizard'), findsNothing);

    await tester.tap(cta);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextField, 'Startup name'), findsOneWidget);
  });

  testWidgets('the document preview fills in while typing', (tester) async {
    await pumpApp(tester, const WelcomeScreen());
    await passIntro(tester);
    await tester.tap(find.text('Find first customers'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    // The category chips sit above the fields; the preview is further down.
    await tester.scrollUntilVisible(
      find.text('FILLS IN AUTOMATICALLY'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Your startup'), findsOneWidget);
    expect(find.text('FILLS IN AUTOMATICALLY'), findsOneWidget);
    await tester.enterText(
      find.widgetWithText(TextField, 'Startup name'),
      'Kahve Rotası',
    );
    await tester.pumpAndSettle();
    expect(find.text('Your startup'), findsNothing);
    // Typed name in the field and on the preview cover.
    expect(find.text('Kahve Rotası'), findsNWidgets(2));
  });

  testWidgets('launch reveal shows the path and can be tapped away', (
    tester,
  ) async {
    var done = 0;
    final project = const Project()
        .withValue(ProjectField.startupName, 'Kahve Rotası')
        .withGoal(Goal.firstCustomers);
    // Motion on, so the reveal waits instead of finishing at once; its
    // pulse never settles, so time is advanced by hand.
    setScreen(tester, iPhone15, 1);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: LaunchReveal(project: project, onDone: () => done++),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.text('Kahve Rotası'), findsOneWidget);
    expect(find.text('Your mission control is ready'), findsOneWidget);
    expect(find.text('First step: Shape the idea'), findsOneWidget);
    expect(done, 0);

    await tester.tap(find.text('Kahve Rotası'));
    await tester.pump();
    expect(done, 1);
    // The timer does not fire a second time.
    await tester.pump(const Duration(seconds: 3));
    expect(done, 1);
  });
}
