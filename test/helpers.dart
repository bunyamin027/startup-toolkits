import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';
import 'package:startup_toolkits/core/storage/storage_providers.dart';
import 'package:startup_toolkits/core/theme/app_theme.dart';

/// Pumps [home] inside the app theme with in-memory storage, on an
/// iPhone-sized screen. Returns the container for reading providers.
Future<ProviderContainer> pumpApp(
  WidgetTester tester,
  Widget home, {
  KeyValueStore? kv,
  List<dynamic> overrides = const [],
}) async {
  tester.view.physicalSize = const Size(1179, 2556);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  final container = ProviderContainer.test(
    overrides: [
      keyValueStoreProvider.overrideWithValue(kv ?? MemoryKeyValueStore()),
      ...overrides.cast(),
    ],
  );
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp(theme: AppTheme.dark, home: home),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}
