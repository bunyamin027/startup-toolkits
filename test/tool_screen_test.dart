import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';
import 'package:startup_toolkits/features/tool/tool_screen.dart';
import 'package:startup_toolkits/project/project.dart';
import 'package:startup_toolkits/project/project_providers.dart';
import 'package:startup_toolkits/tools/catalog/catalog.dart';
import 'package:startup_toolkits/tools/tool_providers.dart';
import 'package:startup_toolkits/tools/tool_stores.dart';

import 'helpers.dart';

void main() {
  group('every tool opens with example data', () {
    for (final tool in allTools) {
      testWidgets(tool.id, (tester) async {
        await pumpApp(tester, ToolScreen(toolId: tool.id));
        expect(tester.takeException(), isNull);
        expect(find.text(tool.name), findsOneWidget);
      });
    }
  });

  group('calculator', () {
    testWidgets('runway shows the plan example result', (tester) async {
      await pumpApp(tester, const ToolScreen(toolId: 'runway'));
      expect(find.text('11.4 months'), findsOneWidget);
      expect(find.text(r'$10,500'), findsOneWidget);
      expect(find.text('Save to project'), findsOneWidget);
    });

    testWidgets('project values prefill the inputs', (tester) async {
      await pumpApp(
        tester,
        const ToolScreen(toolId: 'runway'),
        overrides: [
          initialProjectProvider.overrideWithValue(
            const Project().withValue(ProjectField.cash, '210000'),
          ),
        ],
      );
      // 210,000 / 10,500 = 20 months
      expect(find.text('20.0 months'), findsOneWidget);
    });

    testWidgets('save to project writes mapped fields', (tester) async {
      final container = await pumpApp(
        tester,
        const ToolScreen(toolId: 'runway'),
      );
      await tester.tap(find.text('Save to project'));
      await tester.pump();
      final project = container.read(projectProvider);
      expect(project[ProjectField.cash], '120000');
      expect(project[ProjectField.monthlyExpenses], '14000');
      expect(find.text('Saved 3 fields to your project'), findsOneWidget);
    });
  });

  group('generator', () {
    testWidgets('editing a field updates the result and the project', (
      tester,
    ) async {
      final kv = MemoryKeyValueStore();
      final container = await pumpApp(
        tester,
        const ToolScreen(toolId: 'onePager'),
        kv: kv,
      );
      expect(find.textContaining('TERRALAB'), findsOneWidget);

      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextField, 'Startup name'),
        'Rocketly',
      );
      await tester.tap(find.text('Result'));
      await tester.pumpAndSettle();

      expect(find.textContaining('ROCKETLY'), findsOneWidget);
      expect(
        container.read(projectProvider)[ProjectField.startupName],
        'Rocketly',
      );
      expect(
        (await ToolValuesStore(kv).load('onePager'))!['company'],
        'Rocketly',
      );
    });

    testWidgets('template variant switches from the result tab', (
      tester,
    ) async {
      await pumpApp(tester, const ToolScreen(toolId: 'emailTemplates'));
      expect(find.textContaining('Subject: Quick question'), findsOneWidget);
      await tester.tap(find.text('Investor update'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Highlights'), findsOneWidget);
    });

    testWidgets('legal output ends with the disclaimer', (tester) async {
      await pumpApp(tester, const ToolScreen(toolId: 'nda'));
      expect(find.textContaining('not legal advice'), findsOneWidget);
    });
  });

  group('tracker', () {
    testWidgets('opens with samples and advances a stage', (tester) async {
      final container = await pumpApp(
        tester,
        const ToolScreen(toolId: 'investorTracker'),
      );
      expect(find.text('Maya Chen'), findsOneWidget);
      expect(find.text('All  3'), findsOneWidget);

      await tester.tap(find.byTooltip('Move to Committed'));
      await tester.pumpAndSettle();
      expect(find.byTooltip('Move to Committed'), findsNothing);
      // Committed is an outcome: no arrow on to Passed.
      expect(find.byTooltip('Move to Passed'), findsNothing);
      final maya = container
          .read(listItemsProvider('investorTracker'))
          .value!
          .firstWhere((i) => i.title == 'Maya Chen');
      expect(maya.stage, 'Committed');
    });

    testWidgets('adds an item through the sheet', (tester) async {
      await pumpApp(tester, const ToolScreen(toolId: 'kanban'));
      await tester.tap(find.text('Add task'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextField, 'Task'),
        'Write privacy policy',
      );
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Add'));
      await tester.pumpAndSettle();
      expect(find.text('Write privacy policy'), findsOneWidget);
      expect(find.text('To do  2'), findsOneWidget);
    });

    testWidgets('swipe deletes and undo restores', (tester) async {
      await pumpApp(tester, const ToolScreen(toolId: 'kanban'));
      await tester.drag(
        find.text('Install probes at pilot farm 12'),
        const Offset(-600, 0),
      );
      await tester.pumpAndSettle();
      expect(find.text('Install probes at pilot farm 12'), findsNothing);
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();
      expect(find.text('Install probes at pilot farm 12'), findsOneWidget);
    });
  });

  testWidgets('favorite toggles from the app bar', (tester) async {
    final container = await pumpApp(tester, const ToolScreen(toolId: 'swot'));
    await tester.tap(find.byTooltip('Add to favorites'));
    await tester.pump();
    expect(container.read(favoritesProvider), {'swot'});
  });
}
