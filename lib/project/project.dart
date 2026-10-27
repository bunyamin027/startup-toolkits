import 'package:flutter/foundation.dart';

import '../tools/tool_def.dart';

/// The 13 project workspace fields (master plan §5).
enum ProjectField {
  startupName('Startup name'),
  oneLiner('One-line description'),
  problem('Problem'),
  solution('Solution'),
  targetCustomer('Target customer'),
  marketSize('Market size'),
  traction('Traction'),
  ask('The ask'),
  team('Team'),
  contactEmail('Contact email'),
  cash('Cash'),
  monthlyExpenses('Monthly expenses'),
  monthlyRevenue('Monthly revenue');

  const ProjectField(this.label);
  final String label;
}

@immutable
class Project {
  const Project({this.values = const {}, this.goal, this.sector});

  factory Project.fromJson(Map<String, Object?> json) {
    final raw = (json['values'] as Map?) ?? const {};
    return Project(
      values: {
        for (final f in ProjectField.values)
          if (raw[f.name] case final String v) f: v,
      },
      goal: Goal.values.asNameMap()[json['goal']],
      sector: Sector.values.asNameMap()[json['sector']],
    );
  }

  final Map<ProjectField, String> values;

  /// Picked during onboarding; drives which tools Home suggests.
  final Goal? goal;

  /// Picked during onboarding; drives the example scenario in tools.
  final Sector? sector;

  /// The scenario tools use: the picked one, else the R&D example.
  Sector get scenario => sector ?? Sector.fallback;

  String operator [](ProjectField field) => values[field] ?? '';

  bool isFilled(ProjectField field) => this[field].trim().isNotEmpty;

  int get filledCount => ProjectField.values.where(isFilled).length;

  double get completion => filledCount / ProjectField.values.length;

  Project withValue(ProjectField field, String value) =>
      Project(values: {...values, field: value}, goal: goal, sector: sector);

  Project withGoal(Goal? goal) =>
      Project(values: values, goal: goal, sector: sector);

  Project withSector(Sector? sector) =>
      Project(values: values, goal: goal, sector: sector);

  /// Plain-text summary for "Copy project brief" (§5), with field names
  /// from [label] (the screen's language; English by default).
  String brief([String Function(ProjectField)? label]) => [
    for (final f in ProjectField.values)
      if (isFilled(f)) '${label?.call(f) ?? f.label}: ${this[f].trim()}',
  ].join('\n');

  Map<String, Object?> toJson() => {
    'values': {for (final e in values.entries) e.key.name: e.value},
    'goal': goal?.name,
    'sector': sector?.name,
  };
}
