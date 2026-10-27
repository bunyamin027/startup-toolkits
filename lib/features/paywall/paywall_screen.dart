import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../billing/billing_config.dart';
import '../../billing/billing_service.dart';
import '../../billing/entitlement_providers.dart';
import '../../core/analytics.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/theme/text_scale.dart';
import '../../core/widgets/app_card.dart';
import '../../tools/catalog/catalog.dart';
import '../../tools/tool_def.dart';
import '../tool/tool_actions.dart';
import '../../l10n/l10n.dart';

/// Subscription screen. Follows App Review 3.1.2: the billed amount and
/// period are the most prominent price, trial terms and auto-renewal are
/// stated next to the button, and Restore, Terms and Privacy are present.
class PaywallScreen extends ConsumerStatefulWidget {
  const PaywallScreen({super.key});

  static Route<void> route() => MaterialPageRoute(
    fullscreenDialog: true,
    builder: (_) => const PaywallScreen(),
  );

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  late final Future<List<PlanOffer>> _offers;
  PlanPeriod _period = PlanPeriod.yearly;
  bool _busy = false;

  BillingService get _billing => ref.read(billingServiceProvider);
  Analytics get _analytics => ref.read(analyticsProvider);

  @override
  void initState() {
    super.initState();
    _offers = _billing.offers();
    _analytics.log(AnalyticsEvent.paywallViewed);
  }

  Future<void> _buy(PlanOffer offer) async {
    setState(() => _busy = true);
    final outcome = await _billing.purchase(offer);
    if (!mounted) return;
    setState(() => _busy = false);
    switch (outcome) {
      case PurchaseOutcome.success:
        ref.read(entitlementProvider.notifier).setSubscribed(true);
        final params = {'plan': offer.period.name};
        _analytics.log(
          offer.freeTrialDays != null
              ? AnalyticsEvent.trialStarted
              : AnalyticsEvent.subscribed,
          params,
        );
        Navigator.pop(context);
        showMessage(context, context.l10n.paywallSuccess);
      case PurchaseOutcome.cancelled:
        break;
      case PurchaseOutcome.failed:
        showMessage(context, context.l10n.paywallFailed);
    }
  }

  Future<void> _restore() async {
    setState(() => _busy = true);
    final found = await _billing.restore();
    if (!mounted) return;
    setState(() => _busy = false);
    if (found) {
      ref.read(entitlementProvider.notifier).setSubscribed(true);
      Navigator.pop(context);
      showMessage(context, context.l10n.restoreSuccess);
    } else {
      showMessage(context, context.l10n.restoreNothing);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: _Glow()),
          SafeArea(
            child: FutureBuilder<List<PlanOffer>>(
              future: _offers,
              builder: (context, snapshot) {
                final offers = snapshot.data ?? const [];
                final loading =
                    snapshot.connectionState != ConnectionState.done;
                final selected =
                    offers.where((o) => o.period == _period).firstOrNull ??
                    offers.firstOrNull;
                // At large text sizes the button and terms scroll with the
                // page; a sticky footer would leave no room for the plans.
                final scrollFooter = largeText(context);
                final footer = _Footer(
                  offer: selected,
                  busy: _busy,
                  onBuy: selected == null ? null : () => _buy(selected),
                  onRestore: _billing.available ? _restore : null,
                );
                return Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          tooltip: context.l10n.commonClose,
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                        const Spacer(),
                        const _ProBadge(),
                        const SizedBox(width: AppSpace.edge),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.only(top: 8, bottom: 16),
                        children: [
                          const _ToolMarquee(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpace.edge,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(height: 26),
                                // Plans come first so they show above the
                                // button without scrolling.
                                ..._plans(context, loading, offers, selected),
                                const SizedBox(height: 14),
                                _Benefit(
                                  Icons.all_inclusive_rounded,
                                  t.accent,
                                  context.l10n.paywallBenefitAll(
                                    allTools.length,
                                  ),
                                ),
                                _Benefit(
                                  Icons.auto_awesome_rounded,
                                  t.blue,
                                  context.l10n.paywallBenefitAutofill,
                                ),
                                _Benefit(
                                  Icons.lock_rounded,
                                  t.muted,
                                  context.l10n.paywallBenefitPrivate,
                                ),
                              ],
                            ),
                          ),
                          if (scrollFooter) footer,
                        ],
                      ),
                    ),
                    if (!scrollFooter) footer,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _plans(
    BuildContext context,
    bool loading,
    List<PlanOffer> offers,
    PlanOffer? selected,
  ) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    return [
      if (loading)
        const Center(child: CircularProgressIndicator())
      else if (offers.isEmpty)
        AppCard(
          child: Text(context.l10n.paywallUnavailable, style: text.bodyMedium),
        )
      else
        for (final o in offers) ...[
          _PlanCard(
            offer: o,
            selected: o == selected,
            savings: o.period == PlanPeriod.yearly
                ? yearlySavings(offers)
                : null,
            // Tapping a plan selects it and goes straight to the store's
            // payment sheet.
            onTap: _busy
                ? null
                : () {
                    setState(() => _period = o.period);
                    unawaited(_buy(o));
                    _analytics.log(AnalyticsEvent.planSelected, {
                      'plan': o.period.name,
                    });
                  },
          ),
          const SizedBox(height: AppSpace.gapM),
        ],
      if (_billing.isPreview)
        Text(
          context.l10n.paywallPreview,
          textAlign: TextAlign.center,
          style: text.bodySmall?.copyWith(color: t.blue),
        ),
    ];
  }
}

