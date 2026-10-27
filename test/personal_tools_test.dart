import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/features/tool/tool_screen.dart';
import 'package:startup_toolkits/project/field_mapper.dart';
import 'package:startup_toolkits/project/project.dart';
import 'package:startup_toolkits/project/project_providers.dart';
import 'package:startup_toolkits/tools/tool_def.dart';

import 'helpers.dart';

/// What onboarding leaves behind: a name and a one-liner, nothing else.
final _onboarded = const Project()
    .withValue(ProjectField.startupName, 'Kahve Rotası')
    .withValue(
      ProjectField.oneLiner,
      'Specialty coffee subscriptions for offices',
    );

String _output(WidgetTester tester) => tester
    .widget<SelectableText>(find.byType(SelectableText))
    .textSpan!
    .toPlainText();

void main() {
  group('after onboarding, tools are the user\'s own', () {
    testWidgets('Lean Canvas shows no example startup content', (tester) async {
      await pumpApp(
        tester,
        const ToolScreen(toolId: 'leanCanvas'),
        overrides: [initialProjectProvider.overrideWithValue(_onboarded)],
      );
      final out = _output(tester);
      expect(out, contains('LEAN CANVAS: Kahve Rotası'));
      // The one-liner answers "unique value proposition".
      expect(out, contains('Specialty coffee subscriptions for offices'));
      // Nothing from the bookkeeping example startup.
      for (final example in [
        'Nimbly',
        'bookkeeping',
        'tax',
        'Freelance',
        'CPA',
      ]) {
        expect(
          out.toLowerCase(),
          isNot(contains(example.toLowerCase())),
          reason: example,
        );
      }
      // Empty sections are marked, and the card says what is left.
      expect(out, contains('[Problem]'));
      // Startup name and value proposition come from onboarding.
      expect(find.text('2 of 10 fields filled'), findsOneWidget);
    });

    testWidgets('Fill in opens Edit with examples as hints only', (
      tester,
    ) async {
      final c = await pumpApp(
        tester,
        const ToolScreen(toolId: 'leanCanvas'),
        overrides: [initialProjectProvider.overrideWithValue(_onboarded)],
      );
      await tester.tap(find.text('Fill in'));
      await tester.pumpAndSettle();

      final problem = tester.widget<TextField>(
        find.widgetWithText(TextField, 'Problem'),
      );
      expect(problem.controller!.text, isEmpty);
      expect(problem.decoration!.hintText, startsWith('e.g. Freelancers lose'));

      // Typing fills the document and the project.
      await tester.enterText(
        find.widgetWithText(TextField, 'Problem'),
        'Office coffee is bad and nobody owns the order',
      );
      await tester.pump();
      expect(
        c.read(projectProvider)[ProjectField.problem],
        'Office coffee is bad and nobody owns the order',
      );
    });

    testWidgets('trackers start empty instead of with made-up people', (
      tester,
    ) async {
      await pumpApp(
        tester,
        const ToolScreen(toolId: 'investorTracker'),
        overrides: [initialProjectProvider.overrideWithValue(_onboarded)],
      );
      expect(find.text('Maya Chen'), findsNothing);
      expect(find.text('Nothing here yet. Tap Add to start.'), findsOneWidget);
    });

    testWidgets('template checklists keep their ready-made steps', (
      tester,
    ) async {
      await pumpApp(
        tester,
        const ToolScreen(toolId: 'onboardingChecklist'),
        overrides: [initialProjectProvider.overrideWithValue(_onboarded)],
      );
      expect(find.text('Send offer letter and contract'), findsOneWidget);
    });

    testWidgets('calculators keep example numbers so they show a result', (
      tester,
    ) async {
      await pumpApp(
        tester,
        const ToolScreen(toolId: 'runway'),
        overrides: [initialProjectProvider.overrideWithValue(_onboarded)],
      );
      expect(find.text('11.4 months'), findsOneWidget);
    });
  });

  testWidgets('without a project, tools stay a demo with example data', (
    tester,
  ) async {
    await pumpApp(tester, const ToolScreen(toolId: 'leanCanvas'));
    expect(_output(tester), contains('Terralab'));
    expect(find.textContaining('fields filled'), findsNothing);
  });

  test('the value proposition field maps to the one-liner', () {
    const field = FieldDef(
      key: 'uvp',
      label: 'Unique value proposition',
      type: FieldType.text,
    );
    expect(FieldMapper.match(field), ProjectField.oneLiner);
  });
}
