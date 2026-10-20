import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

import 'billing/billing_config.dart';
import 'billing/billing_service.dart';
import 'billing/entitlement_providers.dart';
import 'billing/revenuecat_billing.dart';
import 'core/bootstrap.dart';
import 'core/storage/key_value_store.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/welcome_screen.dart';
import 'features/shell/app_shell.dart';
import 'project/project_providers.dart';
import 'l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final kv = PrefsKeyValueStore();
  final overrides = await loadAppState(kv, DateTime.now());
  runApp(
    AppRoot(
      kv: kv,
      overrides: overrides,
      services: [
        billingServiceProvider.overrideWithValue(pickBillingService()),
      ],
    ),
  );
}

/// RevenueCat when a key was passed at build time; otherwise a preview
/// store in debug builds and no purchases in release builds.
BillingService pickBillingService() {
  final key = switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.macOS => BillingConfig.appleKey,
    TargetPlatform.android => BillingConfig.googleKey,
    _ => '',
  };
  if (key.isNotEmpty) return RevenueCatBillingService(key);
  return kDebugMode ? PreviewBillingService() : UnavailableBillingService();
}

/// Owns the provider scope so "Delete all data" can rebuild it from
/// freshly loaded state.
class AppRoot extends StatefulWidget {
  const AppRoot({
    super.key,
    required this.kv,
    required this.overrides,
    this.services = const [],
  });

  final KeyValueStore kv;

  /// Stored state from [loadAppState]; replaced on "Delete all data".
  final List<Override> overrides;

  /// Connections (store, analytics) that survive "Delete all data".
  final List<Override> services;

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
        ...widget.services,
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
    ref.watch(billingSyncProvider);
    final onboarded = ref.watch(onboardingDoneProvider);
    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // Dark is the designed theme; light stays a placeholder until drawn.
      themeMode: ThemeMode.dark,
      home: onboarded ? const AppShell() : const WelcomeScreen(),
    );
  }
}
