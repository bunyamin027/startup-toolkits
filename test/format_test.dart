import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/core/format.dart';
import 'package:startup_toolkits/engines/inputs.dart';

void main() {
  test('money', () {
    expect(Fmt.en.money(120000), r'$120,000');
    expect(Fmt.en.money(49.5), r'$49.50');
    expect(Fmt.en.money(114999.99999999), r'$115,000');
    expect(Fmt.en.money(-1200), r'-$1,200');
    expect(Fmt.en.money(double.infinity), '—');
  });

  test('number, percent, months', () {
    expect(Fmt.en.number(1234567.891, decimals: 2), '1,234,567.89');
    expect(Fmt.en.number(-999), '-999');
    expect(Fmt.en.percent(0.3333), '33.3%');
    expect(Fmt.en.months(1), '1.0 month');
    expect(Fmt.en.months(11.428), '11.4 months');
    expect(Fmt.en.months(double.infinity), '∞');
  });

  test('formats follow the language', () {
    expect(Fmt.of('tr').money(120000), r'$120.000');
    expect(Fmt.of('de').money(49.5), '49,50\u00a0\$');
    expect(Fmt.of('es').number(1234567.891, decimals: 2), '1.234.567,89');
    expect(Fmt.of('tr').percent(0.3333), '%33,3');
    expect(Fmt.of('de').percent(0.3333), '33,3\u00a0%');
    expect(Fmt.of('de').months(1), '1,0 Monat');
    expect(Fmt.of('es').months(11.428), '11,4 meses');
    expect(Fmt.of('fr').months(3), '3,0 mois');
    expect(Fmt.of('tr').months(2), '2,0 ay');
    expect(Fmt.of('xx').money(10), r'$10');
  });

  test('typed numbers read with either decimal mark', () {
    expect(Inputs.toNumber('120,000'), 120000);
    expect(Inputs.toNumber('12,5'), 12.5);
    expect(Inputs.toNumber('1.234,5'), 1234.5);
    expect(Inputs.toNumber('1,234.5'), 1234.5);
    expect(Inputs.toNumber('1.234.567'), 1234567);
    expect(Inputs.toNumber('12.5'), 12.5);
    expect(Inputs.toNumber('%8'), 8);
    expect(Inputs.toNumber('49,50\u00a0\$'), 49.5);
  });
}
