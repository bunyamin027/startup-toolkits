import 'dart:async';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/storage/key_value_store.dart';
import '../core/storage/storage_providers.dart';
import 'app_localizations.dart';

/// Languages offered in Profile, in their own names (not translated, so
/// people can find theirs whatever the current language is).
const languageNames = {
  'en': 'English',
  'tr': 'Türkçe',
  'fr': 'Français',
  'es': 'Español',
  'de': 'Deutsch',
};

/// The language picked in Profile; null follows the system language.
class LocaleStore {
  LocaleStore(this._kv);

  static const _key = 'locale.v1';

  final KeyValueStore _kv;

  Future<Locale?> load() async {
    final code = await _kv.read(_key);
    final supported = AppLocalizations.supportedLocales.map(
      (l) => l.languageCode,
    );
    return code != null && supported.contains(code) ? Locale(code) : null;
  }

  Future<void> save(Locale? locale) =>
      locale == null ? _kv.delete(_key) : _kv.write(_key, locale.languageCode);
}

final initialLocaleProvider = Provider<Locale?>((ref) => null);

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);

class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() => ref.read(initialLocaleProvider);

  void set(Locale? locale) {
    state = locale;
    unawaited(LocaleStore(ref.read(keyValueStoreProvider)).save(locale));
  }
}

/// The device's preferred languages; the app updates it when they change.
final systemLocalesProvider = NotifierProvider<SystemLocales, List<Locale>>(
  SystemLocales.new,
);

class SystemLocales extends Notifier<List<Locale>> {
  @override
  List<Locale> build() => PlatformDispatcher.instance.locales;

  void update(List<Locale> locales) => state = locales;
}

/// The language the app shows: the one picked in Profile, else the first
/// supported system language, else English. MaterialApp uses it as well, so
/// widgets (`context.tools`) and providers always agree.
final appLocaleProvider = Provider<Locale>((ref) {
  final picked = ref.watch(localeProvider);
  if (picked != null) return picked;
  final supported = {
    for (final l in AppLocalizations.supportedLocales) l.languageCode,
  };
  for (final l in ref.watch(systemLocalesProvider)) {
    if (supported.contains(l.languageCode)) return Locale(l.languageCode);
  }
  return const Locale('en');
});
