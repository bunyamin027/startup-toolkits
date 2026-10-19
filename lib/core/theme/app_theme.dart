import 'package:flutter/material.dart';

import 'app_tokens.dart';

/// Builds Material themes from [AppTokens]. Font is the platform system font
/// (SF Pro on iOS), so no fontFamily is set.
abstract final class AppTheme {
  static ThemeData get dark => _build(AppTokens.dark, Brightness.dark);
  static ThemeData get light => _build(AppTokens.light, Brightness.light);

  static ThemeData _build(AppTokens t, Brightness brightness) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: t.accent,
      onPrimary: t.onAccent,
      secondary: t.blue,
      onSecondary: t.text,
      surface: t.surface1,
      onSurface: t.text,
      surfaceContainerHighest: t.surface2,
      outline: t.border,
      error: const Color(0xFFFF6B6B),
      onError: t.onAccent,
    );

    const tabular = [FontFeature.tabularFigures()];

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: t.bg,
      extensions: [t],
      textTheme: TextTheme(
        displaySmall: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: t.text,
        ),
        headlineSmall: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: t.text,
        ),
        bodyLarge: TextStyle(fontSize: 16, color: t.text),
        bodyMedium: TextStyle(fontSize: 16, color: t.text),
        bodySmall: TextStyle(fontSize: 13, color: t.muted),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: t.muted,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: t.muted,
        ),
        // Numbers in results use titleLarge; tabular so digits stay aligned.
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: t.text,
          fontFeatures: tabular,
        ),
      ),
      cardTheme: CardThemeData(
        color: t.surface1,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.card),
          side: BorderSide(color: t.border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: t.accent,
          foregroundColor: t.onAccent,
          minimumSize: const Size(AppSpace.minTouch, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.button),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: t.surface2,
        side: BorderSide(color: t.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.chip),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: t.accent,
        inactiveTrackColor: t.surface2,
        thumbColor: t.accent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: t.surface2,
        labelStyle: TextStyle(color: t.muted),
        hintStyle: TextStyle(color: t.muted),
        helperStyle: TextStyle(color: t.muted, fontSize: 12),
        prefixStyle: TextStyle(color: t.muted, fontSize: 16),
        suffixStyle: TextStyle(color: t.muted, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.iconBox),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.iconBox),
          borderSide: BorderSide(color: t.accent, width: 1.5),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: t.bg,
        foregroundColor: t.text,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: t.text,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          minimumSize: const WidgetStatePropertyAll(Size(0, AppSpace.minTouch)),
          backgroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? t.accent : t.surface1,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? t.onAccent : t.text,
          ),
          side: WidgetStatePropertyAll(BorderSide(color: t.border)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: t.surface2,
        contentTextStyle: TextStyle(color: t.text),
        actionTextColor: t.accent,
      ),
      dividerColor: t.border,
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }
}
