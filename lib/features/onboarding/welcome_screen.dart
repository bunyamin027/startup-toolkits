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
import 'intro.dart';

/// First run: a three-slide story of what the app does, then pick a goal
/// and name the startup. Everything can be skipped; there is no account
/// (UX principle 1: value in 60 seconds).
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

/// Steps after the intro slides.
enum _Step { intro, goal, name }

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  _Step _step = _Step.intro;
  int _slide = 0;
  var _slides = PageController();

  /// Replaced controllers; an outgoing page may still use one mid-fade.
  final _retired = <PageController>[];
  Goal? _goal;
  final _name = TextEditingController();
  final _oneLiner = TextEditingController();
  @override
  void dispose() {
    _slides.dispose();
    for (final c in _retired) {
      c.dispose();
    }
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

  Duration get _motion => AppMotion.reduced(context)
      ? Duration.zero
      : const Duration(milliseconds: 300);

  void _nextSlide() {
    if (_slide == introSlideCount - 1) {
      setState(() => _step = _Step.goal);
    } else {
      _slides.animateToPage(
        _slide + 1,
        duration: _motion == Duration.zero
            ? const Duration(milliseconds: 1)
            : const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _back() => setState(() {
    if (_step == _Step.name) {
      _step = _Step.goal;
    } else {
      // A new PageView attaches; start it on the slide the user left.
      _retired.add(_slides);
      _slides = PageController(initialPage: _slide);
      _step = _Step.intro;
    }
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final intro = _step == _Step.intro;
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: IntroBackdrop()),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
                  child: Row(
                    children: [
                      if (!intro)
                        IconButton(
                          tooltip: context.l10n.commonBack,
                          onPressed: _back,
                          icon: const Icon(Icons.arrow_back),
                        ),
                      const Spacer(),
                      // The intro skips to the goal question; later steps
                      // skip the rest of onboarding.
                      TextButton(
                        onPressed: intro
                            ? () => setState(() => _step = _Step.goal)
                            : _finish,
                        child: Text(context.l10n.commonSkip),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: _motion,
                    child: switch (_step) {
                      _Step.intro => _introPages(),
                      _Step.goal => _goalPage(text),
                      _Step.name => _namePage(text),
                    },
                  ),
                ),
                if (intro) _Dots(index: _slide, count: introSlideCount),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSpace.edge,
                    8,
                    AppSpace.edge,
                    16,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: switch (_step) {
                      _Step.intro => FilledButton(
                        onPressed: _nextSlide,
                        child: Text(
                          _slide == introSlideCount - 1
                              ? context.l10n.introGetStarted
                              : context.l10n.commonContinue,
                        ),
                      ),
                      _Step.goal => FilledButton(
                        onPressed: _goal == null
                            ? null
                            : () => setState(() => _step = _Step.name),
                        child: Text(context.l10n.commonContinue),
                      ),
                      _Step.name => ListenableBuilder(
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
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _introPages() => PageView.builder(
    key: const ValueKey('intro'),
    controller: _slides,
    itemCount: introSlideCount,
    onPageChanged: (i) => setState(() => _slide = i),
    itemBuilder: (context, i) => IntroSlide(index: i),
  );

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

/// Slide position: the current dot stretches into a pill.
class _Dots extends StatelessWidget {
  const _Dots({required this.index, required this.count});

  final int index;
  final int count;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Semantics(
      label: context.l10n.introStep(index + 1, count),
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < count; i++)
              AnimatedContainer(
                duration: AppMotion.reduced(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == index ? 22 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: i == index ? t.accent : t.border,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
