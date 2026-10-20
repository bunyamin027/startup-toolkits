import 'dart:math' as math;

import 'package:flutter/foundation.dart';

import '../core/format.dart';
import 'inputs.dart';

enum ValueFormat { money, percent, months, number, ratio, count }

/// One result row of a calculator, e.g. "Runway: 11.4 months".
@immutable
class CalcOutput {
  const CalcOutput(this.key, this.label, this.value, this.format);

  final String key;
  final String label;

  /// Raw value. Percentages are ratios (0.33), months may be infinite.
  final double value;
  final ValueFormat format;

  /// The value in English formatting; screens use [formatIn].
  String get display => formatIn(Fmt.en);

  String formatIn(Fmt fmt) => formatValue(value, fmt);

  String formatValue(double v, Fmt fmt) => switch (format) {
    ValueFormat.money => fmt.money(v),
    ValueFormat.percent => fmt.percent(v),
    ValueFormat.months => fmt.months(v),
    ValueFormat.number => fmt.number(v, decimals: 2),
    ValueFormat.ratio => fmt.ratio(v),
    ValueFormat.count => fmt.number(v),
  };
}

@immutable
class CalcResult {
  const CalcResult(this.outputs, {this.verdict});

  final List<CalcOutput> outputs;

  /// Short human reading of the numbers ("Profitable, no burn").
  final String? verdict;

  double operator [](String key) =>
      outputs.firstWhere((o) => o.key == key).value;
}

typedef Formula = CalcResult Function(Inputs inputs);

/// Calculator formulas from master plan §4. Every `ToolDef.formula` of a calc
/// tool must be a key of [formulas].
abstract final class CalcEngine {
  static const Map<String, Formula> formulas = {
    'runway': runway,
    'unitEconomics': unitEconomics,
    'pricing': pricing,
    'capTable': capTable,
    'valuation': valuation,
    'ideaScore': ideaScore,
    'abTest': abTest,
    'funnel': funnel,
  };

  /// Every verdict a formula can return; tool translations cover each.
  static const verdicts = [
    'Profitable, no burn',
    'Healthy (3× or more)',
    'Below the 3× benchmark',
    'Rough estimate only, not a valuation',
    'Strong',
    'Promising',
    'Weak',
    'Significant',
    'Not significant yet',
  ];

  static CalcResult run(String formula, Map<String, Object?> values) {
    final f = formulas[formula];
    if (f == null) throw ArgumentError.value(formula, 'formula', 'unknown');
    return f(Inputs(values));
  }

  /// cash, monthlyExpenses, monthlyRevenue.
  static CalcResult runway(Inputs i) {
    final cash = i.n('cash');
    final burn = i.n('monthlyExpenses') - i.n('monthlyRevenue');
    final netBurn = math.max(burn, 0).toDouble();
    final months = burn > 0 ? cash / burn : double.infinity;
    return CalcResult([
      CalcOutput('netBurn', 'Net burn', netBurn, ValueFormat.money),
      CalcOutput('runway', 'Runway', months, ValueFormat.months),
    ], verdict: burn > 0 ? null : 'Profitable, no burn');
  }

  /// arpu (monthly), grossMargin %, churn % (monthly), cac.
  static CalcResult unitEconomics(Inputs i) {
    final arpu = i.n('arpu');
    final margin = i.n('grossMargin');
    final churn = i.n('churn');
    final cac = i.n('cac');
    final lifetime = _div(100, churn);
    final ltv = _div(arpu * margin, churn);
    final ltvCac = _div(ltv, cac);
    final payback = _div(cac, arpu * margin / 100);
    return CalcResult(
      [
        CalcOutput(
          'lifetime',
          'Customer lifetime',
          lifetime,
          ValueFormat.months,
        ),
        CalcOutput('ltv', 'LTV', ltv, ValueFormat.money),
        CalcOutput('ltvCac', 'LTV:CAC', ltvCac, ValueFormat.ratio),
        CalcOutput('payback', 'CAC payback', payback, ValueFormat.months),
      ],
      verdict: ltvCac >= 3 ? 'Healthy (3× or more)' : 'Below the 3× benchmark',
    );
  }

  /// unitCost, targetMargin %, competitorPrice.
  static CalcResult pricing(Inputs i) {
    final cost = i.n('unitCost');
    final target = i.n('targetMargin');
    final competitor = i.n('competitorPrice');
    final price = target < 100 ? cost / (1 - target / 100) : double.infinity;
    final competitorMargin = _div(competitor - cost, competitor);
    return CalcResult([
      CalcOutput('price', 'Suggested price', price, ValueFormat.money),
      CalcOutput(
        'competitorMargin',
        'Your margin at competitor price',
        competitorMargin,
        ValueFormat.percent,
      ),
    ]);
  }

