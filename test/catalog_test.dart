import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/engines/calc_engine.dart';
import 'package:startup_toolkits/engines/doc_engine.dart';
import 'package:startup_toolkits/project/field_mapper.dart';
import 'package:startup_toolkits/project/project.dart';
import 'package:startup_toolkits/tools/catalog/catalog.dart';
import 'package:startup_toolkits/tools/catalog/goal_picks.dart';
import 'package:startup_toolkits/tools/tool_def.dart';

void main() {
  test('45 tools: 8 calculators, 23 generators, 14 trackers', () {
    expect(allTools, hasLength(45));
    int count(ToolKind k) => allTools.where((t) => t.kind == k).length;
    expect(count(ToolKind.calc), 8);
    expect(count(ToolKind.doc), 23);
    expect(count(ToolKind.list), 14);
  });

  test('category sizes match the plan', () {
    expect(
      {for (final c in ToolCategory.values) c: toolsIn(c).length},
      {
        ToolCategory.ideaValidation: 6,
        ToolCategory.finance: 6,
        ToolCategory.investors: 4,
        ToolCategory.product: 5,
        ToolCategory.marketing: 6,
        ToolCategory.sales: 4,
        ToolCategory.legal: 3,
        ToolCategory.team: 4,
        ToolCategory.growth: 3,
        ToolCategory.mobileApp: 4,
      },
    );
  });

  test('ids are unique and every tool has a goal', () {
    expect(allTools.map((t) => t.id).toSet(), hasLength(45));
    for (final t in allTools) {
      expect(t.goals, isNotEmpty, reason: t.id);
    }
  });

  for (final tool in allTools) {
    group(tool.id, () {
      test('definition is valid and opens with example data', () {
        expect(tool.validate(), isNull);
        for (final f in tool.fields) {
          expect(f.defaultValue, isNotNull, reason: '${tool.id}.${f.key}');
          if (f.type == FieldType.choice) {
            expect(f.options, contains(f.defaultValue));
          }
        }
      });

      switch (tool.kind) {
        case ToolKind.calc:
          test('formula runs on defaults without NaN', () {
            final r = CalcEngine.run(tool.formula!, tool.defaults);
            for (final o in r.outputs) {
              expect(o.value.isNaN, isFalse, reason: o.key);
            }
            final hero = tool.heroOutput;
            if (hero != null) {
              expect(r.outputs.map((o) => o.key), contains(hero));
            }
            for (final f in tool.fields) {
              if (f.min != null) {
                expect(f.max, isNotNull);
                expect(
                  f.defaultValue! as num,
                  inInclusiveRange(f.min!, f.max!),
                );
              }
            }
          });
        case ToolKind.doc:
          test('every template renders fully from defaults', () {
            final keys = tool.fields.map((f) => f.key).toSet();
            final templates = tool.templates.isEmpty
                ? {'': tool.template!}
                : tool.templates;
            templates.forEach((variant, template) {
              expect(
                DocEngine.placeholderKeys(template).difference(keys),
                isEmpty,
                reason: '${tool.id} $variant: unknown placeholder',
              );
              expect(
                DocEngine.expressionVariables(template).difference(keys),
                isEmpty,
                reason: '${tool.id} $variant: unknown variable',
              );
              final values = {
                ...tool.defaults,
                if (tool.templateField != null) tool.templateField!: variant,
              };
              final out = DocEngine.renderTool(tool, values);
              expect(
                out,
                isNot(matches(RegExp(r'\[[A-Z][^\]]*\]'))),
                reason: '${tool.id} $variant: empty placeholder in output',
              );
              expect(out.contains('{'), isFalse, reason: tool.id);
            });
            expect(
              DocEngine.renderTool(
                tool,
                tool.defaults,
              ).endsWith(DocEngine.legalNotice),
              tool.legalDisclaimer,
            );
          });
        case ToolKind.list:
          test('has sample items whose fields exist', () {
            expect(tool.samples, isNotEmpty);
            final keys = tool.fields.map((f) => f.key).toSet();
            for (final s in tool.samples) {
              expect(keys.containsAll(s.fields.keys), isTrue, reason: s.title);
            }
          });
      }
    });
  }

  test('legal tools all carry the disclaimer', () {
    for (final t in toolsIn(ToolCategory.legal)) {
      expect(t.legalDisclaimer, isTrue, reason: t.id);
    }
    expect(toolById('appPrivacy')!.legalDisclaimer, isTrue);
  });

  test('counterparty fields never auto-fill from the project', () {
    const counterparty = {'client', 'otherParty', 'recipient', 'name'};
    for (final t in allTools) {
      for (final f in t.fields.where((f) => counterparty.contains(f.key))) {
        expect(FieldMapper.match(f), isNull, reason: '${t.id}.${f.key}');
      }
    }
  });

  test('key project fields are reachable from tools', () {
    final reached = {
      for (final t in allTools)
        if (t.kind != ToolKind.list)
          for (final f in t.fields) ?FieldMapper.match(f),
    };
    expect(reached, containsAll(ProjectField.values));
  });

  test('Start here picks exist and fit their goal', () {
    expect(goalPicks.keys, containsAll([...Goal.values, null]));
    goalPicks.forEach((goal, ids) {
      expect(ids.toSet(), hasLength(ids.length));
      for (final id in ids) {
        final tool = toolById(id);
        expect(tool, isNotNull, reason: id);
        if (goal != null)
          expect(tool!.goals, contains(goal), reason: '$goal $id');
      }
    });
  });
}
