import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/storage/storage_providers.dart';
import '../engines/list_engine.dart';
import '../project/field_mapper.dart';
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

/// Current inputs of a calculator or generator.
///
/// Opening order: example data, then the user's last values, then project
/// data (the project wins, since edits sync into it as they happen).
/// Auto-disposed so a reopened tool picks up project changes made elsewhere.
final toolValuesProvider = AsyncNotifierProvider.autoDispose
    .family<ToolValuesNotifier, Map<String, Object?>, String>(
      ToolValuesNotifier.new,
    );

class ToolValuesNotifier extends AsyncNotifier<Map<String, Object?>> {
  ToolValuesNotifier(this.toolId);

  final String toolId;

  ToolDef get tool => toolById(toolId)!;

  ToolValuesStore get _store =>
      ToolValuesStore(ref.read(keyValueStoreProvider));

  @override
  Future<Map<String, Object?>> build() async {
    final saved = await _store.load(toolId);
    final project = ref.read(projectProvider);
    return {...tool.defaults, ...?saved, ...FieldMapper.prefill(tool, project)};
  }

  void set(String key, Object? value) {
    final current = state.value;
    if (current == null) return;
    final next = {...current, key: value};
    state = AsyncData(next);
    unawaited(_store.save(toolId, next));
    ref.read(projectProvider.notifier).syncFrom(tool, {key: value});
  }

  /// Back to example data (plus project data).
  void reset() {
    unawaited(_store.clear(toolId));
    state = AsyncData({
      ...tool.defaults,
      ...FieldMapper.prefill(tool, ref.read(projectProvider)),
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

/// Items of a tracker, seeded with the tool's samples on first open.
final listItemsProvider =
    AsyncNotifierProvider.family<ListItemsNotifier, List<ListItem>, String>(
      ListItemsNotifier.new,
    );

class ListItemsNotifier extends AsyncNotifier<List<ListItem>> {
  ListItemsNotifier(this.toolId);

  final String toolId;
  static int _seq = 0;

  ToolDef get tool => toolById(toolId)!;

  ListStore get _store => ListStore(ref.read(keyValueStoreProvider));

  @override
  Future<List<ListItem>> build() async {
    return await _store.load(toolId) ??
        [
          for (var i = 0; i < tool.samples.length; i++)
            ListItem(
              id: 'sample-$i',
              title: tool.samples[i].title,
              stage: tool.samples[i].stage,
              fields: tool.samples[i].fields,
            ),
        ];
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
