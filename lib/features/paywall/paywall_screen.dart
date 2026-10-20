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
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: _FloatingIcons()),
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        tooltip: context.l10n.commonClose,
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpace.edge,
                          40,
                          AppSpace.edge,
                          16,
                        ),
                        children: [
                          Text(
                            context.l10n.paywallTitle,
                            style: text.displaySmall,
                          ),
                          const SizedBox(height: 18),
                          _Benefit(
                            context.l10n.paywallBenefitAll(allTools.length),
                          ),
                          _Benefit(context.l10n.paywallBenefitAutofill),
                          _Benefit(context.l10n.paywallBenefitPrivate),
                          const SizedBox(height: 24),
                          if (loading)
                            const Center(child: CircularProgressIndicator())
                          else if (offers.isEmpty)
                            AppCard(
                              child: Text(
                                context.l10n.paywallUnavailable,
                                style: text.bodyMedium,
                              ),
                            )
                          else
                            for (final o in offers) ...[
                              _PlanCard(
                                offer: o,
                                selected: o == selected,
                                savings: o.period == PlanPeriod.yearly
                                    ? yearlySavings(offers)
                                    : null,
                                onTap: () {
                                  setState(() => _period = o.period);
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
}

class _Benefit extends StatelessWidget {
  const _Benefit(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle_rounded, color: t.accent, size: 22),
          const SizedBox(width: 10),
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
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final yearly = offer.period == PlanPeriod.yearly;
    return Semantics(
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
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // The billed amount is the most prominent price.
                    Text(
                      perPeriod(context.l10n, offer),
                      style: text.titleLarge?.copyWith(fontSize: 17),
                    ),
                    if (offer.monthlyEquivalent != null)
                      Text(
                        context.l10n.paywallPerMonth(offer.monthlyEquivalent!),
                        style: text.bodySmall,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
        padding: const EdgeInsets.fromLTRB(AppSpace.edge, 12, AppSpace.edge, 4),
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

/// Tool icons drifting slowly behind the headline (§7.3: 5–9 s loops).
/// Still when motion is reduced.
class _FloatingIcons extends StatefulWidget {
  const _FloatingIcons();

  @override
  State<_FloatingIcons> createState() => _FloatingIconsState();
}

class _FloatingIconsState extends State<_FloatingIcons>
    with SingleTickerProviderStateMixin {
  // One slow master clock; each icon uses its own period inside it.
  late final AnimationController _clock = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 63),
  );

  // Between the status bar and the headline, right of the close button,
  // so neither text nor controls are covered.
  static const _spots = [
    (0.22, 0.062, 5.0),
    (0.40, 0.085, 7.0),
    (0.57, 0.058, 9.0),
    (0.73, 0.082, 6.0),
    (0.88, 0.06, 7.5),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (AppMotion.reduced(context)) {
      _clock.stop();
    } else if (!_clock.isAnimating) {
      _clock.repeat();
    }
  }

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final icons = [
      for (final id in ['runway', 'pitchDeck', 'crm', 'nda', 'storeListing'])
        toolById(id)!.icon,
    ];
    return ExcludeSemantics(
      child: LayoutBuilder(
        builder: (context, box) => AnimatedBuilder(
          animation: _clock,
          builder: (context, _) {
            final seconds = _clock.value * 63;
            return Stack(
              children: [
                Positioned(
                  left: -60,
                  top: -40,
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          t.blue.withValues(alpha: 0.28),
                          t.blue.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ),
                for (final (i, (x, y, period)) in _spots.indexed)
                  Positioned(
                    left: box.maxWidth * x,
                    top:
                        box.maxHeight * y +
                        6 * math.sin(2 * math.pi * seconds / period + i),
                    child: Opacity(
                      opacity: 0.55,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: t.surface2,
                          borderRadius: BorderRadius.circular(
                            AppRadius.iconBox,
                          ),
                          border: Border.all(color: t.border),
                        ),
                        child: Icon(icons[i], color: t.accent, size: 22),
                      ),
                    ),
                  ),
              ],
            );
          },
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
