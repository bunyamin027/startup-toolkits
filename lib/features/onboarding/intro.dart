import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';
import '../../core/widgets/motion.dart';
import '../../engines/calc_engine.dart';
import '../../l10n/l10n.dart';
import '../../l10n/locale_providers.dart';
import '../../tools/tool_def.dart';

/// First-run story before the goal question: what the app is (45 tools),
/// what makes it different (type once, every tool fills itself) and what
/// it gives back (live numbers, private by design).
///
/// Visuals are decorative: they skip semantics, ignore Dynamic Type (they
/// scale as a whole instead) and stand still when Reduce Motion is on.
const introSlideCount = 3;

/// Example startup typed into the autofill demo.
const _demoName = 'Nimbly';

const _fieldHeight = 96.0;

class IntroSlide extends StatelessWidget {
  const IntroSlide({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final tools = context.tools;
    final (visual, title, body, extra) = switch (index) {
      0 => (
        const _Orbit(),
        l.introHeroTitle,
        l.introHeroBody(tools.tools.length),
        const _Stats(),
      ),
      1 => (
        const _AutofillDemo(),
        l.introAutofillTitle,
        l.introAutofillBody,
        null,
      ),
      _ => (
        const _NumbersDemo(),
        l.introNumbersTitle,
        l.introNumbersBody,
        const _PrivatePill(),
      ),
    };
    return LayoutBuilder(
      builder: (context, box) => Column(
        children: [
          Expanded(
            child: ExcludeSemantics(
              child: MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.noScaling),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Center(child: FittedBox(child: visual)),
                ),
              ),
            ),
          ),
          // Text gets up to half the height and scrolls beyond that (large
          // Dynamic Type on small phones); the visual takes the rest.
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: box.maxHeight * 0.5),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.edge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RiseIn(
                    index: 0,
                    child: Text(
                      title,
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall?.copyWith(fontSize: 30),
                    ),
                  ),
                  const SizedBox(height: 10),
                  RiseIn(
                    index: 1,
                    child: Text(
                      body,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: context.tokens.muted,
                        height: 1.4,
                      ),
                    ),
                  ),
                  if (extra != null) ...[
                    const SizedBox(height: 18),
                    RiseIn(index: 2, child: extra),
                  ],
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Soft colored glows drifting behind the intro.
class IntroBackdrop extends StatefulWidget {
  const IntroBackdrop({super.key});

