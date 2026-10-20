import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/analytics.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/widgets/motion.dart';
import '../../project/project.dart';
import '../../project/project_providers.dart';
import '../../tools/tool_def.dart';
import '../project/project_sheets.dart';
import '../../l10n/l10n.dart';

/// First run: pick a goal, then name the startup. Both steps can be
/// skipped; there is no account (UX principle 1: value in 60 seconds).
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  int _page = 0;
  Goal? _goal;
  final _name = TextEditingController();
  final _oneLiner = TextEditingController();
  @override
  void dispose() {
    _name.dispose();
    _oneLiner.dispose();
    super.dispose();
  }

  void _finish() {
    final project = ref.read(projectProvider.notifier);
    if (_goal != null) project.setGoal(_goal);
    if (_name.text.trim().isNotEmpty) {
      project.setField(ProjectField.startupName, _name.text.trim());
    }
    if (_oneLiner.text.trim().isNotEmpty) {
      project.setField(ProjectField.oneLiner, _oneLiner.text.trim());
    }
    final analytics = ref.read(analyticsProvider);
    if (_goal != null) {
      analytics.log(AnalyticsEvent.onboardingGoalSelected, {
        'goal': _goal!.name,
      });
    }
    if (_name.text.trim().isNotEmpty) {
      analytics.log(AnalyticsEvent.projectCreated);
    }
    ref.read(onboardingDoneProvider.notifier).complete();
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
              child: Row(
                children: [
                  if (_page == 1)
                    IconButton(
                      tooltip: context.l10n.commonBack,
                      onPressed: () => setState(() => _page = 0),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  const Spacer(),
                  TextButton(
                    onPressed: _finish,
                    child: Text(context.l10n.commonSkip),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: AppMotion.reduced(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 300),
                child: _page == 0 ? _goalPage(text) : _namePage(text),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpace.edge,
                8,
                AppSpace.edge,
                16,
              ),
              child: SizedBox(
                width: double.infinity,
                child: _page == 0
                    ? FilledButton(
                        onPressed: _goal == null
                            ? null
                            : () => setState(() => _page = 1),
                        child: Text(context.l10n.commonContinue),
                      )
                    : ListenableBuilder(
                        listenable: _name,
                        builder: (context, _) => FilledButton(
                          onPressed: _finish,
                          child: Text(
                            _name.text.trim().isEmpty
                                ? context.l10n.welcomeSkipForNow
                                : context.l10n.welcomeStart,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _goalPage(TextTheme text) {
    return ListView(
      key: const ValueKey('goal'),
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.edge),
      children: [
        RiseIn(
          index: 0,
          child: Text(context.l10n.welcomeGoalTitle, style: text.displaySmall),
        ),
        const SizedBox(height: 8),
        RiseIn(
          index: 1,
          child: Text(context.l10n.welcomeGoalSubtitle, style: text.bodySmall),
        ),
        const SizedBox(height: 22),
        for (final (i, g) in Goal.values.indexed) ...[
          RiseIn(
            index: i + 2,
            child: _GoalCard(
              goal: g,
              detail: context.l10n.goalDetail(g),
              selected: _goal == g,
              onTap: () => setState(() => _goal = g),
            ),
          ),
          const SizedBox(height: AppSpace.gapM),
        ],
      ],
    );
  }

  Widget _namePage(TextTheme text) {
    return ListView(
      key: const ValueKey('name'),
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.edge),
      children: [
        Text(context.l10n.welcomeNameTitle, style: text.displaySmall),
        const SizedBox(height: 8),
        Text(context.l10n.welcomeNameSubtitle, style: text.bodySmall),
        const SizedBox(height: 22),
        TextField(
          controller: _name,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: context.l10n.fieldStartupName,
            hintText: context.l10n.hintStartupName,
          ),
        ),
        const SizedBox(height: AppSpace.gapL),
        TextField(
          controller: _oneLiner,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.done,
          minLines: 2,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: context.l10n.fieldOneLiner,
            hintText: context.l10n.welcomeOneLinerHint,
          ),
          onSubmitted: (_) => _finish(),
        ),
      ],
    );
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.goal,
    required this.detail,
    required this.selected,
    required this.onTap,
  });

  final Goal goal;
  final String detail;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
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
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: selected ? t.accent : t.surface2,
                    borderRadius: BorderRadius.circular(AppRadius.iconBox),
                  ),
                  child: Icon(
                    goalIcon(goal),
                    color: selected ? t.onAccent : t.accent,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.goal(goal),
                        style: text.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(detail, style: text.bodySmall),
                    ],
                  ),
                ),
                if (selected) Icon(Icons.check_circle_rounded, color: t.accent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
