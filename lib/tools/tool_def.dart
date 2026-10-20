import 'package:flutter/widgets.dart';

/// The three engines every tool runs on (master plan §2, §9).
enum ToolKind { calc, doc, list }

/// The 10 categories of §3.
enum ToolCategory {
  ideaValidation('Idea & validation'),
  finance('Finance'),
  investors('Investor relations'),
  product('Product & project'),
  marketing('Marketing & content'),
  sales('Sales & customers'),
  legal('Legal & documents'),
  team('Team & HR'),
  growth('Growth & analytics'),
  mobileApp('Mobile app founders');

  const ToolCategory(this.label);
  final String label;
}

/// Onboarding goals (§7.4). Tools are offered by goal, not by name.
enum Goal {
  raiseFunding('Raise funding'),
  firstCustomers('Find first customers'),
  setUpCompany('Set up the company'),
  launchApp('Launch my app');

  const Goal(this.label);
  final String label;
}

enum FieldType {
  text,
  multiline,
  number,
  money,
  percent,
  slider,
  choice,
  email,
}

/// One input of a tool. [defaultValue] is the example data the tool opens
/// with, so no tool ever starts empty (UX principle 4).
@immutable
class FieldDef {
  const FieldDef({
    required this.key,
    required this.label,
    required this.type,
    this.defaultValue,
    this.hint,
    this.min,
    this.max,
    this.step,
    this.options = const [],
    this.autofill = true,
    this.baseLabel,
    this.optionLabels = const {},
  });

  /// Identifier used in templates (`{key}`) and formulas.
  final String key;

  /// Visible label; the field mapper also matches project fields by it.
  final String label;
  final FieldType type;
  final Object? defaultValue;
  final String? hint;
  final double? min;
  final double? max;
  final double? step;

  /// Values for [FieldType.choice].
  final List<String> options;

  /// False opts this field out of project auto-fill even if its label matches.
  final bool autofill;

  /// English label of a translated field; the field mapper matches on it.
  final String? baseLabel;

  /// Translated names of [options]. Values stay English, since templates
  /// and saved inputs refer to them.
  final Map<String, String> optionLabels;

  String get mappingLabel => baseLabel ?? label;

  String optionLabel(String option) => optionLabels[option] ?? option;

  FieldDef copyWith({
    String? label,
    String? hint,
    Object? defaultValue,
    Map<String, String>? optionLabels,
  }) => FieldDef(
    key: key,
    label: label ?? this.label,
    type: type,
    defaultValue: defaultValue ?? this.defaultValue,
    hint: hint ?? this.hint,
    min: min,
    max: max,
    step: step,
    options: options,
    autofill: autofill,
    baseLabel: label == null ? baseLabel : mappingLabel,
    optionLabels: optionLabels ?? this.optionLabels,
  );

  bool get isNumeric => switch (type) {
    FieldType.number ||
    FieldType.money ||
    FieldType.percent ||
    FieldType.slider => true,
    _ => false,
  };
}

/// Example row a tracker opens with (UX principle 4: no empty screens).
@immutable
class SampleItem {
  const SampleItem(this.title, this.stage, [this.fields = const {}]);

  final String title;
  final String stage;
  final Map<String, Object?> fields;
}

/// A tool is pure data; the engine for its [kind] does the work.
///
/// - calc: [formula] names a function registered in `CalcEngine`.
/// - doc: [template], or [templates] picked by the value of [templateField].
/// - list: [stages] are the columns items move through; [fields] are the
///   item's extra columns and [itemLabel] names one item ("Investor").
///
/// A numeric field with both min and max renders as a slider.
@immutable
class ToolDef {
  const ToolDef({
    required this.id,
    required this.name,
    required this.category,
    required this.kind,
    required this.description,
    required this.icon,
    this.fields = const [],
    this.goals = const {},
    this.formula,
    this.template,
    this.templates = const {},
    this.templateField,
    this.stages = const [],
    this.legalDisclaimer = false,
    this.heroOutput,
    this.itemLabel = 'Item',
    this.totalField,
    this.samples = const [],
    this.endStages = const {},
    this.language = 'en',
    this.stageLabels = const {},
    this.outputLabels = const {},
    this.verdictLabels = const {},
  });

