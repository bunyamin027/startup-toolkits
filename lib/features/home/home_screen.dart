import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../billing/entitlement.dart';
import '../../billing/entitlement_providers.dart';
import '../../core/theme/app_tokens.dart';
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
import '../tool/tool_screen.dart';

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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MISSION CONTROL',
                        style: text.labelSmall?.copyWith(letterSpacing: 1.4),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        name.isEmpty ? 'Your startup' : name,
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
                  ),
                ),
                const SizedBox(width: AppSpace.gapS),
                const PlanBadge(),
              ],
            ),
          ),
          const SizedBox(height: 18),
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
                      ? 'Start here'
                      : 'Start here · ${project.goal!.label}',
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
                  const SectionLabel('Recently used'),
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
              label: Text('Browse all ${allTools.length} tools'),
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
}

/// "Trial · 12 days left", "Free plan" or "Pro".
class PlanBadge extends ConsumerWidget {
  const PlanBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.tokens;
    final e = ref.watch(entitlementProvider);
    final now = ref.watch(clockProvider)();
    final (label, color) = switch (e.level(now)) {
      AccessLevel.trial => (
        'Trial · ${e.trialDaysLeft(now)} ${e.trialDaysLeft(now) == 1 ? 'day' : 'days'} left',
        t.accent,
      ),
      AccessLevel.free => ('Free plan', t.muted),
      AccessLevel.subscriber => ('Pro', t.accent),
    };
    return Container(
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
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      button: true,
      label: 'Search tools',
      excludeSemantics: true,
      child: Material(
        color: t.surface2,
        borderRadius: BorderRadius.circular(AppRadius.iconBox),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.iconBox),
          onTap: () =>
              Navigator.push(context, CatalogScreen.route(autofocus: true)),
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                const SizedBox(width: 14),
                Icon(Icons.search, color: t.muted),
                const SizedBox(width: 10),
                Text(
                  'Search ${allTools.length} tools',
                  style: TextStyle(color: t.muted, fontSize: 16),
                ),
              ],
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
                  'Launch path',
                  style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              Semantics(
                label:
                    'Launch path ${(progress * 100).round()} percent complete',
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
      label:
          '${step.name}: ${switch (state) {
            _StepState.done => 'done',
            _StepState.current => 'current step',
            _StepState.todo => 'not started',
          }}',
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
            step.name,
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

class _NextStepCard extends StatelessWidget {
  const _NextStepCard({required this.next});

  final NextStep? next;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final next = this.next;
    if (next == null) {
      return AppCard(
        child: Text(
          'Launch path complete. Keep your numbers and story fresh as you grow.',
          style: text.bodyMedium,
        ),
      );
    }
    final tool = toolById(next.toolId)!;
    final adds = next.missing.isEmpty
        ? 'Open it to finish the ${next.step.name} step'
        : 'Adds ${next.missing.map((f) => f.label.toLowerCase()).join(', ')}';
    return Material(
      color: t.surface1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: BorderSide(color: t.accent.withValues(alpha: 0.6), width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(context, ToolScreen.route(tool.id)),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NEXT BEST STEP',
                      style: text.labelSmall?.copyWith(
                        color: t.accent,
                        letterSpacing: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      next.step.action,
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