/// Soft color behind the top of the page.
class _Glow extends StatelessWidget {
  const _Glow();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [t.blue.withValues(alpha: 0.22), t.bg.withValues(alpha: 0)],
        ),
      ),
    );
  }
}

class _ProBadge extends StatelessWidget {
  const _ProBadge();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return ExcludeSemantics(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [t.accent, t.blue]),
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
        child: Text(
          'PRO',
          style: TextStyle(
            color: t.onAccent,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

class _Benefit extends StatelessWidget {
  const _Benefit(this.icon, this.color, this.text);

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: t.surface2,
              borderRadius: BorderRadius.circular(AppRadius.iconBox - 4),
              border: Border.all(color: t.border),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.offer,
    required this.selected,
    required this.savings,
    required this.onTap,
  });

  final PlanOffer offer;
  final bool selected;
  final double? savings;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final yearly = offer.period == PlanPeriod.yearly;
    // At large text sizes the prices go under the plan name.
    final stacked = largeText(context);
    final prices = Column(
      crossAxisAlignment: stacked
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        // The billed amount is the most prominent price.
        Text(
          perPeriod(context.l10n, offer),
          style: text.titleLarge?.copyWith(fontSize: 17),
        ),
        if (offer.monthlyEquivalentIn(context.fmt) case final monthly?)
          Text(context.l10n.paywallPerMonth(monthly), style: text.bodySmall),
      ],
    );
    final card = Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: selected ? t.surface2 : t.surface1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: BorderSide(
            color: selected ? t.accent : t.border,
            width: selected ? 2 : 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: selected ? t.accent : t.muted,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Wraps so the savings badge drops below on narrow
                      // screens instead of overflowing.
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            yearly
                                ? context.l10n.paywallYearly
                                : context.l10n.paywallMonthly,
                            style: text.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (savings != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: t.accent,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.chip,
                                ),
                              ),
                              child: Text(
                                context.l10n.paywallSave(
                                  (savings! * 100).round(),
                                ),
                                style: TextStyle(
                                  color: t.onAccent,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (offer.freeTrialDays != null)
                        Text(
                          context.l10n.paywallDaysFree(offer.freeTrialDays!),
                          style: text.bodySmall,
                        ),
                      if (stacked) ...[const SizedBox(height: 6), prices],
                    ],
                  ),
                ),
                if (!stacked) prices,
              ],
            ),
          ),
        ),
      ),
    );
    if (!yearly) return card;
    // The ribbon sits on the card's top edge.
    return Padding(
      padding: const EdgeInsets.only(top: 11),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          card,
          PositionedDirectional(
            top: -11,
            end: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [t.accent, t.blue]),
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: Text(
                context.l10n.paywallBestValue,
                style: TextStyle(
                  color: t.onAccent,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.offer,
    required this.busy,
    required this.onBuy,
    required this.onRestore,
  });

  final PlanOffer? offer;
  final bool busy;
  final VoidCallback? onBuy;
  final VoidCallback? onRestore;
  String _cta(AppLocalizations l) {
    final o = offer;
    if (o == null) return l.paywallSubscribe;
    return o.freeTrialDays != null
        ? l.paywallStartTrial(o.freeTrialDays!)
        : l.paywallSubscribeFor(perPeriod(l, o));
  }

  String _terms(AppLocalizations l) {
    final o = offer;
    if (o == null) return '';
    final yearly = o.period == PlanPeriod.yearly;
    final store = defaultTargetPlatform == TargetPlatform.android
        ? 'Google Play'
        : 'App Store';
    final days = o.freeTrialDays;
    final start = switch ((days, yearly)) {
      (final d?, true) => l.paywallTermsTrialYearly(d, o.priceString),
      (final d?, false) => l.paywallTermsTrialMonthly(d, o.priceString),
      (null, true) => l.paywallTermsYearly(o.priceString),
      (null, false) => l.paywallTermsMonthly(o.priceString),
    };
    return '$start ${l.paywallTermsRenewal(store)}';
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final small = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(fontSize: 11.5);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: t.bg,
        border: Border(top: BorderSide(color: t.border)),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpace.edge,
          12,
          AppSpace.edge,
          4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: busy ? null : onBuy,
              child: busy
                  ? SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: t.onAccent,
                      ),
                    )
                  : Text(_cta(context.l10n)),
            ),
            if (_terms(context.l10n).isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                _terms(context.l10n),
                textAlign: TextAlign.center,
                style: small,
              ),
            ],
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                _Link(context.l10n.paywallRestore, onRestore),
                _Link(
                  context.l10n.termsOfUse,
                  _url(context, BillingConfig.termsUrl),
                ),
                _Link(
                  context.l10n.privacyPolicy,
                  _url(context, BillingConfig.privacyUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Opens a legal page. Missing URLs (not configured yet) say so instead
  /// of failing silently.
  static VoidCallback _url(BuildContext context, String url) => () {
    if (url.isEmpty) {
      showMessage(context, context.l10n.commonLinkMissing);
      return;
    }
    unawaited(launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView));
  };
}

