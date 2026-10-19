import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

import 'core/bootstrap.dart';
import 'core/storage/key_value_store.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/welcome_screen.dart';
import 'features/shell/app_shell.dart';
import 'project/project_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final kv = PrefsKeyValueStore();
  final overrides = await loadAppState(kv, DateTime.now());
  runApp(AppRoot(kv: kv, overrides: overrides));
}

/// Owns the provider scope so "Delete all data" can rebuild it from
/// freshly loaded state.
class AppRoot extends StatefulWidget {
  const AppRoot({super.key, required this.kv, required this.overrides});

  final KeyValueStore kv;
  final List<Override> overrides;

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  late List<Override> _overrides = widget.overrides;
  Key _scope = UniqueKey();

  Future<void> _deleteAllData() async {
    final fresh = await resetAppState(widget.kv, DateTime.now());
    if (!mounted) return;
    setState(() {
      _overrides = fresh;
      _scope = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      key: _scope,
      overrides: [
        ..._overrides,
        deleteAllDataProvider.overrideWithValue(_deleteAllData),
      ],
      child: const StartupToolkitsApp(),
    );
  }
}

class StartupToolkitsApp extends ConsumerWidget {
  const StartupToolkitsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboarded = ref.watch(onboardingDoneProvider);
    return MaterialApp(
      title: 'Startup Toolkits',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // Dark is the designed theme; light stays a placeholder until drawn.
      themeMode: ThemeMode.dark,
      home: onboarded ? const AppShell() : const WelcomeScreen(),
    );
  }
}
