import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../billing/entitlement.dart';
import '../../billing/entitlement_providers.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/theme/text_scale.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/motion.dart';
import '../../project/launch_path.dart';
import '../../project/project.dart';
import '../../project/project_providers.dart';
import '../../tools/catalog/catalog.dart';
import '../../tools/catalog/goal_picks.dart';
import '../../tools/tool_providers.dart';
import '../catalog/catalog_screen.dart';
import '../common/tool_tile.dart';
import '../paywall/paywall_screen.dart';
import '../tool/open_tool.dart';
import '../../l10n/l10n.dart';

/// "Mission control": where the user is on the launch path and what to do
/// next.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final recent = ref.watch(recentToolsProvider);
    final used = recent.keys.toSet();
    final text = Theme.of(context).textTheme;
    final name = project[ProjectField.startupName].trim();
    final oneLiner = project[ProjectField.oneLiner].trim();
    final recentIds = ref.read(recentToolsProvider.notifier).ordered.take(3);
    final picks = goalPicks[project.goal]!.map((id) => toolById(id)!).toList();

    var i = 0;
    Widget rise(Widget child) => RiseIn(index: i++, child: child);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpace.edge,
          12,
          AppSpace.edge,
          32,
        ),
        children: [
          rise(
            // Large Dynamic Type stacks the badge under the title so
            // neither gets squeezed.
            largeText(context)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(context.l10n, text, name, oneLiner),
                      const SizedBox(height: AppSpace.gapS),
                      const PlanBadge(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _header(context.l10n, text, name, oneLiner),
                      ),
                      const SizedBox(width: AppSpace.gapS),
                      const PlanBadge(),
                    ],
                  ),
          ),
          const SizedBox(height: 18),
          if (ref.watch(
            entitlementProvider.select(
              (e) => e.level(ref.read(clockProvider)()) == AccessLevel.free,
            ),
          )) ...[
            rise(const _FreePlanBanner()),
            const SizedBox(height: AppSpace.gapL),
          ],
          rise(const _SearchField()),
          const SizedBox(height: 18),
          rise(LaunchPathCard(project: project, usedTools: used)),
          const SizedBox(height: AppSpace.gapL),
          rise(_NextStepCard(next: nextBestStep(project, used))),
          const SizedBox(height: 26),
          rise(
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SectionLabel(
                  project.goal == null
                      ? context.l10n.homeStartHere
                      : context.l10n.homeStartHereGoal(
                          context.l10n.goal(project.goal!),
                        ),
                ),
                ToolTileList(tools: picks),
              ],
            ),
          ),
          if (recentIds.isNotEmpty) ...[
            const SizedBox(height: 26),
            rise(
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionLabel(context.l10n.homeRecentlyUsed),
                  ToolTileList(
                    tools: [for (final id in recentIds) ?toolById(id)],
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 18),
          rise(
            OutlinedButton.icon(
              onPressed: () => Navigator.push(context, CatalogScreen.route()),
              icon: const Icon(Icons.apps),
              label: Text(context.l10n.homeBrowseAll(allTools.length)),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.button),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(
    AppLocalizations l,
    TextTheme text,
    String name,
    String oneLiner,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.homeMissionControl,
          style: text.labelSmall?.copyWith(letterSpacing: 1.4),
        ),
        const SizedBox(height: 4),
        Text(
          name.isEmpty ? l.homeYourStartup : name,
          style: text.displaySmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        if (oneLiner.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            oneLiner,
            style: text.bodySmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}

/// "Trial · 12 days left", "Free plan" or "Pro".
class PlanBadge extends ConsumerWidget {
  const PlanBadge({super.key, this.tappable = true});

  /// Opens the paywall on tap (except for subscribers).
  final bool tappable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final e = ref.watch(entitlementProvider);
    final now = ref.watch(clockProvider)();
    final (label, color) = switch (e.level(now)) {
      AccessLevel.trial => (
        context.l10n.planTrialBadge(e.trialDaysLeft(now)),
        t.accent,
      ),
      AccessLevel.free => (context.l10n.planFree, t.muted),
      AccessLevel.subscriber => (context.l10n.planPro, t.accent),
    };
    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: t.surface2,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: t.border),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    if (!tappable || e.level(now) == AccessLevel.subscriber) return badge;
    return Semantics(
      button: true,
      hint: context.l10n.commonSeePlans,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.chip),
        onTap: () => Navigator.push(context, PaywallScreen.route()),
        child: badge,
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      button: true,
      label: context.l10n.homeSearchLabel,
      excludeSemantics: true,
      child: Material(
        color: t.surface2,
        borderRadius: BorderRadius.circular(AppRadius.iconBox),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.iconBox),
          onTap: () =>
              Navigator.push(context, CatalogScreen.route(autofocus: true)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.search, color: t.muted),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      context.l10n.homeSearch(allTools.length),
                      style: TextStyle(color: t.muted, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Five connected steps with the current one pulsing, plus overall percent.
class LaunchPathCard extends StatelessWidget {
  const LaunchPathCard({
    super.key,
    required this.project,
    required this.usedTools,
  });

  final Project project;
  final Set<String> usedTools;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final current = currentStep(project, usedTools);
    final progress = launchProgress(project, usedTools);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.homeLaunchPath,
                  style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Semantics(
                label: context.l10n.homeLaunchPathProgress(
                  (progress * 100).round(),
                ),
                excludeSemantics: true,
                child: CountUp(
                  value: progress * 100,
                  format: (v) => '${v.round()}%',
                  style: text.titleLarge?.copyWith(
                    color: t.accent,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              for (var i = 0; i < launchPath.length; i++)
                Expanded(
                  child: _StepNode(
                    step: launchPath[i],
                    state: current == null || i < current
                        ? _StepState.done
                        : i == current
                        ? _StepState.current
                        : _StepState.todo,
                    first: i == 0,
                    last: i == launchPath.length - 1,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

enum _StepState { done, current, todo }

class _StepNode extends StatelessWidget {
  const _StepNode({
    required this.step,
    required this.state,
    required this.first,
    required this.last,
  });

  final LaunchStep step;
  final _StepState state;
  final bool first;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    const size = 28.0;
    final dot = switch (state) {
      _StepState.done => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: t.accent, shape: BoxShape.circle),
        child: Icon(Icons.check_rounded, size: 18, color: t.onAccent),
      ),
      _StepState.current => Pulse(
        scale: 0.18,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: t.bg,
            shape: BoxShape.circle,
            border: Border.all(color: t.accent, width: 3),
            boxShadow: [
              BoxShadow(
                color: t.accent.withValues(alpha: 0.35),
                blurRadius: 12,
              ),
            ],
          ),
        ),
      ),
      _StepState.todo => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: t.surface2,
          shape: BoxShape.circle,
          border: Border.all(color: t.border),
        ),
      ),
    };
    Widget line(bool visible, bool lit) => Expanded(
      child: Container(
        height: 3,
        color: visible ? (lit ? t.accent : t.surface2) : Colors.transparent,
      ),
    );
    return Semantics(
      label: switch (state) {
        _StepState.done => context.l10n.homeStepDone(
          context.l10n.stepName(step),
        ),
        _StepState.current => context.l10n.homeStepCurrent(
          context.l10n.stepName(step),
        ),
        _StepState.todo => context.l10n.homeStepTodo(
          context.l10n.stepName(step),
        ),
      },
      excludeSemantics: true,
      child: Column(
        children: [
          SizedBox(
            height: size + 8,
            child: Row(
              children: [
                line(!first, state != _StepState.todo),
                dot,
                line(!last, state == _StepState.done),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            context.l10n.stepName(step),
            style: TextStyle(
              fontSize: 12,
              fontWeight: state == _StepState.current
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: state == _StepState.todo ? t.muted : t.text,
            ),
          ),
        ],
      ),
    );
  }
}

class _NextStepCard extends ConsumerWidget {
  const _NextStepCard({required this.next});

  final NextStep? next;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final next = this.next;
    if (next == null) {
      return AppCard(
        child: Text(context.l10n.homePathComplete, style: text.bodyMedium),
      );
    }
    final tool = toolById(next.toolId)!;
    final adds = next.missing.isEmpty
        ? context.l10n.homeNextFinish(context.l10n.stepName(next.step))
        : context.l10n.homeNextAdds(
            next.missing
                .map((f) => context.l10n.field(f).toLowerCase())
                .join(', '),
          );
    return Material(
      color: t.surface1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: BorderSide(color: t.accent.withValues(alpha: 0.6), width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openTool(context, ref, tool.id),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.homeNextBestStep,
                      style: text.labelSmall?.copyWith(
                        color: t.accent,
                        letterSpacing: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      context.l10n.stepAction(next.step),
                      style: text.headlineSmall?.copyWith(fontSize: 22),
                    ),
                    const SizedBox(height: 4),
                    Text('${tool.name} · $adds', style: text.bodySmall),
                  ],
                ),
              ),
              const SizedBox(width: AppSpace.gapM),
              Pulse(
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: t.accent,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_forward_rounded, color: t.onAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shown once the trial is over: explains the free plan and offers Pro.
class _FreePlanBanner extends StatelessWidget {
  const _FreePlanBanner();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    return AppCard(
      color: t.surface2,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.homeTrialEnded,
                  style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(context.l10n.homeTrialEndedBody, style: text.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: AppSpace.gapM),
          FilledButton(
            onPressed: () => Navigator.push(context, PaywallScreen.route()),
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, AppSpace.minTouch),
            ),
            child: Text(context.l10n.commonSeePlans),
          ),
        ],
      ),
    );
  }
}
