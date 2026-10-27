import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/engines/doc_engine.dart';
import 'package:startup_toolkits/tools/catalog/catalog.dart';
import 'package:startup_toolkits/tools/scenarios/scenario.dart';
import 'package:startup_toolkits/tools/tool_def.dart';

/// Words that only belong to the base (bookkeeping SaaS) example; another
/// scenario showing them means an example was left out.
const _baseWords = {
  'en': ['nimbly', 'bookkeep', 'freelanc', 'receipt'],
  'tr': ['nimbly', 'muhasebe', 'serbest çalış', 'fiş'],
  // "reçu" also means "received" (NDA), so receipts are not checked.
  'fr': ['nimbly', 'comptab', 'freelance'],
  'es': ['nimbly', 'contab', 'freelance', 'recibo'],
  'de': ['nimbly', 'buchhalt', 'freelancer', 'beleg'],
};

void main() {
  for (final MapEntry(key: sector, value: texts) in scenarioTexts.entries) {
    group(sector.name, () {
      final english = texts['en'] ?? const ScenarioText();

      test('covers every language with the keys of the English', () {
        expect(texts.keys.toSet(), toolLanguages.toSet());
        for (final language in toolLanguages) {
          final t = texts[language]!;
          expect(
            {
              for (final e in t.fields.entries)
                for (final k in e.value.keys) '${e.key}.$k',
            },
            {
              for (final e in english.fields.entries)
                for (final k in e.value.keys) '${e.key}.$k',
            },
            reason: language,
          );
          expect(
            {for (final e in t.samples.entries) e.key: e.value.length},
            {for (final e in english.samples.entries) e.key: e.value.length},
            reason: language,
          );
        }
      });

      test('examples and sample rows fit their tools', () {
        for (final MapEntry(key: toolId, value: fields)
            in english.fields.entries) {
          final tool = toolById(toolId);
          expect(tool, isNotNull, reason: toolId);
          for (final key in fields.keys) {
            expect(tool!.field(key)?.isWritten, isTrue, reason: '$toolId.$key');
          }
        }
        for (final MapEntry(key: toolId, value: rows)
            in english.samples.entries) {
          final tool = toolById(toolId)!;
          expect(rows.length, tool.samples.length, reason: toolId);
          for (final row in rows) {
            for (final key in row.fields.keys) {
              expect(tool.field(key), isNotNull, reason: '$toolId.$key');
            }
          }
        }
      });

      for (final language in toolLanguages) {
        test('$language: documents render fully, no base example left', () {
          final catalog = ToolCatalog.of(language, sector);
          final words = _baseWords[language]!;
          for (final tool in catalog.tools) {
            final shown = <String>[
              for (final f in tool.fields)
                if (f.isWritten) '${f.defaultValue}',
              for (final s in tool.samples) ...[
                s.title,
                ...s.fields.values.map((v) => '$v'),
              ],
            ];
            if (tool.kind == ToolKind.doc) {
              final variants = tool.templates.isEmpty
                  ? {''}
                  : tool.templates.keys.toSet();
              for (final v in variants) {
                final out = DocEngine.renderTool(tool, {
                  ...tool.defaults,
                  if (tool.templateField != null) tool.templateField!: v,
                });
                expect(
                  out,
                  isNot(matches(RegExp(r'\[[A-ZÀ-Ýİ][^\]]*\]'))),
                  reason: '${tool.id} $v',
                );
                shown.add(out);
              }
            }
            for (final text in shown) {
              for (final word in words) {
                expect(
                  text.toLowerCase(),
                  isNot(contains(word)),
                  reason: '${tool.id}: "$word" in "$text"',
                );
              }
            }
          }
        });
      }
    });
  }

  test('the software scenario is the base catalog', () {
    expect(
      ToolCatalog.of(
        'en',
        Sector.saas,
      ).byId('leanCanvas')!.field('company')!.defaultValue,
      'Nimbly',
    );
    expect(
      ToolCatalog.of(
        'tr',
        Sector.rnd,
      ).byId('leanCanvas')!.field('company')!.defaultValue,
      'Terralab',
    );
  });
}
