import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/analytics.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/widgets/motion.dart';
import '../../project/project.dart';
import '../../project/project_providers.dart';
import '../../tools/tool_def.dart';
import '../../l10n/l10n.dart';
import '../../tools/catalog/catalog.dart';
import '../project/project_sheets.dart';
import 'intro.dart';
import 'onboarding_steps.dart';

/// First run: a three-slide story of what the app does, then pick a goal
/// and name the startup. Everything can be skipped; there is no account
/// (UX principle 1: value in 60 seconds).
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

/// Steps after the intro slides; [launch] is the short payoff screen.
enum _Step { intro, goal, name, launch }

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  _Step _step = _Step.intro;
  int _slide = 0;
  var _slides = PageController();

  /// Replaced controllers; an outgoing page may still use one mid-fade.
  final _retired = <PageController>[];
  Sector? _sector;
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

  /// Keeps what was answered so far in the project.
  void _saveAnswers() {
    final project = ref.read(projectProvider.notifier);
    if (_goal != null) project.setGoal(_goal);
    if (_sector != null) project.setSector(_sector);
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
  }

  /// Skip: straight to Home with whatever was answered.
  void _finish() {
    _saveAnswers();
    ref.read(onboardingDoneProvider.notifier).complete();
  }

  /// Last question answered: show the payoff, then Home.
  void _launch() {
    _saveAnswers();
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => _step = _Step.launch);
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
                if (_step != _Step.launch)
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
                if (_step == _Step.goal || _step == _Step.name)
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      AppSpace.edge,
                      4,
                      AppSpace.edge,
                      16,
                    ),
                    child: OnboardingProgress(
                      step: _step == _Step.goal ? 1 : 2,
                    ),
                  ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: _motion,
                    child: switch (_step) {
                      _Step.intro => _introPages(),
                      _Step.goal => _goalPage(text),
                      _Step.name => _namePage(text),
                      _Step.launch => LaunchReveal(
                        key: const ValueKey('launch'),
                        project: ref.watch(projectProvider),
                        onDone: () => ref
                            .read(onboardingDoneProvider.notifier)
                            .complete(),
                      ),
                    },
                  ),
                ),
                if (intro) _Dots(index: _slide, count: introSlideCount),
                if (_step != _Step.launch)
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
                        // Appears once a goal is picked instead of sitting
                        // there greyed out.
                        _Step.goal => IgnorePointer(
                          ignoring: _goal == null,
                          child: ExcludeSemantics(
                            excluding: _goal == null,
                            child: AnimatedSlide(
                              offset: _goal == null
                                  ? const Offset(0, 0.6)
                                  : Offset.zero,
                              duration: _motion,
                              curve: Curves.easeOutCubic,
                              child: AnimatedOpacity(
                                opacity: _goal == null ? 0 : 1,
                                duration: _motion,
                                child: FilledButton(
                                  onPressed: () =>
                                      setState(() => _step = _Step.name),
                                  child: Text(context.l10n.commonContinue),
                                ),
                              ),
                            ),
                          ),
                        ),
                        _Step.launch => const SizedBox.shrink(),
                        _Step.name => ListenableBuilder(
                          listenable: _name,
                          builder: (context, _) => FilledButton(
                            onPressed: _launch,
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
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpace.edge,
        0,
        AppSpace.edge,
        16,
      ),
      children: [
        RiseIn(
          index: 0,
          child: Text(context.l10n.welcomeGoalTitle, style: text.displaySmall),
        ),
        const SizedBox(height: 8),
        RiseIn(
          index: 1,
          child: Text(
            context.l10n.welcomeGoalSubtitle,
            style: text.bodyLarge?.copyWith(
              color: context.tokens.muted,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(height: 24),
        GoalPicker(selected: _goal, onPick: (g) => setState(() => _goal = g)),
      ],
    );
  }

  Widget _namePage(TextTheme text) {
    // Hints follow the picked category (R&D until one is picked).
    final example = ToolCatalog.of(
      context.l10n.localeName,
      _sector ?? Sector.fallback,
    ).byId('pitchDeck')!;
    final nameHint = '${example.field('company')!.defaultValue}';
    final lineHint = '${example.field('oneLiner')!.defaultValue}';
    return ListView(
      key: const ValueKey('name'),
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.edge),
      children: [
        Text(context.l10n.welcomeNameTitle, style: text.displaySmall),
        const SizedBox(height: 8),
        Text(
          context.l10n.welcomeNameSubtitle,
          style: text.bodyLarge?.copyWith(
            color: context.tokens.muted,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          context.l10n.welcomeSectorTitle,
          style: text.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: AppSpace.gapS,
          runSpacing: AppSpace.gapS,
          children: [
            for (final s in Sector.values)
              ChoiceChip(
                avatar: Icon(
                  sectorIcon(s),
                  size: 18,
                  color: s == _sector
                      ? context.tokens.onAccent
                      : context.tokens.accent,
                ),
                label: Text(context.l10n.sector(s)),
                selected: s == _sector,
                showCheckmark: false,
                selectedColor: context.tokens.accent,
                labelStyle: TextStyle(
                  color: s == _sector
                      ? context.tokens.onAccent
                      : context.tokens.text,
                ),
                onSelected: (_) => setState(() => _sector = s),
              ),
          ],
        ),
        const SizedBox(height: 22),
        TextField(
          controller: _name,
          textCapitalization: TextCapitalization.words,
          textInputAction: TextInputAction.next,
          style: text.titleLarge?.copyWith(fontSize: 22),
          decoration: InputDecoration(
            labelText: context.l10n.fieldStartupName,
            hintText: context.l10n.commonExample(nameHint),
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
            hintText: lineHint,
          ),
          onSubmitted: (_) => _launch(),
        ),
        const SizedBox(height: 22),
        RiseIn(
          index: 2,
          child: NamePreview(
            name: _name,
            oneLiner: _oneLiner,
            lineHint: lineHint,
          ),
        ),
        const SizedBox(height: 16),
      ],
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
