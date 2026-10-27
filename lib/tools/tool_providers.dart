import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/storage/storage_providers.dart';
import '../engines/list_engine.dart';
import '../l10n/locale_providers.dart';
import '../project/field_mapper.dart';
import '../project/project.dart';
import '../project/project_providers.dart';
import 'catalog/catalog.dart';
import 'tool_def.dart';
import 'tool_stores.dart';

/// Favorites loaded before the first frame; overridden in `main`.
final initialFavoritesProvider = Provider<Set<String>>((ref) => const {});

final favoritesProvider = NotifierProvider<FavoritesNotifier, Set<String>>(
  FavoritesNotifier.new,
);

class FavoritesNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => ref.read(initialFavoritesProvider);

  void toggle(String toolId) {
    final next = {...state};
    if (!next.remove(toolId)) next.add(toolId);
    state = next;
    unawaited(FavoritesStore(ref.read(keyValueStoreProvider)).save(next));
  }
}

/// Tools in the app language with the examples of the project's scenario.
ToolCatalog catalogFor(Ref ref) => ToolCatalog.of(
  ref.read(appLocaleProvider).languageCode,
  ref.read(projectProvider).scenario,
);

/// True once the user told us about their startup (onboarding or Project).
/// Before that, tools run as a demo with example data.
bool hasProject(Project project) => project.filledCount > 0;

/// Opening values: the example in demo mode, otherwise empty written
/// fields so the user's document never shows another startup's content.
Map<String, Object?> baseValues(ToolDef tool, Project project) =>
    hasProject(project) ? tool.starterValues : tool.defaults;

/// Current inputs of a calculator or generator.
///
/// Opening order: example data, then the user's last values, then project
/// data (the project wins, since edits sync into it as they happen).
/// Auto-disposed so a reopened tool picks up project changes made elsewhere.
/// Rebuilds on a language change: saved values that are still an example
/// (in any language) give way to the example in the new language.
final toolValuesProvider = AsyncNotifierProvider.autoDispose
    .family<ToolValuesNotifier, Map<String, Object?>, String>(
      ToolValuesNotifier.new,
    );

class ToolValuesNotifier extends AsyncNotifier<Map<String, Object?>> {
  ToolValuesNotifier(this.toolId);

  final String toolId;

  /// The tool in the current language and the project's scenario.
  ToolDef get tool => catalogFor(ref).byId(toolId)!;

  ToolValuesStore get _store =>
      ToolValuesStore(ref.read(keyValueStoreProvider));

  @override
  Future<Map<String, Object?>> build() async {
    ref.watch(appLocaleProvider);
    ref.watch(projectProvider.select((p) => p.scenario));
    final tool = this.tool;
    final saved = await _store.load(toolId) ?? const {};
    final edited = {
      for (final e in saved.entries)
        if (!examplesOf(toolId, e.key).contains(e.value)) e.key: e.value,
    };
    final project = ref.read(projectProvider);
    return {
      ...baseValues(tool, project),
      ...edited,
      ...FieldMapper.prefill(tool, project),
    };
  }

  void set(String key, Object? value) {
    final current = state.value;
    if (current == null) return;
    final next = {...current, key: value};
    state = AsyncData(next);
    unawaited(_store.save(toolId, next));
    ref.read(projectProvider.notifier).syncFrom(tool, {key: value});
  }

  /// Back to the opening values (plus project data).
  void reset() {
    unawaited(_store.clear(toolId));
    final project = ref.read(projectProvider);
    state = AsyncData({
      ...baseValues(tool, project),
      ...FieldMapper.prefill(tool, project),
    });
  }

  /// "Save to project": pushes every mapped value, examples included.
  /// Returns how many project fields changed.
  int saveToProject() {
    final current = state.value;
    if (current == null) return 0;
    return ref.read(projectProvider.notifier).syncFrom(tool, current);
  }
}

