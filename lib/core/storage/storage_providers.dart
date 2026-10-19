import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'key_value_store.dart';

/// Overridden in `main` with [PrefsKeyValueStore] and in tests with
/// [MemoryKeyValueStore].
final keyValueStoreProvider = Provider<KeyValueStore>(
  (ref) => throw UnimplementedError('Override keyValueStoreProvider'),
);
