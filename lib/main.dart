import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

import 'billing/billing_service.dart';
import 'billing/entitlement_providers.dart';
import 'billing/store_billing.dart';
import 'core/bootstrap.dart';
import 'core/currency.dart';
import 'core/storage/key_value_store.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_providers.dart';
import 'features/onboarding/welcome_screen.dart';
import 'features/shell/app_shell.dart';
import 'project/project_providers.dart';
import 'l10n/l10n.dart';
import 'l10n/locale_providers.dart';

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

/// The App Store / Google Play in profile and release builds (TestFlight
/// included); a preview store in debug builds, where the store has no
/// products to offer.
BillingService pickBillingService() {
  if (kDebugMode) return PreviewBillingService();
  return switch (defaultTargetPlatform) {
    TargetPlatform.iOS || TargetPlatform.android => StoreBillingService(),
    _ => UnavailableBillingService(),
  };
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

class StartupToolkitsApp extends ConsumerStatefulWidget {
  const StartupToolkitsApp({super.key});

  @override
  ConsumerState<StartupToolkitsApp> createState() => _StartupToolkitsAppState();
}

class _StartupToolkitsAppState extends ConsumerState<StartupToolkitsApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// System language changed while the app runs (no Profile choice made).
  @override
  void didChangeLocales(List<Locale>? locales) {
    if (locales != null) {
      ref.read(systemLocalesProvider.notifier).update(locales);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(billingSyncProvider);
    final onboarded = ref.watch(onboardingDoneProvider);
    return MaterialApp(
      onGenerateTitle: (context) => context.l10n.appName,
      locale: ref.watch(appLocaleProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ref.watch(themeModeProvider),
      // Tab screens have no app bar, so the status bar style is set here.
      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppTheme.overlayStyle(Theme.of(context).brightness),
        child: CurrencyScope(
          code: ref.watch(appCurrencyProvider),
          child: SectorScope(
            sector: ref.watch(projectProvider.select((p) => p.scenario)),
            child: child!,
          ),
        ),
      ),
      home: onboarded ? const AppShell() : const WelcomeScreen(),
    );
  }
}
