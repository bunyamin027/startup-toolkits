/// Number formatting shared by engines and UI.
///
/// Locale-aware formatting (intl) comes with l10n; until then output is en-US
/// style, which matches the English-first launch.
abstract final class Fmt {
  /// 120000 -> "120,000"; 11.428 with [decimals]=2 -> "11.43".
  static String number(num value, {int decimals = 0}) {
    if (value.isNaN || value.isInfinite) return '—';
    final negative = value < 0;
    final fixed = value.abs().toStringAsFixed(decimals);
    final parts = fixed.split('.');
    final intPart = _groupThousands(parts[0]);
    final out = parts.length > 1 ? '$intPart.${parts[1]}' : intPart;
    return negative ? '-$out' : out;
  }

  /// 10500 -> "$10,500". Whole amounts drop cents; others show two decimals.
  static String money(num value, {String symbol = r'$'}) {
    if (value.isNaN || value.isInfinite) return '—';
    // Round to cents first so float noise (114999.99999) reads as whole.
    final cents = (value * 100).round() / 100;
    final decimals = cents == cents.roundToDouble() ? 0 : 2;
    final body = number(cents.abs(), decimals: decimals);
    return cents < 0 ? '-$symbol$body' : '$symbol$body';
  }

  /// [ratio] 0.3333 -> "33.3%". Pass a ratio, not a percentage.
  static String percent(num ratio, {int decimals = 1}) {
    if (ratio.isNaN || ratio.isInfinite) return '—';
    return '${number(ratio * 100, decimals: decimals)}%';
  }

  /// 11.428 -> "11.4 months"; 1 -> "1 month".
  static String months(num value, {int decimals = 1}) {
    if (value.isNaN) return '—';
    if (value.isInfinite) return '∞';
    final text = number(value, decimals: decimals);
    return value == 1 ? '$text month' : '$text months';
  }

  static String _groupThousands(String digits) {
    final buf = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buf.write(',');
      buf.write(digits[i]);
    }
    return buf.toString();
  }
}
