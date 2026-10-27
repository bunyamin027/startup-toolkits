// Shared by the store screenshot and preview tools: the app as it runs,
// rendered in the test engine with the system SF font.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/billing/billing_service.dart';
import 'package:startup_toolkits/billing/entitlement_providers.dart';
import 'package:startup_toolkits/core/bootstrap.dart';
import 'package:startup_toolkits/core/currency.dart';
import 'package:startup_toolkits/core/storage/key_value_store.dart';
import 'package:startup_toolkits/core/theme/app_theme.dart';
import 'package:startup_toolkits/core/theme/theme_providers.dart';
import 'package:startup_toolkits/features/shell/app_shell.dart';
import 'package:startup_toolkits/l10n/l10n.dart';
import 'package:startup_toolkits/l10n/locale_providers.dart';
import 'package:startup_toolkits/project/project_providers.dart';
import 'package:startup_toolkits/project/project_store.dart';

import 'terralab.dart';

Future<void> loadFonts() async {
  final sf = File('/System/Library/Fonts/SFNS.ttf').readAsBytesSync();
  for (final family in [
    'CupertinoSystemText',
    'CupertinoSystemDisplay',
    '.SF Pro Text',
    '.SF Pro Display',
    '.SF UI Text',
    '.SF UI Display',
    'Roboto',
    'FlutterTest',
  ]) {
    await (FontLoader(
      family,
    )..addFont(Future.value(ByteData.sublistView(sf)))).load();
  }
  const dir = '/opt/homebrew/share/flutter/bin/cache/artifacts/material_fonts';
  await (FontLoader('MaterialIcons')..addFont(
        Future.value(
          ByteData.sublistView(
            File('$dir/MaterialIcons-Regular.otf').readAsBytesSync(),
          ),
        ),
      ))
      .load();
}

Future<void> pumpAppState(
  WidgetTester tester,
  String lang, {
  required bool withProject,
}) async {
  final kv = MemoryKeyValueStore();
  await OnboardingStore(kv).save(true);
  await LocaleStore(kv).save(Locale(lang));
  await ThemeModeStore(kv).save(ThemeMode.dark);
  if (withProject) await ProjectStore(kv).save(terralab(lang));
  final overrides = await loadAppState(kv, DateTime.now());
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        ...overrides,
        billingServiceProvider.overrideWithValue(ShotStore()),
      ],
      child: const ShotApp(),
    ),
  );
  await tester.pumpAndSettle();
}

/// The app's root (main.dart) with the theme's two family-less styles
/// pinned to SF, which the test engine would otherwise draw as boxes.
class ShotApp extends ConsumerWidget {
  const ShotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final base = AppTheme.dark;
    const sf = 'CupertinoSystemText';
    final theme = base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        titleTextStyle: base.appBarTheme.titleTextStyle!.copyWith(
          fontFamily: sf,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: (base.textButtonTheme.style ?? const ButtonStyle()).copyWith(
          textStyle: const WidgetStatePropertyAll(TextStyle(fontFamily: sf)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: base.filledButtonTheme.style!.copyWith(
          textStyle: const WidgetStatePropertyAll(
            TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: sf,
            ),
          ),
        ),
      ),
    );
    return MaterialApp(
      locale: ref.watch(appLocaleProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: theme,
      builder: (context, child) => CurrencyScope(
        code: ref.watch(appCurrencyProvider),
        child: SectorScope(
          sector: ref.watch(projectProvider.select((p) => p.scenario)),
          child: child!,
        ),
      ),
      home: const AppShell(),
    );
  }
}

/// Launch prices without the preview-store note.
class ShotStore extends PreviewBillingService {
  @override
  bool get isPreview => false;
}
