import 'package:flutter_test/flutter_test.dart';
import 'package:startup_toolkits/engines/calc_engine.dart';

void main() {
  group('runway', () {
    test('plan example: 120k cash, 14k spend, 3.5k revenue', () {
      final r = CalcEngine.run('runway', {
        'cash': 120000,
        'monthlyExpenses': 14000,
        'monthlyRevenue': 3500,
      });
      expect(r['netBurn'], 10500);
      expect(r['runway'], closeTo(11.43, 0.005));
      expect(r.outputs.last.display, '11.4 months');
      expect(r.verdict, isNull);
    });

    test('revenue covering spend means profitable, no burn', () {
      final r = CalcEngine.run('runway', {
        'cash': 50000,
        'monthlyExpenses': 8000,
        'monthlyRevenue': 8000,
      });
      expect(r['netBurn'], 0);
      expect(r['runway'], double.infinity);
      expect(r.verdict, 'Profitable, no burn');
    });

    test('accepts formatted strings from form fields', () {
      final r = CalcEngine.run('runway', {
        'cash': r'$120,000',
        'monthlyExpenses': '14,000',
        'monthlyRevenue': '3500',
      });
      expect(r['runway'], closeTo(11.43, 0.005));
    });
  });

  test('unit economics', () {
    final r = CalcEngine.run('unitEconomics', {
      'arpu': 50,
      'grossMargin': 80,
      'churn': 5,
      'cac': 300,
    });
    expect(r['lifetime'], 20);
    expect(r['ltv'], 800); // 50 × 80 / 5
    expect(r['ltvCac'], closeTo(2.667, 0.001));
    expect(r['payback'], 7.5); // 300 / (50 × 0.8)
    expect(r.verdict, 'Below the 3× benchmark');
  });

  test('unit economics with zero churn does not produce NaN', () {
    final r = CalcEngine.run('unitEconomics', {
      'arpu': 50,
      'grossMargin': 80,
      'churn': 0,
      'cac': 300,
    });
    expect(r['ltv'], double.infinity);
    expect(r.outputs.every((o) => !o.value.isNaN), isTrue);
  });

  test('pricing', () {
    final r = CalcEngine.run('pricing', {
      'unitCost': 30,
      'targetMargin': 40,
      'competitorPrice': 60,
    });
    expect(r['price'], closeTo(50, 1e-9));
    expect(r['competitorMargin'], 0.5);
  });

  test('cap table', () {
    final r = CalcEngine.run('capTable', {
      'preMoney': 4000000,
      'investment': 1000000,
      'existingShares': 8000000,
    });
    expect(r['postMoney'], 5000000);
    expect(r['investorStake'], 0.2);
    expect(r['existingStake'], 0.8);
    expect(r['newShares'], 2000000);
    expect(r['sharePrice'], 0.5);
  });

  group('valuation multiple bands', () {
    double low(num growth) =>
        CalcEngine.run('valuation', {'arr': 1000000, 'growth': growth})['low'];
    double high(num growth) =>
        CalcEngine.run('valuation', {'arr': 1000000, 'growth': growth})['high'];

    test('growth ≥100% → 6–12×', () {
      expect(low(100), 6000000);
      expect(high(150), 12000000);
    });
    test('growth ≥50% → 4–8×', () {
      expect(low(50), 4000000);
      expect(high(99), 8000000);
    });
    test('growth below 50% → 3–6×', () {
      expect(low(49), 3000000);
      expect(high(10), 6000000);
    });
  });

  group('idea score', () {
    Map<String, Object?> scores(List<int> s) => {
      for (var i = 0; i < 6; i++) CalcEngine.ideaCriteria[i]: s[i],
    };

    test('thresholds 24 / 17', () {
      expect(
        CalcEngine.run('ideaScore', scores([4, 4, 4, 4, 4, 4])).verdict,
        'Strong',
      );
      expect(
        CalcEngine.run('ideaScore', scores([4, 4, 4, 4, 4, 3])).verdict,
        'Promising',
      );
      expect(
        CalcEngine.run('ideaScore', scores([3, 3, 3, 3, 3, 2])).verdict,
        'Promising',
      );
      expect(
        CalcEngine.run('ideaScore', scores([3, 3, 3, 3, 2, 2])).verdict,
        'Weak',
      );
    });

    test('total and ratio of 30', () {
      final r = CalcEngine.run('ideaScore', scores([5, 5, 5, 5, 5, 5]));
      expect(r['total'], 30);
      expect(r['ratio'], 1);
    });
  });

  group('A/B test', () {
    test('normal CDF matches known values', () {
      expect(CalcEngine.normalCdf(0), closeTo(0.5, 1e-7));
      expect(CalcEngine.normalCdf(1.96), closeTo(0.975, 1e-4));
      expect(CalcEngine.normalCdf(-1.96), closeTo(0.025, 1e-4));
    });

    test('clear winner is significant', () {
      final r = CalcEngine.run('abTest', {
        'visitorsA': 1000,
        'conversionsA': 100,
        'visitorsB': 1000,
        'conversionsB': 130,
      });
      // pooled p = 0.115, se = sqrt(0.115·0.885·0.002) ≈ 0.014267
      expect(r['z'], closeTo(2.1028, 0.001));
      expect(r['confidence'], closeTo(0.9645, 0.001));
      expect(r['uplift'], closeTo(0.3, 1e-9));
      expect(r.verdict, 'Significant');
    });

    test('small difference is not significant', () {
      final r = CalcEngine.run('abTest', {
        'visitorsA': 1000,
        'conversionsA': 100,
        'visitorsB': 1000,
        'conversionsB': 110,
      });
      expect(r['confidence'], lessThan(0.95));
      expect(r.verdict, 'Not significant yet');
    });

    test('empty inputs give zero confidence, not NaN', () {
      final r = CalcEngine.run('abTest', {});
      expect(r['confidence'], closeTo(0, 1e-7));
      expect(r.outputs.every((o) => !o.value.isNaN), isTrue);
    });
  });

  test('funnel', () {
    final r = CalcEngine.run('funnel', {
      'visitors': 10000,
      'signups': 800,
      'active': 400,
      'paying': 40,
    });
    expect(r['visitorToSignup'], 0.08);
    expect(r['signupToActive'], 0.5);
    expect(r['activeToPaying'], 0.1);
    expect(r['overall'], 0.004);
  });

  test('unknown formula throws', () {
    expect(() => CalcEngine.run('nope', {}), throwsArgumentError);
  });
}
