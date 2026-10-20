/// Read-only view over a tool's raw field values.
///
/// Form fields hand over strings ("120,000", "12.5%") or numbers; engines
/// always read numbers through [n] so parsing lives in one place. Empty or
/// unparseable values read as 0, which is what an empty form field means.
class Inputs {
  const Inputs(this.values);

  final Map<String, Object?> values;

  double n(String key) => toNumber(values[key]) ?? 0;

  String s(String key) => values[key]?.toString() ?? '';

  /// Reads both "1,234.5" and "1.234,5". A lone comma is a decimal comma
  /// ("12,5") unless it groups thousands ("120,000"); a lone dot is always
  /// a decimal point, as the app shows numbers to edit that way.
  static double? toNumber(Object? raw) {
    if (raw == null) return null;
    if (raw is num) return raw.toDouble();
    var s = raw.toString().replaceAll(RegExp(r'[\s\u00a0\u202f$%€£₺]'), '');
    final comma = s.lastIndexOf(',');
    final dot = s.lastIndexOf('.');
    if (comma >= 0 && dot >= 0) {
      s = comma > dot
          ? s.replaceAll('.', '').replaceAll(',', '.')
          : s.replaceAll(',', '');
    } else if (comma >= 0) {
      s = RegExp(r'^-?\d{1,3}(,\d{3})+$').hasMatch(s)
          ? s.replaceAll(',', '')
          : s.replaceAll(',', '.');
    } else if (RegExp(r'\..*\.').hasMatch(s)) {
      s = s.replaceAll('.', '');
    }
    return double.tryParse(s);
  }
}
