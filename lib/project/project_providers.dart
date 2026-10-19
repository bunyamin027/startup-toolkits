import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/storage/storage_providers.dart';
import '../tools/tool_def.dart';
import 'field_mapper.dart';
import 'project.dart';
import 'project_store.dart';

/// Project loaded before the first frame; `main` overrides it so screens
/// never wait on storage.
final initialProjectProvider = Provider<Project>((ref) => const Project());

final projectProvider = NotifierProvider<ProjectNotifier, Project>(
  ProjectNotifier.new,
);

class ProjectNotifier extends Notifier<Project> {
  @override
  Project build() => ref.read(initialProjectProvider);

  void setField(ProjectField field, String value) =>
      _set(state.withValue(field, value));

  void setGoal(Goal? goal) => _set(state.withGoal(goal));

  /// Copies the tool's mapped values into the project. Returns how many
  /// project fields changed.
  int syncFrom(ToolDef tool, Map<String, Object?> values) {
    final before = state;
    final after = FieldMapper.writeBack(tool, values, before);
    if (identical(before, after)) return 0;
    _set(after);
    return ProjectField.values.where((f) => before[f] != after[f]).length;
  }

  void _set(Project project) {
    state = project;
    unawaited(ProjectStore(ref.read(keyValueStoreProvider)).save(project));
  }
}

final initialOnboardingDoneProvider = Provider<bool>((ref) => false);

final onboardingDoneProvider = NotifierProvider<OnboardingNotifier, bool>(
  OnboardingNotifier.new,
);

class OnboardingNotifier extends Notifier<bool> {
  @override
  bool build() => ref.read(initialOnboardingDoneProvider);

  void complete() {
    state = true;
    unawaited(OnboardingStore(ref.read(keyValueStoreProvider)).save(true));
  }
}
