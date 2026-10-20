import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/project/field_mapper.dart';
import 'package:startup_toolkits/project/project.dart';
import 'package:startup_toolkits/tools/tool_def.dart';

FieldDef f(String key, String label, {bool autofill = true}) =>
    FieldDef(key: key, label: label, type: FieldType.text, autofill: autofill);

void main() {
  group('label matching', () {
    final cases = {
      'Company name': ProjectField.startupName,
      'Product name': ProjectField.startupName,
      'App name': ProjectField.startupName,
      'Developer': ProjectField.startupName,
      'Problem': ProjectField.problem,
      'Top 3 problems': null,
      'Solution': ProjectField.solution,
      'Customer segments': null,
      'Customer segment': ProjectField.targetCustomer,
      'Target audience': ProjectField.targetCustomer,
      'Market size': ProjectField.marketSize,
      'Traction': ProjectField.traction,
      'The ask': ProjectField.ask,
      'Team': ProjectField.team,
      'Contact email': ProjectField.contactEmail,
      'Support email': ProjectField.contactEmail,
      'Cash in bank': ProjectField.cash,
      'Monthly expenses': ProjectField.monthlyExpenses,
      'Monthly revenue': ProjectField.monthlyRevenue,
      'Job title': null,
    };
    cases.forEach((label, expected) {
      test('"$label" → ${expected?.name}', () {
        expect(FieldMapper.match(f('x', label)), expected);
      });
    });

    test('autofill: false opts out', () {
      expect(
        FieldMapper.match(f('x', 'Company name', autofill: false)),
        isNull,
      );
    });
  });

  const pitch = ToolDef(
    id: 'onePager',
    name: 'One-pager',
    category: ToolCategory.investors,
    kind: ToolKind.doc,
    description: '',
    icon: Icons.build,
    template: '',
    fields: [
      FieldDef(
        key: 'company',
        label: 'Company name',
        type: FieldType.text,
        defaultValue: 'Acme',
      ),
      FieldDef(
        key: 'problem',
        label: 'Problem',
        type: FieldType.multiline,
        defaultValue: 'Example problem',
      ),
      FieldDef(key: 'ask', label: 'The ask', type: FieldType.text),
    ],
  );

  final project = const Project()
      .withValue(ProjectField.startupName, 'Rocketly')
      .withValue(ProjectField.problem, '  ');

  test('initial values overlay project data on example data', () {
    expect(FieldMapper.initialValues(pitch, project), {
      'company': 'Rocketly',
      'problem': 'Example problem', // blank project field keeps the example
      'ask': null,
    });
  });

  test('write back updates the project from tool edits', () {
    final updated = FieldMapper.writeBack(pitch, {
      'company': 'Rocketly',
      'problem': 'Founders juggle 20 tools',
      'ask': r'$500k pre-seed',
    }, project);
    expect(updated[ProjectField.problem], 'Founders juggle 20 tools');
    expect(updated[ProjectField.ask], r'$500k pre-seed');
    expect(updated.filledCount, 3);
  });

  test('trackers never auto-fill or write back', () {
    const crm = ToolDef(
      id: 'crm',
      name: 'Mini CRM',
      category: ToolCategory.sales,
      kind: ToolKind.list,
      description: '',
      icon: Icons.build,
      stages: ['Lead'],
      fields: [
        FieldDef(key: 'company', label: 'Company', type: FieldType.text),
      ],
    );
    expect(FieldMapper.prefill(crm, project), isEmpty);
    expect(
      FieldMapper.writeBack(crm, {'company': 'Customer Inc'}, project),
      same(project),
    );
  });

  test('project brief and completion', () {
    final p = const Project()
        .withValue(ProjectField.startupName, 'Rocketly')
        .withValue(ProjectField.problem, 'Too many tools');
    expect(p.brief(), 'Startup name: Rocketly\nProblem: Too many tools');
    expect(p.completion, closeTo(2 / 13, 1e-9));
  });
}
