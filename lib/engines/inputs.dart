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

  static double? toNumber(Object? raw) {
    if (raw == null) return null;
    if (raw is num) return raw.toDouble();
    final cleaned = raw.toString().replaceAll(RegExp(r'[\s,$%€£₺]'), '');
    return double.tryParse(cleaned);
  }
}