class _Link extends StatelessWidget {
  const _Link(this.label, this.onTap);

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: context.tokens.muted,
        minimumSize: const Size(0, AppSpace.minTouch),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        textStyle: const TextStyle(
          fontSize: 12.5,
          decoration: TextDecoration.underline,
        ),
      ),
      child: Text(label),
    );
  }
}

/// Two rows of tool chips gliding in opposite directions: everything the
/// subscription unlocks, at a glance. Still when motion is reduced.
class _ToolMarquee extends StatefulWidget {
  const _ToolMarquee();

  @override
  State<_ToolMarquee> createState() => _ToolMarqueeState();
}

class _ToolMarqueeState extends State<_ToolMarquee>
    with SingleTickerProviderStateMixin {
  static const _speed = 22.0; // logical pixels per second
  static const _rowHeight = 38.0;

  // The second row starts far in and moves back, so both rows stay filled
  // for the ~15 minutes anyone could keep the page open.
  final _rows = [
    ScrollController(),
    ScrollController(initialScrollOffset: 20000),
  ];
  late final _ticker = createTicker(_tick);
  Duration _last = Duration.zero;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (AppMotion.reduced(context)) {
      if (_ticker.isActive) _ticker.stop();
    } else if (!_ticker.isActive) {
      _last = Duration.zero;
      unawaited(_ticker.start());
    }
  }

  void _tick(Duration elapsed) {
    final dt = (elapsed - _last).inMicroseconds / 1e6;
    _last = elapsed;
    for (final (i, row) in _rows.indexed) {
      if (!row.hasClients) continue;
      final next = row.offset + (i == 0 ? _speed : -_speed) * dt;
      row.jumpTo(math.max(0, next));
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    for (final row in _rows) {
      row.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tools = context.tools.tools;
    final half = tools.length ~/ 2;
    final rows = [tools.sublist(0, half), tools.sublist(half)];
    final bg = context.tokens.bg;
    return ExcludeSemantics(
      child: ShaderMask(
        // Fades the chips out at both edges.
        shaderCallback: (rect) => LinearGradient(
          colors: [bg.withValues(alpha: 0), bg, bg, bg.withValues(alpha: 0)],
          stops: const [0, 0.08, 0.92, 1],
        ).createShader(rect),
        blendMode: BlendMode.dstIn,
        child: Column(
          children: [
            for (final (i, row) in rows.indexed) ...[
              if (i > 0) const SizedBox(height: 8),
              SizedBox(
                height: MediaQuery.textScalerOf(context).scale(_rowHeight),
                child: ListView.builder(
                  controller: _rows[i],
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, n) =>
                      _ToolChip(row[n % row.length], accent: (n + i).isEven),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ToolChip extends StatelessWidget {
  const _ToolChip(this.tool, {required this.accent});

  final ToolDef tool;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(6, 4, 12, 4),
        decoration: BoxDecoration(
          color: t.surface1,
          borderRadius: BorderRadius.circular(AppRadius.chip + 6),
          border: Border.all(color: t.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: t.surface2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                tool.icon,
                size: 15,
                color: accent ? t.accent : t.blue,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              tool.name,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Billed amount with its period, the most prominent price (3.1.2).
String perPeriod(AppLocalizations l, PlanOffer o) =>
    o.period == PlanPeriod.yearly
    ? l.paywallPerYear(o.priceString)
    : l.paywallPerMonth(o.priceString);
