import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/theme/text_scale.dart';
import '../../core/widgets/motion.dart';
import '../../l10n/l10n.dart';
import '../../project/launch_path.dart';
import '../../project/project.dart';
import '../../tools/catalog/goal_picks.dart';
import '../../tools/tool_def.dart';
import '../home/home_screen.dart';
import '../project/project_sheets.dart';

// The steps after the intro slides. They carry the intro's look (glows,
// real tool icons, things that react) into the questions, so onboarding
// stays one story instead of turning into a form.

Duration _d(BuildContext context, int ms) =>
    AppMotion.reduced(context) ? Duration.zero : Duration(milliseconds: ms);

/// Thin segmented bar: where the user is in the two questions.
class OnboardingProgress extends StatelessWidget {
  const OnboardingProgress({super.key, required this.step, this.total = 2});

  /// 1-based.
  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      label: context.l10n.introStep(step, total),
      child: Row(
        children: [
          for (var i = 1; i <= total; i++) ...[
            if (i > 1) const SizedBox(width: 6),
            Expanded(
              child: AnimatedContainer(
                duration: _d(context, 350),
                height: 4,
                decoration: BoxDecoration(
                  color: i <= step ? t.accent : t.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The four goals as big tiles (2×2, one column at large text). Picking
/// one reveals the tools it puts first, so the choice shows its payoff.
class GoalPicker extends StatelessWidget {
  const GoalPicker({super.key, required this.selected, required this.onPick});

  final Goal? selected;
  final ValueChanged<Goal> onPick;

  @override
  Widget build(BuildContext context) {
    final tiles = [
      for (final (i, g) in Goal.values.indexed)
        RiseIn(
          index: i + 2,
          child: _GoalTile(
            goal: g,
            selected: selected == g,
            onTap: () {
              unawaited(HapticFeedback.selectionClick());
              onPick(g);
            },
          ),
        ),
    ];
    final grid = largeText(context)
        ? Column(
            children: [
              for (final (i, tile) in tiles.indexed) ...[
                if (i > 0) const SizedBox(height: AppSpace.gapM),
                tile,
              ],
            ],
          )
        : Column(
            children: [
              for (var row = 0; row < 2; row++) ...[
                if (row > 0) const SizedBox(height: AppSpace.gapM),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: tiles[row * 2]),
                      const SizedBox(width: AppSpace.gapM),
                      Expanded(child: tiles[row * 2 + 1]),
                    ],
                  ),
                ),
              ],
            ],
          );
    final tools = selected == null
        ? const SizedBox(width: double.infinity)
        : _GoalTools(key: ValueKey(selected), goal: selected!);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        grid,
        // AnimatedSize with a zero duration trips a layout assertion, so
        // Reduce Motion just swaps the content.
        if (AppMotion.reduced(context))
          tools
        else
          AnimatedSize(
            duration: const Duration(milliseconds: 380),
            curve: Curves.easeOutCubic,
            alignment: AlignmentDirectional.topStart,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: tools,
            ),
          ),
      ],
    );
  }
}

class _GoalTile extends StatelessWidget {
  const _GoalTile({
    required this.goal,
    required this.selected,
    required this.onTap,
  });

