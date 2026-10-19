import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/billing/entitlement.dart';

import 'helpers.dart';

void main() {
  testWidgets('onboarding fills the project and personalizes Home', (
    tester,
  ) async {
    await pumpRoot(tester);
    expect(find.text('What are you building toward?'), findsOneWidget);

    await onboard(tester);

    expect(find.text('MISSION CONTROL'), findsOneWidget);
    expect(find.text('Rocketly'), findsOneWidget);
    expect(find.text('Trial · 14 days left'), findsOneWidget);
    expect(find.text('Shape the idea'), findsOneWidget);
    expect(
      find.textContaining('Lean Canvas · Adds problem, solution'),
      findsOneWidget,
    );
    expect(find.text('START HERE · RAISE FUNDING'), findsOneWidget);
    expect(find.text('Pitch deck wizard'), findsOneWidget);
  });

  testWidgets('skip goes straight to Home with defaults', (tester) async {
    await pumpRoot(tester);
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Your startup'), findsOneWidget);
    expect(find.text('START HERE'), findsOneWidget);
  });

  testWidgets('onboarding is remembered across launches', (tester) async {
    final kv = await pumpRoot(tester);
    await onboard(tester);
    await pumpRoot(tester, kv: kv);
    expect(find.text('Rocketly'), findsOneWidget);
    expect(find.text('What are you building toward?'), findsNothing);
  });

  testWidgets('next best step opens the tool, which then shows as recent', (
    tester,
  ) async {
    await pumpRoot(tester);
    await onboard(tester);
    await tester.tap(find.text('Shape the idea'));
    await tester.pumpAndSettle();
    expect(find.textContaining('LEAN CANVAS: Rocketly'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text('RECENTLY USED'));
    expect(find.text('RECENTLY USED'), findsOneWidget);
  });

  testWidgets('search opens Discover and filters tools', (tester) async {
    await pumpRoot(tester);
    await onboard(tester);
    await tester.tap(find.text('Search 45 tools'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'invoice');
    await tester.pumpAndSettle();
    expect(find.text('Invoice generator'), findsOneWidget);
    expect(find.text('SWOT analysis'), findsNothing);
  });

  testWidgets('project tab: ring, unlock chips and field editing', (
    tester,
  ) async {
    await pumpRoot(tester);
    await onboard(tester);
    await tester.tap(find.text('Project').last);
    await tester.pumpAndSettle();
    expect(find.text('2/13'), findsOneWidget);

    await tester.tap(find.widgetWithText(ActionChip, 'Problem'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextField).last,
      'Founders waste months on fundraising admin',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('3/13'), findsOneWidget);
    await scrollTo(
      tester,
      find.text('Founders waste months on fundraising admin'),
    );
    expect(
      find.text('Founders waste months on fundraising admin'),
      findsOneWidget,
    );
  });

  testWidgets('project edits reach tools on next open', (tester) async {
    await pumpRoot(tester);
    await onboard(tester);
    await tester.tap(find.text('Pitch deck wizard'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Rocketly: Fundraising copilot'),
      findsOneWidget,
    );
  });

  testWidgets('my tools shows favorites', (tester) async {
    await pumpRoot(tester);
    await onboard(tester);
    await tester.tap(find.text('My tools'));
    await tester.pumpAndSettle();
    expect(
      find.text('Tap the star in any tool to keep it here.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pitch deck wizard'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Add to favorites'));
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('My tools'));
    await tester.pumpAndSettle();
    expect(
      find.text('Tap the star in any tool to keep it here.'),
      findsNothing,
    );
    expect(find.text('Pitch deck wizard'), findsWidgets);
  });

  testWidgets('delete all data returns to welcome but keeps the trial clock', (
    tester,
  ) async {
    final kv = await pumpRoot(tester);
    await onboard(tester);
    final before = await EntitlementStore(kv).load(DateTime.now());

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await scrollTo(tester, find.text('Delete all data'));
    await tester.tap(find.text('Delete all data'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(find.text('What are you building toward?'), findsOneWidget);
    final after = await EntitlementStore(kv).load(DateTime.now());
    expect(after.firstLaunch, before.firstLaunch);
  });
}
