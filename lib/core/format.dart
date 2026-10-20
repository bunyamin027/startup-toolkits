import 'package:intl/intl.dart';

/// Number formatting shared by engines and UI, in the app's language:
/// `Fmt.of('de').money(120000)` is "120.000 $", `Fmt.en` gives "$120,000".
///
/// Amounts stay in dollars in every language; only grouping, decimals and
/// symbol placement follow the language.
class Fmt {
  Fmt._(this.language);

  /// Cached per language; unknown languages format as English.
  factory Fmt.of(String language) => _cache[language] ??= Fmt._(
    _months.containsKey(language) ? language : 'en',
  );

  static final Fmt en = Fmt.of('en');
  static final _cache = <String, Fmt>{};

  final String language;

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

  /// 10500 -> "$10,500". Whole amounts drop cents; others show two decimals.
  String money(num value) {
    if (value.isNaN || value.isInfinite) return '—';
    // Round to cents first so float noise (114999.99999) reads as whole.
    final cents = (value * 100).round() / 100;
    final decimals = cents == cents.roundToDouble() ? 0 : 2;
    final f = _money[decimals] ??= NumberFormat.currency(
      locale: language,
      symbol: r'$',
      decimalDigits: decimals,
    );
    return f.format(cents);
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
