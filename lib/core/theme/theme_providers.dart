import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/key_value_store.dart';
import '../storage/storage_providers.dart';

/// Appearance picked in Profile; [ThemeMode.system] follows the device.
class ThemeModeStore {
  ThemeModeStore(this._kv);

  static const _key = 'theme.v1';

  final KeyValueStore _kv;

  Future<ThemeMode> load() async {
    final name = await _kv.read(_key);
    return ThemeMode.values.where((m) => m.name == name).firstOrNull ??
        ThemeMode.system;
  }

  Future<void> save(ThemeMode mode) =>
      mode == ThemeMode.system ? _kv.delete(_key) : _kv.write(_key, mode.name);
}

final initialThemeModeProvider = Provider<ThemeMode>((ref) => ThemeMode.system);

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.read(initialThemeModeProvider);

  void set(ThemeMode mode) {
    state = mode;
    unawaited(ThemeModeStore(ref.read(keyValueStoreProvider)).save(mode));
  }
}
