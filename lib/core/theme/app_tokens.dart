import 'package:flutter/material.dart';

/// Design tokens from master plan §7.1–7.2.
///
/// Widgets read colors through `context.tokens` instead of hard-coded values,
/// so the light theme only needs a second value set with the same names.
@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.bg,
    required this.surface1,
    required this.surface2,
    required this.border,
    required this.text,
    required this.muted,
    required this.accent,
    required this.onAccent,
    required this.blue,
  });

  final Color bg;
  final Color surface1;
  final Color surface2;
  final Color border;
  final Color text;
  final Color muted;
  final Color accent;
  final Color onAccent;
  final Color blue;

  static const dark = AppTokens(
    bg: Color(0xFF0B1020),
    surface1: Color(0xFF151B31),
    surface2: Color(0xFF1F2744),
    border: Color(0xFF2A3355),
    text: Color(0xFFF2F4FA),
    muted: Color(0xFFA3ACC8),
    accent: Color(0xFFB8F46A),
    onAccent: Color(0xFF0B1020),
    blue: Color(0xFF6C93FF),
  );

  // PLACEHOLDER: light theme is not designed yet (open decision #5).
  // Values are a neutral inversion so the app stays readable until then.
  static const light = AppTokens(
    bg: Color(0xFFF6F7FB),
    surface1: Color(0xFFFFFFFF),
    surface2: Color(0xFFE9ECF5),
    border: Color(0xFFD5DAE8),
    text: Color(0xFF0B1020),
    muted: Color(0xFF5A6380),
    accent: Color(0xFF5E9E1A),
    onAccent: Color(0xFFFFFFFF),
    blue: Color(0xFF3D6BEB),
  );

  @override
  AppTokens copyWith({
    Color? bg,
    Color? surface1,
    Color? surface2,
    Color? border,
    Color? text,
    Color? muted,
    Color? accent,
    Color? onAccent,
    Color? blue,
  }) {
    return AppTokens(
      bg: bg ?? this.bg,
      surface1: surface1 ?? this.surface1,
      surface2: surface2 ?? this.surface2,
      border: border ?? this.border,
      text: text ?? this.text,
      muted: muted ?? this.muted,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      blue: blue ?? this.blue,
    );
  }

  @override
  AppTokens lerp(AppTokens? other, double t) {
    if (other == null) return this;
    return AppTokens(
      bg: Color.lerp(bg, other.bg, t)!,
      surface1: Color.lerp(surface1, other.surface1, t)!,
      surface2: Color.lerp(surface2, other.surface2, t)!,
      border: Color.lerp(border, other.border, t)!,
      text: Color.lerp(text, other.text, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
    );
  }
}

/// Spacing, radius and size tokens (§7.2).
abstract final class AppSpace {
  static const double edge = 20;
  static const double gapS = 8;
  static const double gapM = 12;
  static const double gapL = 14;
  static const double minTouch = 44;
}

abstract final class AppRadius {
  static const double card = 22;
  static const double button = 18;
  static const double chip = 16;
  static const double iconBox = 14;
}

/// Motion durations (§7.3). Callers must skip them when
/// `MediaQuery.disableAnimationsOf(context)` is true.
abstract final class AppMotion {
  static const rise = Duration(milliseconds: 600);
  static const riseStagger = Duration(milliseconds: 70);
  static const riseOffset = 14.0;
  static const ring = Duration(milliseconds: 1400);
  static const counter = Duration(milliseconds: 1400);
  static const bar = Duration(milliseconds: 1100);
  static const pulse = Duration(milliseconds: 2000);
  static const sheet = Duration(milliseconds: 700);

  /// True when the user asked the OS to reduce motion.
  static bool reduced(BuildContext context) =>
      MediaQuery.maybeDisableAnimationsOf(context) ?? false;
}

extension AppTokensContext on BuildContext {
  AppTokens get tokens => Theme.of(this).extension<AppTokens>()!;
}
