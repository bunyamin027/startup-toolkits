import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/project/field_mapper.dart';
import 'package:startup_toolkits/project/launch_path.dart';
import 'package:startup_toolkits/project/project.dart';
import 'package:startup_toolkits/tools/catalog/catalog.dart';
import 'package:startup_toolkits/tools/tool_def.dart';

Project filled(Iterable<ProjectField> fields) =>
    fields.fold(const Project(), (p, f) => p.withValue(f, 'x'));

void main() {
  test('the path covers all 13 fields exactly once', () {
    final fields = [for (final s in launchPath) ...s.fields];
    expect(fields.toSet(), ProjectField.values.toSet());
    expect(fields, hasLength(ProjectField.values.length));
  });

  test('every referenced tool exists', () {
    for (final s in launchPath) {
      for (final id in [...s.tools, ...s.recommend.values]) {
        expect(toolById(id), isNotNull, reason: id);
      }
    }
  });

  test(
    'a step\'s recommended tool fills its missing fields or is one of its tools',
    () {
      for (final s in launchPath) {
        for (final id in s.recommend.values) {
          final tool = toolById(id)!;
          final fills = tool.fields.map(FieldMapper.match).toSet();
          expect(
            s.fields.any(fills.contains) || s.tools.contains(id),
            isTrue,
            reason: '${s.name} → $id',
          );
        }
      }
    },
  );

  test('empty project starts at Idea with Lean Canvas', () {
    final next = nextBestStep(const Project(), {})!;
    expect(next.step.name, 'Idea');
    expect(next.toolId, 'leanCanvas');
    expect(next.missing, hasLength(4));
    expect(launchProgress(const Project(), {}), 0);
  });

  test('Validate needs a field and a used tool', () {
    final idea = launchPath[0].fields;
    final project = filled([...idea, ProjectField.targetCustomer]);
    expect(currentStep(project, {}), 1);
    expect(currentStep(project, {'persona'}), 2);
    expect(nextBestStep(project, {'persona'})!.toolId, 'runway');
    final money = launchPath[2].fields;
    expect(
      nextBestStep(
        filled([
          ...idea,
          ProjectField.targetCustomer,
          ...money,
        ]).withGoal(Goal.raiseFunding),
        {'persona'},
      )!.toolId,
      'pitchDeck',
    );
  });

  test('Launch tool depends on the goal', () {
    final all = filled(
      ProjectField.values.where((f) => f != ProjectField.contactEmail),
    );
    const used = {'persona'};
    expect(
      nextBestStep(all.withGoal(Goal.launchApp), used)!.toolId,
      'storeListing',
    );
    expect(
      nextBestStep(all.withGoal(Goal.setUpCompany), used)!.toolId,
      'privacyTerms',
    );
    expect(nextBestStep(all, used)!.toolId, 'landingPage');
  });

  test('complete path has no next step and 100%', () {
    final all = filled(ProjectField.values);
    const used = {'persona', 'landingPage'};
    expect(nextBestStep(all, used), isNull);
    expect(launchProgress(all, used), 1);
  });

  test('progress weights every part equally', () {
    // 15 parts: 13 fields + 2 tool requirements.
    expect(
      launchProgress(filled([ProjectField.startupName]), {}),
      closeTo(1 / 15, 1e-9),
    );
  });
}
