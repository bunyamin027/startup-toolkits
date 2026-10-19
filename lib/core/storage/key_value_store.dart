import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Minimal persistence port. v1 keeps everything on device (master plan §2);
/// stores depend on this interface so tests use [MemoryKeyValueStore] and a
/// later cloud sync can swap the implementation.
abstract interface class KeyValueStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

extension JsonKeyValueStore on KeyValueStore {
  /// Returns null when the key is missing or holds corrupt JSON, so a bad
  /// write never bricks app start.
  Future<Object?> readJson(String key) async {
    final raw = await read(key);
    if (raw == null) return null;
    try {
      return jsonDecode(raw);
    } on FormatException {
      return null;
    }
  }

  Future<void> writeJson(String key, Object? value) =>
      write(key, jsonEncode(value));
}

class PrefsKeyValueStore implements KeyValueStore {
  PrefsKeyValueStore([SharedPreferencesAsync? prefs])
    : _prefs = prefs ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _prefs;

  @override
  Future<String?> read(String key) => _prefs.getString(key);

  @override
  Future<void> write(String key, String value) => _prefs.setString(key, value);

  @override
  Future<void> delete(String key) => _prefs.remove(key);
}

class MemoryKeyValueStore implements KeyValueStore {
  final Map<String, String> data = {};

  @override
  Future<String?> read(String key) async => data[key];

  @override
  Future<void> write(String key, String value) async => data[key] = value;

  @override
  Future<void> delete(String key) async => data.remove(key);
}
