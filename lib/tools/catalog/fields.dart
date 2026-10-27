import '../tool_def.dart';

// Short constructors so catalog files read like the master plan.
// Every field gets an example value: tools never open empty.

FieldDef text(
  String key,
  String label,
  String example, {
  String? hint,
  bool autofill = true,
}) => FieldDef(
  key: key,
  label: label,
  type: FieldType.text,
  defaultValue: example,
  hint: hint,
  autofill: autofill,
);

FieldDef para(
  String key,
  String label,
  String example, {
  String? hint,
  bool autofill = true,
}) => FieldDef(
  key: key,
  label: label,
  type: FieldType.multiline,
  defaultValue: example,
  hint: hint,
  autofill: autofill,
);

FieldDef email(
  String key,
  String label,
  String example, {
  bool autofill = true,
}) => FieldDef(
  key: key,
  label: label,
  type: FieldType.email,
  defaultValue: example,
  autofill: autofill,
);

FieldDef money(
  String key,
  String label,
  num example, {
  double? min,
  double? max,
  double? step,
  bool autofill = true,
}) => FieldDef(
  key: key,
  label: label,
  type: FieldType.money,
  defaultValue: example,
  min: min,
  max: max,
  step: step,
  autofill: autofill,
);

FieldDef number(
  String key,
  String label,
  num example, {
  double? min,
  double? max,
  double? step,
}) => FieldDef(
  key: key,
  label: label,
  type: FieldType.number,
  defaultValue: example,
  min: min,
  max: max,
  step: step,
);

FieldDef percent(
  String key,
  String label,
  num example, {
  double? min,
  double? max,
  double? step,
}) => FieldDef(
  key: key,
  label: label,
  type: FieldType.percent,
  defaultValue: example,
  min: min,
  max: max,
  step: step,
);

/// 1–5 rating slider. A rating is never project data ("Market size: 4"),
/// so it never auto-fills even when its label matches a project field.
FieldDef score(String key, String label, int example, {String? hint}) =>
    FieldDef(
      key: key,
      label: label,
      type: FieldType.slider,
      defaultValue: example,
      hint: hint,
      min: 1,
      max: 5,
      step: 1,
      autofill: false,
    );

FieldDef choice(
  String key,
  String label,
  List<String> options, [
  String? initial,
]) => FieldDef(
  key: key,
  label: label,
  type: FieldType.choice,
  options: options,
  defaultValue: initial ?? options.first,
);
