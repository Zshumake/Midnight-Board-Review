import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ─── Color System ───────────────────────────────────────────────────────────
class AppColors {
  // Surface layers (darkest → lightest)
  static const deepBlack = Color(0xFF0A0908);
  static const bgCharcoal = Color(0xFF141210);
  static const bgCard = Color(0xFF1E1B18);
  static const bgCardHover = Color(0xFF2A2622);
  static const bgElevated = Color(0xFF353129);
  static const bgInput = Color(0xFF17150F);

  // Text
  static const textMain = Color(0xFFF5F0EB);
  static const textSecondary = Color(0xFFD4CBC2);
  static const textMuted = Color(0xFF8E8579);
  static const textFaint = Color(0xFF5E564C);

  // Accent — amber/gold spectrum
  static const accentAmber = Color(0xFFD97706);
  static const accentGold = Color(0xFFF5B731);
  static const accentOrange = Color(0xFFF97316);
  static const accentWarm = Color(0xFFE85D4A);

  // Borders
  static const borderSubtle = Color(0xFF2A2520);
  static const borderMedium = Color(0xFF3D3530);
  static const borderGold = Color(0xFF92400E);
  static const borderGlow = Color(0x33D97706);

  // Semantic
  static const success = Color(0xFF22C55E);
  static const error = Color(0xFFEF4444);

  // Gradients
  static const amberGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD97706), Color(0xFFE8930C)],
  );
  static const cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1E1B18), Color(0xFF141210)],
  );
  static const heroGradient = RadialGradient(
    center: Alignment(0, -0.4),
    radius: 1.0,
    colors: [Color(0x18D97706), Color(0x08D97706), Color(0x00000000)],
  );
  static const subtleGlow = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [Color(0x0AD97706), Color(0x00000000)],
  );
}

// ─── Spacing ────────────────────────────────────────────────────────────────
class Spacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

// ─── Radii ──────────────────────────────────────────────────────────────────
class Radii {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double pill = 100;
}

// ─── Shadows ────────────────────────────────────────────────────────────────
class AppShadows {
  static final card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.4),
      blurRadius: 16,
      offset: const Offset(0, 4),
    ),
  ];
  static final glow = [
    BoxShadow(
      color: AppColors.accentAmber.withValues(alpha: 0.12),
      blurRadius: 24,
      spreadRadius: 2,
    ),
  ];
  static final glowStrong = [
    BoxShadow(
      color: AppColors.accentAmber.withValues(alpha: 0.25),
      blurRadius: 40,
      spreadRadius: 4,
    ),
  ];
  static final elevated = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.6),
      blurRadius: 32,
      offset: const Offset(0, 8),
    ),
  ];
}

// ─── Typography ─────────────────────────────────────────────────────────────
class AppTypography {
  static TextStyle displayLg(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textMain,
        height: 1.15,
        letterSpacing: -0.5,
      );

  static TextStyle headline(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: AppColors.textMain,
        height: 1.2,
        letterSpacing: -0.3,
      );

  static TextStyle headlineSm(BuildContext context) =>
      GoogleFonts.playfairDisplay(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: AppColors.textMain,
        height: 1.3,
      );

  static TextStyle body(BuildContext context) => GoogleFonts.sourceSans3(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      );

  static TextStyle bodySm(BuildContext context) => GoogleFonts.sourceSans3(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
        height: 1.4,
      );

  static TextStyle label(BuildContext context) => GoogleFonts.sourceSans3(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppColors.textMuted,
        letterSpacing: 1.2,
        height: 1,
      );

  static TextStyle labelSm(BuildContext context) => GoogleFonts.sourceSans3(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: AppColors.textFaint,
        letterSpacing: 1.4,
        height: 1,
      );

  static TextStyle mono(BuildContext context) => GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
      );

  static TextStyle monoSm(BuildContext context) => GoogleFonts.jetBrainsMono(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: AppColors.textFaint,
      );
}

// ─── Responsive helpers ─────────────────────────────────────────────────────
class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double horizontalPadding(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < 600) return Spacing.lg;
    if (w < 1024) return Spacing.xl;
    return Spacing.xxxl;
  }

  static double maxContentWidth(BuildContext context) {
    if (isDesktop(context)) return 720;
    if (isTablet(context)) return 600;
    return double.infinity;
  }
}

// ─── Theme ──────────────────────────────────────────────────────────────────
ThemeData buildAppTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bgCharcoal,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accentAmber,
      secondary: AppColors.accentOrange,
      surface: AppColors.bgCard,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textMain,
    ),
    cardColor: AppColors.bgCard,
    textTheme: GoogleFonts.sourceSans3TextTheme(
      ThemeData.dark().textTheme,
    ).apply(
      bodyColor: AppColors.textMain,
      displayColor: AppColors.textMain,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.textMain,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textMain,
        letterSpacing: 0.5,
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.accentAmber,
      inactiveTrackColor: AppColors.bgElevated,
      thumbColor: AppColors.accentGold,
      overlayColor: AppColors.accentAmber.withValues(alpha: 0.12),
      trackHeight: 3,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.textSecondary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.bgInput,
      hintStyle: const TextStyle(color: AppColors.textFaint, fontSize: 13),
      contentPadding: const EdgeInsets.symmetric(
          horizontal: Spacing.lg, vertical: Spacing.md),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.md),
        borderSide: const BorderSide(color: AppColors.borderSubtle),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.md),
        borderSide: const BorderSide(color: AppColors.borderSubtle),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.md),
        borderSide:
            const BorderSide(color: AppColors.accentAmber, width: 1.5),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.bgElevated,
      contentTextStyle: const TextStyle(color: AppColors.textMain),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.sm)),
      behavior: SnackBarBehavior.floating,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.bgCard,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.xl)),
    ),
  );
}
