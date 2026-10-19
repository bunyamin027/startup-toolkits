import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/tools/tool_def.dart';

void main() {
  test('defaults map holds example value of every field', () {
    const tool = ToolDef(
      id: 'runway',
      name: 'Runway',
      category: ToolCategory.finance,
      kind: ToolKind.calc,
      description: '',
      icon: Icons.build,
      formula: 'runway',
      fields: [
        FieldDef(
          key: 'cash',
          label: 'Cash',
          type: FieldType.money,
          defaultValue: 120000,
        ),
        FieldDef(key: 'note', label: 'Note', type: FieldType.text),
      ],
    );
    expect(tool.defaults, {'cash': 120000, 'note': null});
    expect(tool.validate(), isNull);
  });

  test('validate catches incomplete definitions', () {
    const noFormula = ToolDef(
      id: 'x',
      name: 'X',
      category: ToolCategory.finance,
      kind: ToolKind.calc,
      description: '',
      icon: Icons.build,
    );
    expect(noFormula.validate(), contains('formula'));

    const missingVariant = ToolDef(
      id: 'privacy',
      name: 'Privacy',
      category: ToolCategory.legal,
      kind: ToolKind.doc,
      description: '',
      icon: Icons.build,
      templateField: 'law',
      templates: {'GDPR': '...'},
      fields: [
        FieldDef(
          key: 'law',
          label: 'Law',
          type: FieldType.choice,
          options: ['GDPR', 'CCPA'],
        ),
      ],
    );
    expect(missingVariant.validate(), contains('CCPA'));

    const noStages = ToolDef(
      id: 'crm',
      name: 'CRM',
      category: ToolCategory.sales,
      kind: ToolKind.list,
      description: '',
      icon: Icons.build,
    );
    expect(noStages.validate(), contains('stages'));
  });
}
