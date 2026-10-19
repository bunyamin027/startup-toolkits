import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/core/format.dart';

void main() {
  test('money', () {
    expect(Fmt.money(120000), r'$120,000');
    expect(Fmt.money(49.5), r'$49.50');
    expect(Fmt.money(114999.99999999), r'$115,000');
    expect(Fmt.money(-1200), r'-$1,200');
    expect(Fmt.money(double.infinity), '—');
  });

  test('number, percent, months', () {
    expect(Fmt.number(1234567.891, decimals: 2), '1,234,567.89');
    expect(Fmt.number(-999), '-999');
    expect(Fmt.percent(0.3333), '33.3%');
    expect(Fmt.months(1), '1.0 month');
    expect(Fmt.months(11.428), '11.4 months');
    expect(Fmt.months(double.infinity), '∞');
  });
}
