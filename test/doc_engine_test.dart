import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/engines/doc_engine.dart';
import 'package:startup_toolkits/engines/inputs.dart';
import 'package:startup_toolkits/tools/tool_def.dart';

void main() {
  group('placeholders', () {
    test('fills values and marks empty ones with their label', () {
      final out = DocEngine.render(
        'Hi {name}, {company} solves {problem}.',
        {'name': 'Ada', 'company': '  ', 'problem': null},
        labels: {'company': 'Company'},
      );
      expect(out, 'Hi Ada, [Company] solves [problem].');
    });
  });

  test('filters', () {
    String r(String t, Object? v) => DocEngine.render(t, {'k': v});
    expect(r('{k|cap}ly', 'rocket'), 'Rocketly');
    expect(r('{k|tag}', 'rocket ship!'), 'RocketShip');
    expect(r('{k|slug}', ' My App, v2! '), 'my-app-v2');
    expect(r('{k|upper}', 'ab'), 'AB');
    expect(r('{k|first}', 'Seed round'), 'Seed');
    expect(r('{k|bullets}', 'a\n\n b '), '• a\n• b');
    expect(r('{k|money}', 4500), r'$4,500');
    expect(r('{k}', 1000.0), '1000');
    expect(r('{k|cap}', ''), '[k]');
    expect(() => r('{k|nope}', 'x'), throwsFormatException);
  });

  test('placeholder and expression keys', () {
    const t = 'Hi {name|cap} {=qty * price|money} {=round(tax)}';
    expect(DocEngine.placeholderKeys(t), {'name'});
    expect(DocEngine.expressionVariables(t), {'qty', 'price', 'tax'});
  });

  group('expressions', () {
    double eval(String e, [Map<String, Object?> v = const {}]) =>
        DocEngine.evaluate(e, Inputs(v));

    test('precedence, parentheses, unary minus', () {
      expect(eval('2 + 3 * 4'), 14);
      expect(eval('(2 + 3) * 4'), 20);
      expect(eval('-2 * -3'), 6);
      expect(eval('10 - 4 - 3'), 3);
      expect(eval('12 / 4 / 3'), 1);
    });

    test('functions and variables', () {
      expect(eval('round(a / 3)', {'a': 10}), 3);
      expect(eval('max(a, b) - min(a, b)', {'a': 4, 'b': '9'}), 5);
      expect(eval('missing + 1'), 1);
    });

    test('division by zero yields 0 instead of infinity in documents', () {
      expect(eval('5 / 0'), 0);
    });

    test('syntax errors throw', () {
      expect(() => eval('2 +'), throwsFormatException);
      expect(() => eval('(1 + 2'), throwsFormatException);
      expect(() => eval('foo(1, 2, 3)'), throwsFormatException);
    });
  });

  test('invoice total', () {
    const template =
        'Subtotal: {=qty1 * price1 + qty2 * price2|money}\n'
        'Tax ({taxRate}%): {=(qty1 * price1 + qty2 * price2) * taxRate / 100|money}\n'
        'Total: {=(qty1 * price1 + qty2 * price2) * (1 + taxRate / 100)|money}';
    final out = DocEngine.render(template, {
      'qty1': 10,
      'price1': '120',
      'qty2': 3,
      'price2': r'$49.50',
      'taxRate': 20,
    });
    // 1200 + 148.5 = 1348.5; tax 269.7; total 1618.2
    expect(
      out,
      'Subtotal: \$1,348.50\n'
      'Tax (20%): \$269.70\n'
      'Total: \$1,618.20',
    );
  });

  group('tool rendering', () {
    const privacy = ToolDef(
      id: 'privacyPolicy',
      name: 'Privacy policy',
      category: ToolCategory.legal,
      kind: ToolKind.doc,
      description: '',
      icon: Icons.build,
      legalDisclaimer: true,
      templateField: 'law',
      templates: {
        'GDPR': '{company} complies with GDPR.',
        'CCPA': '{company} complies with CCPA.',
      },
      fields: [
        FieldDef(key: 'company', label: 'Company name', type: FieldType.text),
        FieldDef(
          key: 'law',
          label: 'Law',
          type: FieldType.choice,
          options: ['GDPR', 'CCPA'],
          defaultValue: 'CCPA',
        ),
      ],
    );

    test('picks template by choice and appends legal notice', () {
      final out = DocEngine.renderTool(privacy, {
        'company': 'Acme',
        'law': 'GDPR',
      });
      expect(out, 'Acme complies with GDPR.\n\n${DocEngine.legalNotice}');
    });

    test('falls back to the field default when no choice is made', () {
      final out = DocEngine.renderTool(privacy, {});
      expect(out, startsWith('[Company name] complies with CCPA.'));
    });
  });
}