  final Goal goal;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    // Alternate the two brand glows so the grid is not four equal boxes.
    final glow = goal.index.isEven ? t.accent : t.blue;
    return Semantics(
      selected: selected,
      button: true,
      child: AnimatedScale(
        scale: selected ? 1.03 : 1,
        duration: _d(context, 220),
        curve: Curves.easeOutBack,
        child: AnimatedContainer(
          duration: _d(context, 220),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.card),
            gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [
                Color.lerp(t.surface1, glow, selected ? 0.22 : 0.08)!,
                t.surface1,
              ],
            ),
            border: Border.all(
              color: selected ? t.accent : t.border,
              width: selected ? 2 : 1,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: t.accent.withValues(alpha: 0.28),
                      blurRadius: 18,
                    ),
                  ]
                : const [],
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppRadius.card),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: _d(context, 220),
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: selected
                                ? t.accent
                                : glow.withValues(alpha: 0.16),
                            borderRadius: BorderRadius.circular(
                              AppRadius.iconBox,
                            ),
                          ),
                          child: Icon(
                            goalIcon(goal),
                            size: 28,
                            color: selected ? t.onAccent : glow,
                          ),
                        ),
                        const Spacer(),
                        AnimatedOpacity(
                          opacity: selected ? 1 : 0,
                          duration: _d(context, 200),
                          child: Icon(
                            Icons.check_circle_rounded,
                            color: t.accent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      context.l10n.goal(goal),
                      style: text.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// "Ready for you": the first tools the picked goal puts on Home.
class _GoalTools extends StatelessWidget {
  const _GoalTools({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final tools = [
      for (final id in goalPicks[goal]!.take(4)) ?context.tools.byId(id),
    ];
    // Full width: AnimatedSwitcher would otherwise center the section.
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            upperIn(context.l10n.welcomeReadyFor, context.l10n.localeName),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: t.accent,
              letterSpacing: 1.3,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: AppSpace.gapS,
            runSpacing: AppSpace.gapS,
            children: [
              for (final (i, tool) in tools.indexed)
                RiseIn(
                  index: i,
                  child: _ToolChip(tool: tool),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToolChip extends StatelessWidget {
  const _ToolChip({required this.tool});

  final ToolDef tool;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 7, 12, 7),
      decoration: BoxDecoration(
        color: t.surface1,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: t.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(tool.icon, size: 18, color: t.accent),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              tool.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: t.text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A document cover that fills in while the user types: the intro's
/// "type once, it lands everywhere" promise, now with their own startup.
class NamePreview extends StatelessWidget {
  const NamePreview({
    super.key,
    required this.name,
    required this.oneLiner,
    required this.lineHint,
  });

  final TextEditingController name;
  final TextEditingController oneLiner;

  /// Example one-liner of the picked category, shown until the user types.
  final String lineHint;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    final docs = [
      for (final id in ['leanCanvas', 'pitchDeck', 'onePager'])
        ?context.tools.byId(id),
    ];
    return ExcludeSemantics(
      child: ListenableBuilder(
        listenable: Listenable.merge([name, oneLiner]),
        builder: (context, _) {
          final typedName = name.text.trim();
          final typedLine = oneLiner.text.trim();
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.card),
              gradient: LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [Color.lerp(t.surface1, t.blue, 0.14)!, t.surface1],
              ),
              border: Border.all(
                color: typedName.isEmpty ? t.border : t.accent,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                  duration: _d(context, 180),
                  transitionBuilder: (child, a) =>
                      FadeTransition(opacity: a, child: child),
                  child: Text(
                    typedName.isEmpty
                        ? context.l10n.homeYourStartup
                        : typedName,
                    key: ValueKey(typedName.isEmpty),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.headlineSmall?.copyWith(
                      color: typedName.isEmpty ? t.muted : t.text,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  typedLine.isEmpty ? lineHint : typedLine,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: text.bodySmall?.copyWith(
                    color: typedLine.isEmpty
                        ? t.muted.withValues(alpha: 0.6)
                        : t.muted,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  upperIn(
                    context.l10n.welcomeFillsInto,
                    context.l10n.localeName,
                  ),
                  style: text.labelSmall?.copyWith(letterSpacing: 1.2),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: AppSpace.gapS,
                  runSpacing: AppSpace.gapS,
                  children: [
                    for (final doc in docs)
                      AnimatedContainer(
                        duration: _d(context, 260),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: typedName.isEmpty
                              ? t.surface2
                              : t.accent.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(AppRadius.chip),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              typedName.isEmpty
                                  ? doc.icon
                                  : Icons.check_rounded,
                              size: 15,
                              color: typedName.isEmpty ? t.muted : t.accent,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              doc.name,
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: typedName.isEmpty ? t.muted : t.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Short payoff after the last question: the launch path draws in with the
/// user's startup on it, then Home opens. Tap to skip; instant with Reduce
/// Motion.
class LaunchReveal extends StatefulWidget {
  const LaunchReveal({super.key, required this.project, required this.onDone});

  final Project project;
  final VoidCallback onDone;

  @override
  State<LaunchReveal> createState() => _LaunchRevealState();
}

class _LaunchRevealState extends State<LaunchReveal> {
  Timer? _timer;
  var _done = false;

  void _finish() {
    if (_done) return;
    _done = true;
    _timer?.cancel();
    widget.onDone();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer?.cancel();
    if (AppMotion.reduced(context)) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _finish());
    } else {
      _timer = Timer(const Duration(milliseconds: 2600), _finish);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final t = context.tokens;
    final name = widget.project[ProjectField.startupName].trim();
    final next = nextBestStep(widget.project, const {});
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _finish,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.edge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RiseIn(
                index: 0,
                child: Center(
                  child: Pulse(
                    scale: 0.08,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: t.accent,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: t.accent.withValues(alpha: 0.45),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.rocket_launch_rounded,
                        size: 40,
                        color: t.onAccent,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              RiseIn(
                index: 1,
                child: Text(
                  name.isEmpty ? context.l10n.launchReady : name,
                  textAlign: TextAlign.center,
                  style: text.displaySmall,
                ),
              ),
              if (name.isNotEmpty) ...[
                const SizedBox(height: 6),
                RiseIn(
                  index: 2,
                  child: Text(
                    context.l10n.launchReady,
                    textAlign: TextAlign.center,
                    style: text.bodyLarge?.copyWith(color: t.muted),
                  ),
                ),
              ],
              const SizedBox(height: 28),
              RiseIn(
                index: 3,
                child: LaunchPathCard(
                  project: widget.project,
                  usedTools: const {},
                ),
              ),
              if (next != null) ...[
                const SizedBox(height: 14),
                RiseIn(
                  index: 4,
                  child: Text(
                    context.l10n.launchFirstStep(
                      context.l10n.stepAction(next.step),
                    ),
                    textAlign: TextAlign.center,
                    style: text.bodyLarge?.copyWith(
                      color: t.accent,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
