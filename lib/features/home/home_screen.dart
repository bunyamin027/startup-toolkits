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
import '../../tools/tool_def.dart';
import '../../tools/tool_providers.dart';
import '../catalog/catalog_screen.dart';
import '../common/tool_tile.dart';
import '../paywall/paywall_screen.dart';
import '../tool/open_tool.dart';
import '../../l10n/l10n.dart';

/// "Mission control": one mission card (where the startup is and the next
/// step), then tools to pick from. Everything else is a tap away.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectProvider);
    final recent = ref.watch(recentToolsProvider);
    final used = recent.keys.toSet();
    final text = Theme.of(context).textTheme;
    final t = context.tokens;
    final l = context.l10n;
    final name = project[ProjectField.startupName].trim();
    final oneLiner = project[ProjectField.oneLiner].trim();
    final tools = context.tools;
    final recentTools = [
      for (final id in ref.read(recentToolsProvider.notifier).ordered.take(4))
        ?tools.byId(id),
    ];
    final picks = [for (final id in goalPicks[project.goal]!) ?tools.byId(id)];
    final free = ref.watch(
      entitlementProvider.select(
        (e) => e.level(ref.read(clockProvider)()) == AccessLevel.free,
      ),
    );

    var i = 0;
    Widget rise(Widget child) => RiseIn(index: i++, child: child);

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 32),
        children: [
          _Edge(
            child: rise(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // The badge takes the free width (it shortens only on
                  // very small screens) and never pushes the search away.
                  if (!largeText(context))
                    const Flexible(child: PlanBadge())
                  else
                    const SizedBox.shrink(),
                  const SizedBox(width: AppSpace.gapS),
                  _RoundButton(
                    icon: Icons.search_rounded,
                    label: l.homeSearchLabel,
                    onTap: () => Navigator.push(
                      context,
                      CatalogScreen.route(autofocus: true),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (largeText(context))
            const _Edge(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: PlanBadge(),
              ),
            ),
          const SizedBox(height: 10),
          _Edge(
            child: rise(
              Column(
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
                      style: text.bodyLarge?.copyWith(color: t.muted),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (free) ...[
            _Edge(child: rise(const _FreePlanBanner())),
            const SizedBox(height: AppSpace.gapL),
          ],
          _Edge(
            child: rise(_MissionCard(project: project, usedTools: used)),
          ),
          const SizedBox(height: 28),
          rise(
            _Section(
              title: project.goal == null
                  ? l.homeStartHere
                  : l.homeStartHereGoal(l.goal(project.goal!)),
              onSeeAll: () => Navigator.push(context, CatalogScreen.route()),
              child: _ToolCarousel(tools: picks),
            ),
          ),
          if (recentTools.isNotEmpty) ...[
            const SizedBox(height: 26),
            rise(
              _Section(
                title: l.homeRecentlyUsed,
                child: _Edge(child: _RecentChips(tools: recentTools)),
              ),
            ),
          ],
          const SizedBox(height: 26),
          _Edge(child: rise(const _ExploreCard())),
        ],
      ),
    );
  }
}

/// Standard side gutter for Home rows (the carousel runs edge to edge).
class _Edge extends StatelessWidget {
  const _Edge({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSpace.edge),
    child: child,
  );
}

/// Section title with an optional "See all" link.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child, this.onSeeAll});

  final String title;
  final Widget child;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Edge(
          child: Row(
            children: [
              Expanded(child: SectionLabel(title)),
              if (onSeeAll != null)
                TextButton(
                  onPressed: onSeeAll,
                  style: TextButton.styleFrom(
                    foregroundColor: t.accent,
                    minimumSize: const Size(
                      AppSpace.minTouch,
                      AppSpace.minTouch,
                    ),
                  ),
                  child: Text(context.l10n.homeSeeAll),
                ),
            ],
          ),
        ),
        child,
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return IconButton(
      onPressed: onTap,
      tooltip: label,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        fixedSize: const Size(44, 44),
        backgroundColor: t.surface2,
        foregroundColor: t.text,
        side: BorderSide(color: t.border),
      ),
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
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
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

/// The one thing to look at: which launch step the startup is on, what to
/// do next and the tool that does it, with a big Start button.
class _MissionCard extends ConsumerWidget {
  const _MissionCard({required this.project, required this.usedTools});

  final Project project;
  final Set<String> usedTools;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final l = context.l10n;
    final next = nextBestStep(project, usedTools);
    final current = currentStep(project, usedTools);
    final progress = launchProgress(project, usedTools);

    final Widget body;
    if (next == null) {
      body = Row(
        children: [
          Icon(Icons.verified_rounded, color: t.accent, size: 32),
          const SizedBox(width: AppSpace.gapM),
          Expanded(child: Text(l.homePathComplete, style: text.bodyLarge)),
        ],
      );
    } else {
      final tool = context.tools.byId(next.toolId)!;
      final adds = next.missing.isEmpty
          ? l.homeNextFinish(l.stepName(next.step))
          : l.homeNextAdds(
              next.missing
                  .map((f) => nounIn(l.field(f), tool.language))
                  .join(', '),
            );
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l.stepAction(next.step),
            style: text.headlineSmall?.copyWith(fontSize: 26, height: 1.15),
          ),
          const SizedBox(height: 6),
          Text(adds, style: text.bodyMedium?.copyWith(color: t.muted)),
          const SizedBox(height: 18),
          FilledButton(
            onPressed: () => openTool(context, ref, tool.id),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tool.icon, size: 20),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    '${l.homeStartStep} · ${tool.name}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.arrow_forward_rounded, size: 20),
              ],
            ),
          ),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.card),
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [
            Color.lerp(t.surface1, t.accent, 0.14)!,
            Color.lerp(t.surface1, t.blue, 0.10)!,
          ],
        ),
        border: Border.all(color: t.accent.withValues(alpha: 0.45)),
        boxShadow: [
          BoxShadow(color: t.accent.withValues(alpha: 0.12), blurRadius: 28),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  upperIn(
                    current == null
                        ? l.homeLaunchPath
                        : '${l.introStep(current + 1, launchPath.length)}'
                              ' · ${l.stepName(launchPath[current])}',
                    l.localeName,
                  ),
                  style: text.labelSmall?.copyWith(
                    color: t.accent,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Semantics(
                label: l.homeLaunchPathProgress((progress * 100).round()),
                excludeSemantics: true,
                child: CountUp(
                  value: progress * 100,
                  format: (v) => '${v.round()}%',
                  style: text.titleLarge?.copyWith(
                    color: t.accent,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _PathBar(current: current),
          const SizedBox(height: 20),
          body,
        ],
      ),
    );
  }
}

