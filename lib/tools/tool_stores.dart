import '../core/storage/key_value_store.dart';
import '../engines/list_engine.dart';

/// Favorite tool ids for the "My tools" tab.
class FavoritesStore {
  FavoritesStore(this._kv);

  static const _key = 'favorites.v1';

  final KeyValueStore _kv;

  Future<Set<String>> load() async {
    final json = await _kv.readJson(_key);
    return json is List ? json.whereType<String>().toSet() : <String>{};
  }

  Future<void> save(Set<String> ids) => _kv.writeJson(_key, ids.toList());

  /// Returns the updated set.
  Future<Set<String>> toggle(String toolId) async {
    final ids = await load();
    if (!ids.remove(toolId)) ids.add(toolId);
    await save(ids);
    return ids;
  }
}

/// Items of tracker tools, one key per tool.
///
/// shared_preferences is enough for v1 volumes; the plan's Hive/Isar option
/// can replace this class without touching callers.
class ListStore {
  ListStore(this._kv);

  final KeyValueStore _kv;

  String _key(String toolId) => 'list.$toolId.v1';

  /// Returns null when the tool has never been saved, so the UI can seed it
  /// with example items instead of showing an empty screen.
  Future<List<ListItem>?> load(String toolId) async {
    final json = await _kv.readJson(_key(toolId));
    if (json is! List) return null;
    return json
        .whereType<Map<String, Object?>>()
        .map(ListItem.fromJson)
        .toList();
  }

  Future<void> save(String toolId, List<ListItem> items) =>
      _kv.writeJson(_key(toolId), [for (final i in items) i.toJson()]);
}

/// Last values entered in a calculator or generator, so a tool reopens
/// where the user left it.
class ToolValuesStore {
  ToolValuesStore(this._kv);

  final KeyValueStore _kv;

  String _key(String toolId) => 'values.$toolId.v1';

  Future<Map<String, Object?>?> load(String toolId) async {
    final json = await _kv.readJson(_key(toolId));
    return json is Map<String, Object?> ? json : null;
  }

  Future<void> save(String toolId, Map<String, Object?> values) =>
      _kv.writeJson(_key(toolId), values);

  Future<void> clear(String toolId) => _kv.delete(_key(toolId));
}

/// When each tool was last opened. Feeds "Recently used" and the Launch
/// path steps that ask for a tool to be used.
class RecentToolsStore {
  RecentToolsStore(this._kv);

  static const _key = 'recent.v1';

  final KeyValueStore _kv;

  Future<Map<String, DateTime>> load() async {
    final json = await _kv.readJson(_key);
    if (json is! Map) return {};
    return {
      for (final e in json.entries)
        if (e.value case final String iso)
          e.key as String: ?DateTime.tryParse(iso),
    };
  }

  Future<void> save(Map<String, DateTime> recent) => _kv.writeJson(_key, {
    for (final e in recent.entries) e.key: e.value.toIso8601String(),
  });
}