  @override
  State<IntroBackdrop> createState() => _IntroBackdropState();
}

class _IntroBackdropState extends State<IntroBackdrop>
    with SingleTickerProviderStateMixin {
  late final _drift = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 14),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loop(_drift, context, reverse: true);
  }

  @override
  void dispose() {
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    Widget glow(Color color, double size) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0)],
        ),
      ),
    );
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _drift,
        builder: (context, _) {
          final p = Curves.easeInOut.transform(_drift.value);
          return Stack(
            children: [
              Align(
                alignment: Alignment.lerp(
                  const Alignment(-1.3, -0.9),
                  const Alignment(-0.5, -0.5),
                  p,
                )!,
                child: glow(t.accent, 420),
              ),
              Align(
                alignment: Alignment.lerp(
                  const Alignment(1.3, 0.1),
                  const Alignment(0.6, -0.3),
                  p,
                )!,
                child: glow(t.blue, 380),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Repeats [c] unless motion is reduced, in which case it rests at [rest].
void _loop(
  AnimationController c,
  BuildContext context, {
  bool reverse = false,
  double rest = 0,
}) {
  if (AppMotion.reduced(context)) {
    c
      ..stop()
      ..value = rest;
  } else if (!c.isAnimating) {
    c.repeat(reverse: reverse);
  }
}

/// Plays [c] once, or shows its end state when motion is reduced.
void _once(AnimationController c, BuildContext context) {
  if (AppMotion.reduced(context)) {
    c.value = 1;
  } else if (c.value == 0 && !c.isAnimating) {
    c.forward();
  }
}

double _phase(
  double t,
  double start,
  double end, [
  Curve curve = Curves.linear,
]) => curve.transform(((t - start) / (end - start)).clamp(0.0, 1.0));

// ------------------------------------------------------------------ Slide 1

/// "45 tools" at the center, real tool icons orbiting in two rings.
class _Orbit extends StatefulWidget {
  const _Orbit();

  @override
  State<_Orbit> createState() => _OrbitState();
}

class _OrbitState extends State<_Orbit> with TickerProviderStateMixin {
  late final _enter = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  );
  late final _spin = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 50),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _once(_enter, context);
    _loop(_spin, context);
  }

  @override
  void dispose() {
    _enter.dispose();
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final tools = context.tools.tools;
    // One icon per category first, so the rings show the whole range.
    final icons = [
      for (final c in ToolCategory.values)
        tools.firstWhere((tool) => tool.category == c).icon,
      for (final c in ToolCategory.values.take(6))
        tools.lastWhere((tool) => tool.category == c).icon,
    ];
    const size = 320.0;
    const inner = 6;

    return SizedBox.square(
      dimension: size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_enter, _spin]),
        builder: (context, _) {
          final enter = _enter.value;
          final spin = _spin.value * 2 * math.pi;
          Widget chip(int i) {
            final ring = i < inner ? 0 : 1;
            final count = ring == 0 ? inner : icons.length - inner;
            final slot = ring == 0 ? i : i - inner;
            final radius = ring == 0 ? 92.0 : 142.0;
            final angle =
                slot / count * 2 * math.pi + (ring == 0 ? spin : -spin * 0.7);
            final pop = _phase(
              enter,
              0.15 + i * 0.035,
              0.5 + i * 0.035,
              Curves.easeOutBack,
            );
            final color = i.isEven ? t.accent : t.blue;
            return Positioned(
              left: size / 2 + math.cos(angle) * radius * pop - 19,
              top: size / 2 + math.sin(angle) * radius * pop - 19,
              child: Opacity(
                opacity: pop.clamp(0.0, 1.0),
                child: Transform.scale(
                  scale: pop,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: t.surface1,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: t.border),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.25),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: Icon(icons[i], size: 20, color: color),
                  ),
                ),
              ),
            );
          }

          final core = _phase(enter, 0, 0.45, Curves.easeOutCubic);
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _RingsPainter(
                    color: t.border,
                    progress: _phase(enter, 0.05, 0.6, Curves.easeOut),
                    radii: const [92, 142],
                  ),
                ),
              ),
              for (var i = 0; i < icons.length; i++) chip(i),
              Center(
                child: Transform.scale(
                  scale: 0.6 + 0.4 * core,
                  child: Opacity(opacity: core, child: const _Core()),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Core extends StatelessWidget {
  const _Core();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Pulse(
      scale: 0.05,
      child: Container(
        width: 116,
        height: 116,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [t.accent, t.blue],
          ),
          boxShadow: [
            BoxShadow(
              color: t.accent.withValues(alpha: 0.45),
              blurRadius: 36,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CountUp(
              value: context.tools.tools.length.toDouble(),
              format: (v) => v.round().toString(),
              style: TextStyle(
                color: t.onAccent,
                fontSize: 40,
                fontWeight: FontWeight.w800,
                height: 1,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            Text(
              context.l10n.introStatTools,
              style: TextStyle(
                color: t.onAccent,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RingsPainter extends CustomPainter {
  _RingsPainter({
    required this.color,
    required this.progress,
    required this.radii,
  });

  final Color color;
  final double progress;
  final List<double> radii;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    final center = size.center(Offset.zero);
    for (final r in radii) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: r),
        -math.pi / 2,
        2 * math.pi * progress,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_RingsPainter old) =>
      old.progress != progress || old.color != color;
}

/// 10 categories · 5 languages · 0 sign-ups (the 45 sits in the orbit).
class _Stats extends StatelessWidget {
  const _Stats();

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final t = context.tokens;
    final text = Theme.of(context).textTheme;
    Widget stat(int value, String label) => Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CountUp(
            value: value.toDouble(),
            format: (v) => v.round().toString(),
            style: text.titleLarge?.copyWith(color: t.accent, fontSize: 26),
          ),
          Text(label, style: text.bodySmall),
        ],
      ),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        stat(ToolCategory.values.length, l.introStatCategories),
        stat(languageNames.length, l.introStatLanguages),
        stat(0, l.introStatAccounts),
      ],
    );
  }
}

// ------------------------------------------------------------------ Slide 2

/// The startup name is typed once and lands in three documents.
class _AutofillDemo extends StatefulWidget {
  const _AutofillDemo();

  @override
  State<_AutofillDemo> createState() => _AutofillDemoState();
}

class _AutofillDemoState extends State<_AutofillDemo>
    with SingleTickerProviderStateMixin {
  late final _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 6400),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reduced motion rests on the filled state.
    _loop(_c, context, rest: 0.8);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final tools = context.tools;
    final docs = [
      tools.byId('pitchDeck')!,
      tools.byId('nda')!,
      tools.byId('invoice')!,
    ];
    return SizedBox(
      width: 330,
      height: 310,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final v = _c.value;
          // Everything fades back before the loop restarts.
          final fade = 1 - _phase(v, 0.9, 1);
          final typed = _phase(v, 0.06, 0.3);
          final chars = (_demoName.length * typed).ceil();
          final caretOn = v < 0.4 && (v * 14).floor().isEven;
          final flows = [
            for (var i = 0; i < docs.length; i++)
              _phase(v, 0.32 + i * 0.07, 0.48 + i * 0.07, Curves.easeInOut),
          ];
          final fills = [
            for (var i = 0; i < docs.length; i++)
              _phase(v, 0.46 + i * 0.07, 0.56 + i * 0.07, Curves.easeOutBack),
          ];
          return Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _FlowPainter(
                    line: t.border,
                    dot: t.accent,
                    progress: flows,
                    fade: fade,
                  ),
                ),
              ),
              Positioned(
                left: 45,
                right: 45,
                top: 0,
                child: _FieldCard(
                  label: context.l10n.fieldStartupName,
                  value: _demoName.substring(0, chars),
                  caret: caretOn,
                  fade: fade,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Row(
                  children: [
                    for (var i = 0; i < docs.length; i++) ...[
                      if (i > 0) const SizedBox(width: 10),
                      Expanded(
                        child: _DocCard(tool: docs[i], fill: fills[i] * fade),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FieldCard extends StatelessWidget {
  const _FieldCard({
    required this.label,
    required this.value,
    required this.caret,
    required this.fade,
  });

  final String label;
  final String value;
  final bool caret;
  final double fade;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      height: _fieldHeight,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: t.surface1,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: t.accent, width: 1.5),
        boxShadow: [
          BoxShadow(color: t.accent.withValues(alpha: 0.2), blurRadius: 24),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: t.muted, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Opacity(
                opacity: fade,
                child: Text(
                  value,
                  style: TextStyle(
                    color: t.text,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                width: 2.5,
                height: 26,
                margin: const EdgeInsetsDirectional.only(start: 2),
                color: caret ? t.accent : Colors.transparent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DocCard extends StatelessWidget {
  const _DocCard({required this.tool, required this.fill});

  final ToolDef tool;

  /// 0 = empty, 1 = the name has landed.
  final double fill;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final landed = fill.clamp(0.0, 1.0);
    Widget bar(double width) => Container(
      height: 6,
      width: width,
      margin: const EdgeInsets.only(top: 6),
      decoration: BoxDecoration(
        color: t.surface2,
        borderRadius: BorderRadius.circular(3),
      ),
    );
    return Container(
      height: 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: t.surface1,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Color.lerp(t.border, t.accent, landed)!,
          width: 1 + landed * 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(tool.icon, size: 22, color: t.blue),
          const SizedBox(height: 6),
          // Takes whatever height is left; long names shorten, never spill.
          Expanded(
            child: Text(
              tool.name,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: t.text,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                height: 1.15,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.6 + 0.4 * fill,
            alignment: AlignmentDirectional.centerStart,
            child: Opacity(
              opacity: landed,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: t.accent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _demoName,
                  style: TextStyle(
                    color: t.onAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          bar(64),
          bar(44),
        ],
      ),
    );
  }
}

/// Lines from the name field down to each document, with a dot riding
/// each line as the name travels.
class _FlowPainter extends CustomPainter {
  _FlowPainter({
    required this.line,
    required this.dot,
    required this.progress,
    required this.fade,
  });

  final Color line;
  final Color dot;
  final List<double> progress;
  final double fade;

  @override
  void paint(Canvas canvas, Size size) {
    final start = Offset(size.width / 2, _fieldHeight);
    final cardWidth = (size.width - 20) / 3;
    final linePaint = Paint()
      ..color = line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (var i = 0; i < progress.length; i++) {
      final end = Offset(
        cardWidth / 2 + i * (cardWidth + 10),
        size.height - 150,
      );
      final path = Path()
        ..moveTo(start.dx, start.dy)
        ..cubicTo(start.dx, start.dy + 40, end.dx, end.dy - 40, end.dx, end.dy);
      canvas.drawPath(path, linePaint);
      final p = progress[i];
      if (p <= 0 || p >= 1 || fade < 1) continue;
      final metric = path.computeMetrics().first;
      final at = metric.getTangentForOffset(metric.length * p)!.position;
      canvas.drawCircle(at, 9, Paint()..color = dot.withValues(alpha: 0.25));
      canvas.drawCircle(at, 4.5, Paint()..color = dot);
    }
  }

  @override
  bool shouldRepaint(_FlowPainter old) => true;
}

// ------------------------------------------------------------------ Slide 3

/// Real results from the calculators, counting up.
class _NumbersDemo extends StatelessWidget {
  const _NumbersDemo();

  @override
  Widget build(BuildContext context) {
    final t = context.tools;
    final fmt = context.fmt;
    final tokens = context.tokens;

    /// Output of a calculator on its example data, labeled by the output
    /// or, where the output name needs context, by the tool.
    (String, CalcOutput) result(
      String toolId,
      String key, {
      bool byTool = false,
    }) {
      final tool = t.byId(toolId)!;
      final out = CalcEngine.run(
        tool.formula!,
        tool.defaults,
      ).outputs.firstWhere((o) => o.key == key);
      return (byTool ? tool.name : tool.outputLabel(key, out.label), out);
    }

    final (runwayLabel, runway) = result('runway', 'runway');
    final metrics = [
      result('unitEconomics', 'ltvCac'),
      result('valuation', 'mid', byTool: true),
    ];

    return SizedBox(
      width: 330,
      height: 310,
      child: Column(
        children: [
          RingGauge(
            progress: runway.value / 18,
            size: 176,
            stroke: 14,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FittedBox(
                  child: CountUp(
                    value: runway.value,
                    format: (v) => runway.formatValue(v, fmt),
                    style: TextStyle(
                      color: tokens.text,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
                Text(
                  runwayLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: tokens.muted, fontSize: 13),
                ),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              for (final (i, (label, out)) in metrics.indexed) ...[
                if (i > 0) const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 96,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: tokens.surface1,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: tokens.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FittedBox(
                          child: CountUp(
                            value: out.value,
                            format: (v) => out.formatValue(v, fmt),
                            style: TextStyle(
                              color: i == 0 ? tokens.accent : tokens.blue,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          label,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: tokens.muted,
                            fontSize: 12,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _PrivatePill extends StatelessWidget {
  const _PrivatePill();

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: t.surface1,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: t.border),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, size: 20, color: t.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              context.l10n.introPrivate,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
