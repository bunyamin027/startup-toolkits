import 'package:flutter/foundation.dart';

import '../tool_def.dart';

/// Translated text of one tool. The English catalog stays the source of
/// truth for ids, numbers and logic; a translation only replaces what the
/// user reads. Anything left out falls back to English, and
/// `test/tool_text_test.dart` checks nothing is left out.
@immutable
class ToolText {
  const ToolText({
    required this.name,
    required this.description,
    this.fields = const {},
    this.options = const {},
    this.stages = const {},
    this.itemLabel,
    this.template,
    this.templates = const {},
    this.samples = const [],
  });

  final String name;
  final String description;

  /// By field key.
  final Map<String, FieldText> fields;

  /// Choice option labels, by English option.
  final Map<String, String> options;

  /// List: stage labels, by English stage.
  final Map<String, String> stages;
  final String? itemLabel;

  /// Doc: the template, or templates by English option.
  final String? template;
  final Map<String, String> templates;

  /// List: one per English sample, in the same order.
  final List<SampleText> samples;
}

/// Label, example value and hint of one field. Leave [example] out when the
/// English example is a name or a number that reads the same everywhere.
@immutable
class FieldText {
  const FieldText(this.label, {this.example, this.hint});

  final String label;
  final String? example;
  final String? hint;
}

/// Title and text columns of one sample row; numbers come from English.
@immutable
class SampleText {
  const SampleText(this.title, [this.fields = const {}]);

  final String title;
  final Map<String, String> fields;
}

/// Calculator output labels (by output key) and verdicts (by English text)
/// of one language.
@immutable
class CalcText {
  const CalcText({required this.outputs, required this.verdicts});

  final Map<String, String> outputs;
  final Map<String, String> verdicts;
}

/// [base] with the text of [text], or [base] itself when there is none.
ToolDef localizeTool(
  ToolDef base,
  String language,
  ToolText? text,
  CalcText? calc,
) {
  if (text == null) return base;
  return base.translated(
    language: language,
    name: text.name,
    description: text.description,
    fields: [
      for (final f in base.fields)
        f.copyWith(
          label: text.fields[f.key]?.label,
          hint: text.fields[f.key]?.hint,
          defaultValue: text.fields[f.key]?.example,
          optionLabels: {for (final o in f.options) o: ?text.options[o]},
        ),
    ],
    template: text.template,
    templates: text.templates.isEmpty ? null : text.templates,
    itemLabel: text.itemLabel,
    samples: [
      for (final (i, s) in base.samples.indexed)
        if (i < text.samples.length)
          SampleItem(text.samples[i].title, s.stage, {
            ...s.fields,
            ...text.samples[i].fields,
          })
        else
          s,
    ],
    stageLabels: text.stages,
    outputLabels: calc?.outputs ?? const {},
    verdictLabels: calc?.verdicts ?? const {},
  );
}
