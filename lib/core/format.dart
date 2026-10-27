import 'package:intl/intl.dart';

import 'currency.dart';

/// Number formatting shared by engines and UI, in the app's language and
/// currency: `Fmt.of('tr', 'TRY').money(120000)` is "₺120.000",
/// `Fmt.of('de', 'EUR')` gives "120.000 €", `Fmt.en` gives "$120,000".
///
/// The currency (Profile) picks the symbol; grouping, decimals and where the
/// symbol goes follow the language.
class Fmt {
  Fmt._(this.language, this.currencyCode);

  /// Cached per language and currency; unknown languages format as English,
  /// unknown currencies as US dollars.
  factory Fmt.of(String language, [String currency = 'USD']) {
    final lang = _months.containsKey(language) ? language : 'en';
    final code = currencySymbols.containsKey(currency) ? currency : 'USD';
    return _cache['$lang|$code'] ??= Fmt._(lang, code);
  }

  static final Fmt en = Fmt.of('en');
  static final _cache = <String, Fmt>{};

  final String language;

  /// ISO code of the currency amounts are written in, e.g. "TRY".
  final String currencyCode;

  /// Symbol shown in amounts and in money input fields, e.g. "₺".
  String get symbol => currencySymbols[currencyCode]!;

  /// "month" / "months" per language.
  static const _months = {
    'en': ('month', 'months'),
    'tr': ('ay', 'ay'),
    'fr': ('mois', 'mois'),
    'es': ('mes', 'meses'),
    'de': ('Monat', 'Monate'),
  };

  final _numbers = <int, NumberFormat>{};
  final _money = <int, NumberFormat>{};
  final _percents = <int, NumberFormat>{};

  /// 120000 -> "120,000"; 11.428 with [decimals]=2 -> "11.43".
  String number(num value, {int decimals = 0}) {
    if (value.isNaN || value.isInfinite) return '—';
    final f = _numbers[decimals] ??= NumberFormat.decimalPattern(language)
      ..minimumFractionDigits = decimals
      ..maximumFractionDigits = decimals;
    // "-0" reads oddly once rounded.
    final out = f.format(value);
    return out.startsWith('-') && f.format(value.abs()) == f.format(0)
        ? out.substring(1)
        : out;
  }

  /// 10500 -> "$10,500" (or "₺10.500"). Whole amounts drop cents; others
  /// show two decimals.
  String money(num value) {
    if (value.isNaN || value.isInfinite) return '—';
    // Round to cents first so float noise (114999.99999) reads as whole.
    final cents = (value * 100).round() / 100;
    final decimals =
        zeroDecimalCurrencies.contains(currencyCode) ||
            cents == cents.roundToDouble()
        ? 0
        : 2;
    final f = _money[decimals] ??= NumberFormat.currency(
      locale: language,
      name: currencyCode,
      symbol: symbol,
      decimalDigits: decimals,
    );
    final out = f.format(decimals == 0 ? cents.round() : cents);
    // Letter codes in front need a gap: "CHF 1,200", not "CHF1,200".
    if (RegExp(r'^[A-Z]{2,}$').hasMatch(symbol)) {
      final negative = out.startsWith('-');
      final body = negative ? out.substring(1) : out;
      if (body.startsWith(symbol) && !body.startsWith('$symbol\u00A0')) {
        return '${negative ? '-' : ''}$symbol\u00A0${body.substring(symbol.length)}';
      }
    }
    return out;
  }

  /// A store price in its own currency, e.g. 83.33 TRY -> "₺83,33" in
  /// Turkish; always two decimals.
  String currency(num value, String currencyCode) {
    if (value.isNaN || value.isInfinite) return '—';
    return NumberFormat.simpleCurrency(
      locale: language,
      name: currencyCode,
      decimalDigits: 2,
    ).format(value);
  }

  /// [ratio] 0.3333 -> "33.3%". Pass a ratio, not a percentage.
  String percent(num ratio, {int decimals = 1}) {
    if (ratio.isNaN || ratio.isInfinite) return '—';
    final f = _percents[decimals] ??= NumberFormat.percentPattern(language)
      ..minimumFractionDigits = decimals
      ..maximumFractionDigits = decimals;
    return f.format(ratio);
  }

  /// 11.428 -> "11.4 months"; 1 -> "1.0 month".
  String months(num value, {int decimals = 1}) {
    if (value.isNaN) return '—';
    if (value.isInfinite) return '∞';
    final (one, many) = _months[language]!;
    return '${number(value, decimals: decimals)} ${value == 1 ? one : many}';
  }

  /// 3.25 -> "3.3×".
  String ratio(num value) =>
      value.isInfinite ? '∞' : '${number(value, decimals: 1)}×';
}