  /// preMoney, investment, existingShares.
  static CalcResult capTable(Inputs i) {
    final pre = i.n('preMoney');
    final investment = i.n('investment');
    final shares = i.n('existingShares');
    final post = pre + investment;
    return CalcResult([
      CalcOutput('postMoney', 'Post-money', post, ValueFormat.money),
      CalcOutput(
        'investorStake',
        'Investor stake',
        _div(investment, post),
        ValueFormat.percent,
      ),
      CalcOutput(
        'existingStake',
        'Existing holders',
        _div(pre, post),
        ValueFormat.percent,
      ),
      CalcOutput(
        'newShares',
        'New shares',
        _div(shares * investment, pre),
        ValueFormat.count,
      ),
      CalcOutput(
        'sharePrice',
        'Price per share',
        _div(pre, shares),
        ValueFormat.money,
      ),
    ]);
  }

  /// arr, growth % (year over year). Rough multiple range only.
  static CalcResult valuation(Inputs i) {
    final arr = i.n('arr');
    final growth = i.n('growth');
    final (low, high) = growth >= 100
        ? (6, 12)
        : growth >= 50
        ? (4, 8)
        : (3, 6);
    return CalcResult([
      CalcOutput('mid', 'Midpoint', arr * (low + high) / 2, ValueFormat.money),
      CalcOutput('low', 'Low', arr * low, ValueFormat.money),
      CalcOutput('high', 'High', arr * high, ValueFormat.money),
      CalcOutput(
        'multipleLow',
        'Multiple from',
        low.toDouble(),
        ValueFormat.ratio,
      ),
      CalcOutput(
        'multipleHigh',
        'Multiple to',
        high.toDouble(),
        ValueFormat.ratio,
      ),
    ], verdict: 'Rough estimate only, not a valuation');
  }

  /// Six criteria, each scored 1–5.
  static const ideaCriteria = [
    'problemPain',
    'marketSize',
    'willingnessToPay',
    'competition',
    'feasibility',
    'founderFit',
  ];

  static CalcResult ideaScore(Inputs i) {
    final total = ideaCriteria
        .map((k) => i.n(k).clamp(1, 5))
        .fold<double>(0, (a, b) => a + b);
    final verdict = total >= 24
        ? 'Strong'
        : total >= 17
        ? 'Promising'
        : 'Weak';
    return CalcResult([
      CalcOutput('total', 'Score (of 30)', total, ValueFormat.count),
      CalcOutput('ratio', 'Score', total / 30, ValueFormat.percent),
    ], verdict: verdict);
  }

  /// visitorsA, conversionsA, visitorsB, conversionsB.
  /// Two-proportion z-test, two-tailed.
  static CalcResult abTest(Inputs i) {
    final nA = i.n('visitorsA');
    final nB = i.n('visitorsB');
    final pA = _div(i.n('conversionsA'), nA);
    final pB = _div(i.n('conversionsB'), nB);
    final pooled = _div(i.n('conversionsA') + i.n('conversionsB'), nA + nB);
    final se = math.sqrt(pooled * (1 - pooled) * (_div(1, nA) + _div(1, nB)));
    final z = se > 0 && se.isFinite ? (pB - pA) / se : 0.0;
    final confidence = 2 * normalCdf(z.abs()) - 1;
    return CalcResult([
      CalcOutput('rateA', 'Conversion A', pA, ValueFormat.percent),
      CalcOutput('rateB', 'Conversion B', pB, ValueFormat.percent),
      CalcOutput('uplift', 'Uplift', _div(pB - pA, pA), ValueFormat.percent),
      CalcOutput('z', 'z-score', z, ValueFormat.number),
      CalcOutput('confidence', 'Confidence', confidence, ValueFormat.percent),
    ], verdict: confidence >= 0.95 ? 'Significant' : 'Not significant yet');
  }

  /// visitors, signups, active, paying.
  static CalcResult funnel(Inputs i) {
    final visitors = i.n('visitors');
    final signups = i.n('signups');
    final active = i.n('active');
    final paying = i.n('paying');
    return CalcResult([
      CalcOutput(
        'visitorToSignup',
        'Visitor → signup',
        _div(signups, visitors),
        ValueFormat.percent,
      ),
      CalcOutput(
        'signupToActive',
        'Signup → active',
        _div(active, signups),
        ValueFormat.percent,
      ),
      CalcOutput(
        'activeToPaying',
        'Active → paying',
        _div(paying, active),
        ValueFormat.percent,
      ),
      CalcOutput(
        'overall',
        'Overall',
        _div(paying, visitors),
        ValueFormat.percent,
      ),
    ]);
  }

  /// Standard normal CDF Φ(x).
  static double normalCdf(double x) => 0.5 * (1 + _erf(x / math.sqrt2));

  /// Abramowitz–Stegun 7.1.26, max error 1.5e-7.
  static double _erf(double x) {
    final sign = x < 0 ? -1 : 1;
    final ax = x.abs();
    final t = 1 / (1 + 0.3275911 * ax);
    final poly =
        t *
        (0.254829592 +
            t *
                (-0.284496736 +
                    t * (1.421413741 + t * (-1.453152027 + t * 1.061405429))));
    return sign * (1 - poly * math.exp(-ax * ax));
  }

  /// Division where x/0 is infinite for x > 0 and 0 for x == 0, never NaN.
  static double _div(double a, double b) {
    if (b != 0) return a / b;
    if (a == 0) return 0;
    return a > 0 ? double.infinity : double.negativeInfinity;
  }
}