/// Items of a tracker, seeded with the tool's samples on first open. Sample
/// rows the user has not changed follow the language.
final listItemsProvider =
    AsyncNotifierProvider.family<ListItemsNotifier, List<ListItem>, String>(
      ListItemsNotifier.new,
    );

class ListItemsNotifier extends AsyncNotifier<List<ListItem>> {
  ListItemsNotifier(this.toolId);

  final String toolId;
  static int _seq = 0;

  ToolDef get tool => catalogFor(ref).byId(toolId)!;

  ListStore get _store => ListStore(ref.read(keyValueStoreProvider));

  @override
  Future<List<ListItem>> build() async {
    ref.watch(appLocaleProvider);
    ref.watch(projectProvider.select((p) => p.scenario));
    final tool = this.tool;
    final stored = await _store.load(toolId);
    if (stored == null) {
      // Made-up investors or leads do not belong in the user's own pipeline.
      if (hasProject(ref.read(projectProvider)) &&
          !templateSampleTools.contains(toolId)) {
        return const [];
      }
      return [
        for (var i = 0; i < tool.samples.length; i++)
          ListItem(
            id: 'sample-$i',
            title: tool.samples[i].title,
            stage: tool.samples[i].stage,
            fields: tool.samples[i].fields,
          ),
      ];
    }
    return [for (final item in stored) _inLanguage(item, tool)];
  }

  /// An untouched sample row in the current language and scenario; other
  /// rows as saved.
  ListItem _inLanguage(ListItem item, ToolDef tool) {
    final index = int.tryParse(item.id.replaceFirst('sample-', ''));
    if (!item.id.startsWith('sample-') ||
        index == null ||
        index >= tool.samples.length) {
      return item;
    }
    final untouched = sampleVariants(
      toolId,
      index,
    ).any((s) => s.title == item.title && mapEquals(s.fields, item.fields));
    if (!untouched) return item;
    final sample = tool.samples[index];
    return item.copyWith(title: sample.title, fields: sample.fields);
  }

  static String newId() => '${DateTime.now().microsecondsSinceEpoch}-${_seq++}';

  void add(ListItem item) => _apply((l) => ListEngine.add(l, item));

  void edit(ListItem item) => _apply((l) => ListEngine.update(l, item));

  void remove(String id) => _apply((l) => ListEngine.remove(l, id));

  /// Puts a removed item back at its old position (undo).
  void restore(ListItem item, int index) =>
      _apply((l) => [...l]..insert(index.clamp(0, l.length), item));

  /// Moves an item one stage on, unless it already reached an outcome.
  void advance(String id) => _apply(
    (l) => l.any((i) => i.id == id && tool.isEndStage(i.stage))
        ? l
        : ListEngine.advance(l, id, tool.stages),
  );

  void _apply(List<ListItem> Function(List<ListItem>) change) {
    final current = state.value;
    if (current == null) return;
    final next = change(current);
    state = AsyncData(next);
    unawaited(_store.save(toolId, next));
  }
}

/// Last-opened time per tool; loaded before the first frame.
final initialRecentToolsProvider = Provider<Map<String, DateTime>>(
  (ref) => const {},
);

final recentToolsProvider =
    NotifierProvider<RecentToolsNotifier, Map<String, DateTime>>(
      RecentToolsNotifier.new,
    );

class RecentToolsNotifier extends Notifier<Map<String, DateTime>> {
  @override
  Map<String, DateTime> build() => ref.read(initialRecentToolsProvider);

  void record(String toolId, [DateTime? at]) {
    state = {...state, toolId: at ?? DateTime.now()};
    unawaited(RecentToolsStore(ref.read(keyValueStoreProvider)).save(state));
  }

  /// Tool ids, most recent first.
  List<String> get ordered =>
      (state.entries.toList()..sort((a, b) => b.value.compareTo(a.value)))
          .map((e) => e.key)
          .toList();
}
