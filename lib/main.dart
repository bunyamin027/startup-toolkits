import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/storage/key_value_store.dart';
import 'core/storage/storage_providers.dart';
import 'core/theme/app_theme.dart';
import 'features/catalog/catalog_screen.dart';
import 'project/project_providers.dart';
import 'project/project_store.dart';
import 'tools/tool_providers.dart';
import 'tools/tool_stores.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final kv = PrefsKeyValueStore();
  // Small, local reads: done before the first frame so screens never show
  // a loading state for the project or favorites.
  final project = await ProjectStore(kv).load();
  final favorites = await FavoritesStore(kv).load();
  runApp(
    ProviderScope(
      overrides: [
        keyValueStoreProvider.overrideWithValue(kv),
        initialProjectProvider.overrideWithValue(project),
        initialFavoritesProvider.overrideWithValue(favorites),
      ],
      child: const StartupToolkitsApp(),
    ),
  );
}

class StartupToolkitsApp extends StatelessWidget {
  const StartupToolkitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Toolkits',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // Dark is the designed theme; light stays a placeholder until drawn.
      themeMode: ThemeMode.dark,
      // Home ("Mission control") replaces the catalog in Sprint 3.
      home: const CatalogScreen(),
    );
  }
}
