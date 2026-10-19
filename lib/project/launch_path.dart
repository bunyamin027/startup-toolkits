import 'package:flutter/foundation.dart';

import '../tools/tool_def.dart';
import 'project.dart';

/// One step of the Home "Launch path" (Idea, Validate, Money, Pitch, Launch).
///
/// A step is done when its project fields are filled and, if it lists
/// [tools], at least one of them has been opened.
@immutable
class LaunchStep {
  const LaunchStep({
    required this.name,
    required this.action,
    required this.fields,
    this.tools = const [],
    required this.recommend,
  });

  final String name;

  /// Imperative used on the Next best step card ("Shape the idea").
  final String action;
  final List<ProjectField> fields;
  final List<String> tools;

  /// Tool to suggest for this step, by onboarding goal; `null` key is the
  /// fallback.
  final Map<Goal?, String> recommend;

  int get parts => fields.length + (tools.isEmpty ? 0 : 1);

  int partsDone(Project project, Set<String> usedTools) =>
      fields.where(project.isFilled).length +
      (tools.isNotEmpty && tools.any(usedTools.contains) ? 1 : 0);

  double progress(Project project, Set<String> usedTools) =>
      partsDone(project, usedTools) / parts;

  bool isDone(Project project, Set<String> usedTools) =>
      partsDone(project, usedTools) == parts;

  List<ProjectField> missing(Project project) =>
      fields.where((f) => !project.isFilled(f)).toList();

  String toolFor(Goal? goal) => recommend[goal] ?? recommend[null]!;
}

/// The 13 project fields spread over five steps; Validate and Launch also
/// ask for one of their tools to be used.
const launchPath = [
  LaunchStep(
    name: 'Idea',
    action: 'Shape the idea',
    fields: [
      ProjectField.startupName,
      ProjectField.oneLiner,
      ProjectField.problem,
      ProjectField.solution,
    ],
    recommend: {null: 'leanCanvas'},
  ),
  LaunchStep(
    name: 'Validate',
    action: 'Talk to customers',
    fields: [ProjectField.targetCustomer],
    tools: ['interviewQuestions', 'persona', 'competitors', 'ideaScore'],
    recommend: {null: 'interviewQuestions'},
  ),
  LaunchStep(
    name: 'Money',
    action: 'Know your runway',
    fields: [
      ProjectField.cash,
      ProjectField.monthlyExpenses,
      ProjectField.monthlyRevenue,
    ],
    recommend: {null: 'runway'},
  ),
  LaunchStep(
    name: 'Pitch',
    action: 'Tell the story',
    fields: [
      ProjectField.marketSize,
      ProjectField.traction,
      ProjectField.team,
      ProjectField.ask,
    ],
    recommend: {Goal.raiseFunding: 'pitchDeck', null: 'onePager'},
  ),
  LaunchStep(
    name: 'Launch',
    action: 'Go live',
    fields: [ProjectField.contactEmail],
    tools: ['landingPage', 'storeListing', 'privacyTerms', 'appPrivacy'],
    recommend: {
      Goal.launchApp: 'storeListing',
      Goal.setUpCompany: 'privacyTerms',
      null: 'landingPage',
    },
  ),
];

/// Overall progress, weighted by parts so every field counts the same.
double launchProgress(Project project, Set<String> usedTools) {
  final total = launchPath.fold(0, (a, s) => a + s.parts);
  final done = launchPath.fold(
    0,
    (a, s) => a + s.partsDone(project, usedTools),
  );
  return done / total;
}

/// Index of the first unfinished step, or null when the path is complete.
int? currentStep(Project project, Set<String> usedTools) {
  for (var i = 0; i < launchPath.length; i++) {
    if (!launchPath[i].isDone(project, usedTools)) return i;
  }
  return null;
}

/// What the Home "Next best step" card suggests.
@immutable
class NextStep {
  const NextStep({
    required this.step,
    required this.toolId,
    required this.missing,
  });

  final LaunchStep step;
  final String toolId;
  final List<ProjectField> missing;
}

NextStep? nextBestStep(Project project, Set<String> usedTools) {
  final index = currentStep(project, usedTools);
  if (index == null) return null;
  final step = launchPath[index];
  return NextStep(
    step: step,
    toolId: step.toolFor(project.goal),
    missing: step.missing(project),
  );
}
