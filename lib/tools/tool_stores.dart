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
