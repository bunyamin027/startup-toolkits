import 'dart:async';
import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'storage/key_value_store.dart';
import 'storage/storage_providers.dart';

/// Currencies offered in Profile, with the symbol shown in amounts. Symbols
/// are ours rather than intl's defaults, which use the old "TL" for the lira
/// and an ambiguous "$" for Canadian or Australian dollars.
const currencySymbols = {
  'USD': r'$',
  'EUR': '€',
  'GBP': '£',
  'TRY': '₺',
  'CHF': 'CHF',
  'CAD': r'CA$',
  'AUD': r'A$',
  'JPY': '¥',
  'INR': '₹',
  'BRL': r'R$',
  'MXN': r'MX$',
  'AED': 'AED',
  'SAR': 'SAR',
};

/// "TRY · ₺": code and symbol, readable in every language.
String currencyLabel(String code) {
  final symbol = currencySymbols[code] ?? code;
  return symbol == code ? code : '$code · $symbol';
}

/// Currencies written without decimals.
const zeroDecimalCurrencies = {'JPY'};

const _euroCountries = {
  'AT', 'BE', 'CY', 'DE', 'EE', 'ES', 'FI', 'FR', 'GR', 'HR', 'IE', //
  'IT', 'LT', 'LU', 'LV', 'MT', 'NL', 'PT', 'SI', 'SK',
};

const _countryCurrencies = {
  'US': 'USD',
  'GB': 'GBP',
  'TR': 'TRY',
  'CH': 'CHF',
  'CA': 'CAD',
  'AU': 'AUD',
  'JP': 'JPY',
  'IN': 'INR',
  'BR': 'BRL',
  'MX': 'MXN',
  'AE': 'AED',
  'SA': 'SAR',
};

/// The currency of a device region, or US dollars when we do not offer it.
String currencyForRegion(String? countryCode) {
  final country = countryCode?.toUpperCase();
  if (country == null) return 'USD';
  if (_euroCountries.contains(country)) return 'EUR';
  return _countryCurrencies[country] ?? 'USD';
}

/// The currency picked in Profile; null follows the device region.
class CurrencyStore {
  CurrencyStore(this._kv);

  static const _key = 'currency.v1';

  final KeyValueStore _kv;

  Future<String?> load() async {
    final code = await _kv.read(_key);
    return currencySymbols.containsKey(code) ? code : null;
  }

  Future<void> save(String? code) =>
      code == null ? _kv.delete(_key) : _kv.write(_key, code);
}

final initialCurrencyProvider = Provider<String?>((ref) => null);

/// The choice made in Profile, or null for automatic.
final currencyProvider = NotifierProvider<CurrencyNotifier, String?>(
  CurrencyNotifier.new,
);

class CurrencyNotifier extends Notifier<String?> {
  @override
  String? build() => ref.read(initialCurrencyProvider);

  void set(String? code) {
    state = code;
    unawaited(CurrencyStore(ref.read(keyValueStoreProvider)).save(code));
  }
}

/// Device region; a seam so tests can pin it.
final regionProvider = Provider<String?>(
  (ref) => PlatformDispatcher.instance.locale.countryCode,
);

/// The currency amounts are shown in. Changing it relabels amounts; it does
/// not convert them, since every number is one the user typed.
final appCurrencyProvider = Provider<String>(
  (ref) =>
      ref.watch(currencyProvider) ??
      currencyForRegion(ref.watch(regionProvider)),
);

/// Makes the app currency available to `context.fmt` without a ref.
class CurrencyScope extends InheritedWidget {
  const CurrencyScope({super.key, required this.code, required super.child});

  final String code;

  /// The app currency, or US dollars outside the app (tests of one widget).
  static String of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CurrencyScope>()?.code ??
      'USD';

  @override
  bool updateShouldNotify(CurrencyScope old) => old.code != code;
}
