import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../billing/entitlement.dart';
import '../../billing/entitlement_providers.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/widgets/motion.dart';
import '../../tools/catalog/catalog.dart';
import 'paywall_screen.dart';

/// Bottom sheet shown on the free plan when a second tool is opened in a
/// day: countdown to midnight, then "Go unlimited" or "Come back tomorrow".
Future<void> showFreeLimitSheet(BuildContext context, {String? todaysToolId}) {
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    // Sizes to content instead of the default 9/16 height cap, which large
    // text sizes overflow.
    isScrollControlled: true,
    backgroundColor: context.tokens.surface1,
    // Spring-like rise (§7.3: 700 ms).
    sheetAnimationStyle: AppMotion.reduced(context)
        ? AnimationStyle.noAnimation
        : const AnimationStyle(
            duration: AppMotion.sheet,
            curve: Curves.easeOutBack,
          ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.card)),
    ),
    builder: (_) => FreeLimitSheet(todaysToolId: todaysToolId),
  );
}

class FreeLimitSheet extends ConsumerStatefulWidget {
  const FreeLimitSheet({super.key, this.todaysToolId});

  final String? todaysToolId;

  @override
  ConsumerState<FreeLimitSheet> createState() => _FreeLimitSheetState();
}

class _FreeLimitSheetState extends ConsumerState<FreeLimitSheet> {
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    // Countdown shows minutes; refresh twice a minute.
    _tick = Timer.periodic(const Duration(seconds: 30), (_) => setState(() {}));
  }

  @override
  void dispose() {
    _tick?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final now = ref.watch(clockProvider)();
    final left = Entitlement.nextReset(now).difference(now);
    final hours = left.inHours;
    final minutes = left.inMinutes % 60;
    final today = widget.todaysToolId == null
        ? null
        : toolById(widget.todaysToolId!);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(AppSpace.edge, 24, AppSpace.edge, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: RingGauge(
              progress: left.inSeconds / Duration.secondsPerDay,
              size: 132,
              stroke: 10,
              child: Semantics(
                label:
                    '$hours hours $minutes minutes until your next free tool',
                excludeSemantics: true,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('${hours}h ${minutes}m', style: text.titleLarge),
                    Text('to reset', style: text.bodySmall),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "You've used today's free tool",
            textAlign: TextAlign.center,
            style: text.headlineSmall?.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 8),
          Text(
            today == null
                ? 'The free plan opens one tool a day. Your project stays free.'
                : '${today.name} stays open all day. The free plan opens one tool a day; '
                      'your project stays free.',
            textAlign: TextAlign.center,
            style: text.bodySmall,
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: () {
              final navigator = Navigator.of(context)..pop();
              unawaited(navigator.push(PaywallScreen.route()));
            },
            child: const Text('Go unlimited'),
          ),
          const SizedBox(height: AppSpace.gapS),
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              minimumSize: const Size.fromHeight(AppSpace.minTouch),
              foregroundColor: t.muted,
            ),
            child: const Text('Come back tomorrow'),
          ),
        ],
      ),
    );
  }
}
