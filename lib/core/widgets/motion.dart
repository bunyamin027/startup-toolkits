import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

/// Fades in while rising 14 px; items stagger by 70 ms (§7.3).
/// Renders the child directly when motion is reduced.
class RiseIn extends StatelessWidget {
  const RiseIn({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (AppMotion.reduced(context)) return child;
    final delay = AppMotion.riseStagger * index;
    final total = AppMotion.rise + delay;
    final start = delay.inMilliseconds / total.inMilliseconds;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: total,
      child: child,
      builder: (context, t, child) {
        final p = Curves.easeOutCubic.transform(
          ((t - start) / (1 - start)).clamp(0, 1),
        );
        return Opacity(
          opacity: p,
          child: Transform.translate(
            offset: Offset(0, AppMotion.riseOffset * (1 - p)),
            child: child,
          ),
        );
      },
    );
  }
}

/// Animates a number from its previous value to [value] (0 on first build).
class CountUp extends StatelessWidget {
  const CountUp({
    super.key,
    required this.value,
    required this.format,
    this.style,
  });

  final double value;
  final String Function(double) format;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    if (!value.isFinite || AppMotion.reduced(context)) {
      return Text(format(value), style: style);
    }
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: AppMotion.counter,
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => Text(format(v), style: style),
    );
  }
}

/// Progress ring that draws its stroke over 1.4 s (§7.3).
class RingGauge extends StatelessWidget {
  const RingGauge({
    super.key,
    required this.progress,
    required this.child,
    this.size = 200,
    this.stroke = 14,
  });

  /// 0–1.
  final double progress;
  final Widget child;
  final double size;
  final double stroke;

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    final target = progress.isFinite ? progress.clamp(0.0, 1.0) : 1.0;
    Widget ring(double p) => CustomPaint(
      painter: _RingPainter(p, t.surface2, t.accent, stroke),
      child: SizedBox.square(
        dimension: size,
        child: Center(child: child),
      ),
    );
    if (AppMotion.reduced(context)) return ring(target);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: target),
      duration: AppMotion.ring,
      curve: Curves.easeOutCubic,
      builder: (context, p, _) => ring(p),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter(this.progress, this.track, this.color, this.stroke);

  final double progress;
  final Color track;
  final Color color;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final arcRect = rect.deflate(stroke / 2);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(arcRect, 0, math.pi * 2, false, paint..color = track);
    if (progress > 0) {
      canvas.drawArc(
        arcRect,
        -math.pi / 2,
        math.pi * 2 * progress,
        false,
        paint..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress || old.color != color || old.track != track;
}
