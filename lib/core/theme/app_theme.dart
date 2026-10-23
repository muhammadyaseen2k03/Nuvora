import 'package:flutter/material.dart';

import 'tokens.dart';

class AppTheme {
  static ThemeData light() => _build(
        ColorScheme.fromSeed(
          seedColor: NuvoraColors.midnightNavy,
          brightness: Brightness.light,
        ).copyWith(
          primary: NuvoraColors.midnightNavy,
          onPrimary: NuvoraColors.warmIvory,
          secondary: const Color(0xFF4F7A55),
          tertiary: const Color(0xFF8A6A25),
          surface: NuvoraColors.warmIvory,
          onSurface: NuvoraColors.charcoal,
          onSurfaceVariant: const Color(0xFF5B6570),
          outlineVariant: const Color(0xFFDAD6CB),
          error: NuvoraColors.error,
        ),
        scaffold: NuvoraColors.warmIvory,
        card: Colors.white,
      );

  static ThemeData dark() => _build(
        ColorScheme.fromSeed(
          seedColor: NuvoraColors.sageGreen,
          brightness: Brightness.dark,
        ).copyWith(
          primary: NuvoraColors.softGold,
          onPrimary: NuvoraColors.midnightNavy,
          secondary: NuvoraColors.sageGreen,
          tertiary: NuvoraColors.mutedBlue,
          surface: NuvoraColors.midnightNavy,
          onSurface: NuvoraColors.warmIvory,
          onSurfaceVariant: const Color(0xFFB4BCC6),
          outlineVariant: const Color(0xFF34445A),
          error: const Color(0xFFE08A84),
        ),
        scaffold: NuvoraColors.midnightNavy,
        card: NuvoraColors.darkSurface,
      );

  static ThemeData _build(ColorScheme scheme,
      {required Color scaffold, required Color card}) {
    // Inter is not bundled yet; the platform sans-serif is used until the
    // font asset is added (see README, "Known gaps").
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      visualDensity: VisualDensity.standard,
    );
    final text = base.textTheme.copyWith(
      displaySmall: base.textTheme.displaySmall
          ?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
      headlineSmall:
          base.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
      titleLarge:
          base.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium:
          base.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    ).apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    return base.copyWith(
      textTheme: text,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffold,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.card),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 52),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Radii.control)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 52),
          side: BorderSide(color: scheme.outlineVariant),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Radii.control)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: card,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.control),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.control),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Radii.control),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: card,
        height: 68,
        indicatorColor: scheme.primary.withValues(alpha: 0.16),
        labelTextStyle: WidgetStatePropertyAll(
            text.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