  final String id;
  final String name;
  final ToolCategory category;
  final ToolKind kind;
  final String description;
  final IconData icon;
  final List<FieldDef> fields;
  final Set<Goal> goals;
  final String? formula;
  final String? template;
  final Map<String, String> templates;
  final String? templateField;
  final List<String> stages;

  /// Appends the "template only, not legal advice" notice to output (§3.7).
  final bool legalDisclaimer;

  /// Calc: output key shown large at the top; defaults to the first output.
  final String? heroOutput;

  /// List: singular name of one item, also the label of its title field.
  final String itemLabel;

  /// List: numeric field summed per stage in the header (e.g. amount).
  final String? totalField;

  /// List: rows the tracker is seeded with on first open.
  final List<SampleItem> samples;

  /// List: outcome stages items do not advance from (Committed / Passed,
  /// Won / Lost). The last stage is always an end stage.
  final Set<String> endStages;

  /// Language of the visible text below; see `tools/l10n/`.
  final String language;

  /// Translated stage names. Stages stay English in saved items.
  final Map<String, String> stageLabels;

  /// Calc: translated output labels by output key, and verdicts by their
  /// English text.
  final Map<String, String> outputLabels;
  final Map<String, String> verdictLabels;

  String stageLabel(String stage) => stageLabels[stage] ?? stage;

  String outputLabel(String key, String fallback) =>
      outputLabels[key] ?? fallback;

  String verdict(String english) => verdictLabels[english] ?? english;

  /// Same tool with translated text; ids, numbers and logic are kept.
  ToolDef translated({
    required String language,
    required String name,
    required String description,
    required List<FieldDef> fields,
    String? template,
    Map<String, String>? templates,
    String? itemLabel,
    List<SampleItem>? samples,
    Map<String, String> stageLabels = const {},
    Map<String, String> outputLabels = const {},
    Map<String, String> verdictLabels = const {},
  }) => ToolDef(
    id: id,
    name: name,
    category: category,
    kind: kind,
    description: description,
    icon: icon,
    fields: fields,
    goals: goals,
    formula: formula,
    template: template ?? this.template,
    templates: templates ?? this.templates,
    templateField: templateField,
    stages: stages,
    legalDisclaimer: legalDisclaimer,
    heroOutput: heroOutput,
    itemLabel: itemLabel ?? this.itemLabel,
    totalField: totalField,
    samples: samples ?? this.samples,
    endStages: endStages,
    language: language,
    stageLabels: stageLabels,
    outputLabels: outputLabels,
    verdictLabels: verdictLabels,
  );

  bool isEndStage(String stage) =>
      stage == stages.last || endStages.contains(stage);

  FieldDef? field(String key) {
    for (final f in fields) {
      if (f.key == key) return f;
    }
    return null;
  }

  /// Example values the tool opens with.
  Map<String, Object?> get defaults => {
    for (final f in fields) f.key: f.defaultValue,
  };

  /// Returns a description of what is wrong, or null when the definition is
  /// complete for its kind. Tool catalog tests run this over all 45 tools.
  String? validate() {
    final keys = <String>{};
    for (final f in fields) {
      if (!keys.add(f.key)) return '$id: duplicate field "${f.key}"';
      if (f.type == FieldType.choice && f.options.isEmpty) {
        return '$id: choice field "${f.key}" has no options';
      }
    }
    switch (kind) {
      case ToolKind.calc:
        if (formula == null) return '$id: calc tool needs a formula';
      case ToolKind.doc:
        if (template == null && templates.isEmpty) {
          return '$id: doc tool needs a template';
        }
        if (templates.isNotEmpty) {
          final selector = templateField == null ? null : field(templateField!);
          if (selector == null) return '$id: templates need a templateField';
          final missing = selector.options.where(
            (o) => !templates.containsKey(o),
          );
          if (missing.isNotEmpty) {
            return '$id: no template for ${missing.join(', ')}';
          }
        }
      case ToolKind.list:
        if (stages.isEmpty) return '$id: list tool needs stages';
        for (final sample in samples) {
          if (!stages.contains(sample.stage)) {
            return '$id: sample "${sample.title}" has unknown stage';
          }
        }
        if (!stages.toSet().containsAll(endStages)) {
          return '$id: unknown end stage';
        }
        if (totalField != null && field(totalField!)?.isNumeric != true) {
          return '$id: totalField must be a numeric field';
        }
    }
    return null;
  }
}
