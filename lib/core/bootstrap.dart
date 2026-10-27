import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

import '../billing/entitlement.dart';
import '../billing/entitlement_providers.dart';
import '../l10n/locale_providers.dart';
import '../project/project_providers.dart';
import '../project/project_store.dart';
import '../tools/tool_providers.dart';
import '../tools/tool_stores.dart';
import 'currency.dart';
import 'storage/key_value_store.dart';
import 'storage/storage_providers.dart';
import 'theme/theme_providers.dart';

/// Reads everything screens need synchronously, so the first frame never
/// shows a loading state. All reads are small local values.
Future<List<Override>> loadAppState(KeyValueStore kv, DateTime now) async {
  final (
    project,
    favorites,
    recent,
    entitlement,
    onboarded,
    locale,
    theme,
    currency,
  ) = await (
    ProjectStore(kv).load(),
    FavoritesStore(kv).load(),
    RecentToolsStore(kv).load(),
    EntitlementStore(kv).load(now),
    OnboardingStore(kv).load(),
    LocaleStore(kv).load(),
    ThemeModeStore(kv).load(),
    CurrencyStore(kv).load(),
  ).wait;
  return [
    keyValueStoreProvider.overrideWithValue(kv),
    initialProjectProvider.overrideWithValue(project),
    initialFavoritesProvider.overrideWithValue(favorites),
    initialRecentToolsProvider.overrideWithValue(recent),
    initialEntitlementProvider.overrideWithValue(entitlement),
    initialOnboardingDoneProvider.overrideWithValue(onboarded),
    initialLocaleProvider.overrideWithValue(locale),
    initialThemeModeProvider.overrideWithValue(theme),
    initialCurrencyProvider.overrideWithValue(currency),
  ];
}

/// Wipes local data (Profile → Delete all data) and returns fresh state.
Future<List<Override>> resetAppState(KeyValueStore kv, DateTime now) async {
  // The trial clock survives a reset so deleting data cannot restart it.
  // Language, appearance and currency are settings, not data, so they
  // survive too.
  final entitlement = await EntitlementStore(kv).load(now);
  final locale = await LocaleStore(kv).load();
  final theme = await ThemeModeStore(kv).load();
  final currency = await CurrencyStore(kv).load();
  await kv.clear();
  await LocaleStore(kv).save(locale);
  await ThemeModeStore(kv).save(theme);
  await CurrencyStore(kv).save(currency);
  await EntitlementStore(kv).save(
    Entitlement(
      firstLaunch: entitlement.firstLaunch,
      subscribed: entitlement.subscribed,
    ),
  );
  return loadAppState(kv, now);
}

/// Profile → Delete all data. The app root overrides it to wipe storage and
/// rebuild the provider scope from scratch.
final deleteAllDataProvider = Provider<Future<void> Function()>(
  (ref) => throw UnimplementedError('Override deleteAllDataProvider'),
);