/// Five segments, one per launch step; the current one breathes.
class _PathBar extends StatelessWidget {
  const _PathBar({required this.current});

  /// Index of the current step; null when the path is complete.
  final int? current;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final names = !largeText(context);
    return ExcludeSemantics(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < launchPath.length; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _segment(t, current == null || i < current!, i == current),
                  if (names) ...[
                    const SizedBox(height: 6),
                    Text(
                      context.l10n.stepName(launchPath[i]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: i == current
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: i == current
                            ? t.text
                            : (current == null || i < current!)
                            ? t.muted
                            : t.muted.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _segment(AppTokens t, bool done, bool now) {
    final bar = Container(
      height: 6,
      decoration: BoxDecoration(
        color: done || now ? t.accent : t.border,
        borderRadius: BorderRadius.circular(3),
      ),
    );
    if (!now) return bar;
    return _Breathing(child: bar);
  }
}

/// Fades the current segment in and out (static with Reduce Motion).
class _Breathing extends StatefulWidget {
  const _Breathing({required this.child});

  final Widget child;

  @override
  State<_Breathing> createState() => _BreathingState();
}

class _BreathingState extends State<_Breathing>
    with SingleTickerProviderStateMixin {
  late final _c = AnimationController(vsync: this, duration: AppMotion.pulse);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (AppMotion.reduced(context)) {
      _c.value = 1;
      _c.stop();
    } else if (!_c.isAnimating) {
      _c.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: Tween(begin: 0.45, end: 1.0).animate(_c),
    child: widget.child,
  );
}

/// Tools as big cards in a horizontal row; a plain list at large text,
/// where fixed-height cards would cut words off.
class _ToolCarousel extends StatelessWidget {
  const _ToolCarousel({required this.tools});

  final List<ToolDef> tools;

  @override
  Widget build(BuildContext context) {
    if (largeText(context)) {
      return _Edge(child: ToolTileList(tools: tools));
    }
    return SizedBox(
      height: 196,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.edge),
        itemCount: tools.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpace.gapM),
        itemBuilder: (context, i) => _ToolCard(tool: tools[i]),
      ),
    );
  }
}

class _ToolCard extends ConsumerWidget {
  const _ToolCard({required this.tool});

  final ToolDef tool;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final locked = isToolLocked(ref, tool.id);
    // Wide enough for two-line names such as "Yatırımcı sunumu sihirbazı".
    return SizedBox(
      width: 184,
      child: Material(
        color: t.surface1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: BorderSide(color: t.border),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => openTool(context, ref, tool.id),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconBox(tool.icon, size: 46),
                    const Spacer(),
                    if (locked)
                      Icon(
                        Icons.lock_outline,
                        size: 18,
                        color: t.muted,
                        semanticLabel: context.l10n.toolLocked,
                      ),
                  ],
                ),
                const Spacer(),
                Text(
                  tool.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tool.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Recently used tools as compact chips.
class _RecentChips extends ConsumerWidget {
  const _RecentChips({required this.tools});

  final List<ToolDef> tools;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    return Wrap(
      spacing: AppSpace.gapS,
      runSpacing: AppSpace.gapS,
      children: [
        for (final tool in tools)
          ActionChip(
            avatar: Icon(tool.icon, size: 18, color: t.accent),
            label: Text(tool.name),
            onPressed: () => openTool(context, ref, tool.id),
          ),
      ],
    );
  }
}

/// Entry to the full catalog.
class _ExploreCard extends StatelessWidget {
  const _ExploreCard();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    return Material(
      color: t.surface2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(context, CatalogScreen.route()),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.apps_rounded, color: t.accent),
              const SizedBox(width: AppSpace.gapM),
              Expanded(
                child: Text(
                  context.l10n.homeBrowseAll(allTools.length),
                  style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Icon(Icons.chevron_right, color: t.muted),
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
