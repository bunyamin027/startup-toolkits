import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/engines/calc_engine.dart';
import 'package:startup_toolkits/engines/doc_engine.dart';
import 'package:startup_toolkits/project/field_mapper.dart';
import 'package:startup_toolkits/tools/catalog/catalog.dart';
import 'package:startup_toolkits/tools/l10n/calc_text.dart';
import 'package:startup_toolkits/tools/tool_def.dart';

/// Every tool is fully translated in every language: nothing falls back to
/// English, templates keep their placeholders, and outputs render whole.
void main() {
  int words(Object? s) =>
      s is String ? s.trim().split(RegExp(r'\s+')).length : 0;

  for (final language in toolLanguages.where((l) => l != 'en')) {
    group(language, () {
      final texts = toolTextsIn(language);
      final catalog = ToolCatalog.of(language);

      test('translates exactly the 45 tools', () {
        expect(texts.keys.toSet(), allTools.map((t) => t.id).toSet());
      });

      for (final base in allTools) {
        group(base.id, () {
          final text = texts[base.id]!;
          final tool = catalog.byId(base.id)!;

          test('name, fields, options and stages', () {
            expect(tool.language, language);
            expect(text.fields.keys.toSet(), {
              for (final f in base.fields) f.key,
            });
            for (final f in base.fields) {
              final local = tool.field(f.key)!;
              final where = '${base.id}.${f.key}';
              if (f.hint != null) {
                expect(text.fields[f.key]!.hint, isNotNull, reason: where);
              }
              // Sentences must be translated; names and numbers may stay.
              if (words(f.defaultValue) >= 3) {
                expect(
                  local.defaultValue,
                  isNot(f.defaultValue),
                  reason: where,
                );
              }
              for (final o in f.options) {
                expect(text.options, contains(o), reason: '$where: $o');
              }
              // Project auto-fill works the same in every language.
              expect(
                FieldMapper.match(local),
                FieldMapper.match(f),
                reason: where,
              );
            }
            if (base.kind == ToolKind.list) {
              expect(text.itemLabel, isNotNull);
              expect(text.stages.keys.toSet(), base.stages.toSet());
            }
          });

          switch (base.kind) {
            case ToolKind.doc:
              test('templates keep placeholders and render fully', () {
                final english = base.templates.isEmpty
                    ? {'': base.template!}
                    : base.templates;
                final local = tool.templates.isEmpty
                    ? {'': tool.template!}
                    : tool.templates;
                expect(local.keys.toSet(), english.keys.toSet());
                expect(
                  base.templates.isEmpty ? text.template : text.templates,
                  isNotNull,
                );
                english.forEach((variant, template) {
                  expect(
                    DocEngine.placeholderKeys(local[variant]!),
                    DocEngine.placeholderKeys(template),
                    reason: '${base.id} $variant',
                  );
                  expect(
                    DocEngine.expressionVariables(local[variant]!),
                    DocEngine.expressionVariables(template),
                    reason: '${base.id} $variant',
                  );
                  expect(local[variant], isNot(template));
                  final out = DocEngine.renderTool(tool, {
                    ...tool.defaults,
                    if (tool.templateField != null)
                      tool.templateField!: variant,
                  });
                  expect(out.contains('{'), isFalse, reason: variant);
                  expect(
                    out,
                    isNot(matches(RegExp(r'\[\p{Lu}', unicode: true))),
                  );
                  if (tool.legalDisclaimer) {
                    expect(out, endsWith(DocEngine.legalNoticeIn(language)));
                  }
                });
              });
            case ToolKind.list:
              test('samples', () {
                expect(text.samples, hasLength(base.samples.length));
                for (final (i, s) in base.samples.indexed) {
                  final local = tool.samples[i];
                  expect(local.stage, s.stage);
                  expect(
                    text.samples[i].fields.keys.toSet().difference(
                      s.fields.keys.toSet(),
                    ),
                    isEmpty,
                  );
                  if (words(s.title) >= 3) {
                    expect(local.title, isNot(s.title), reason: s.title);
                  }
                  s.fields.forEach((key, value) {
                    if (words(value) >= 3) {
                      expect(local.fields[key], isNot(value), reason: key);
                    }
                  });
                }
              });
            case ToolKind.calc:
              test('outputs and verdicts', () {
                final r = CalcEngine.run(base.formula!, base.defaults);
                for (final o in r.outputs) {
                  expect(calcTexts[language]!.outputs, contains(o.key));
                }
              });
          }
        });
      }

      test('every calculator verdict', () {
        expect(
          calcTexts[language]!.verdicts.keys.toSet(),
          CalcEngine.verdicts.toSet(),
        );
      });
    });
  }
}
