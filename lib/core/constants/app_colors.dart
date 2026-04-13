import 'package:flutter/material.dart';

/// App color palette — matches the Figma design system.
/// Dark theme with Indigo (#6366F1) and Violet (#8B5CF6) accents.
class AppColors {
  AppColors._();

  // ── Background & Surface ──────────────────────────────────────────────
  static const Color background = Color(0xFF0D0D0D);
  static const Color card = Color(0xFF1A1A1A);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceLight = Color(0xFF1A1A1A);
  static const Color surfaceVariant = Color(0xFF252525);
  static const Color secondary = Color(0xFF252525);

  // ── Primary Accent (Indigo) ───────────────────────────────────────────
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);

  // ── Violet Accent ─────────────────────────────────────────────────────
  static const Color violet = Color(0xFF8B5CF6);
  static const Color secondaryDark = Color(0xFF7C3AED);
  static const Color secondaryLight = Color(0xFFA78BFA);

  // ── Semantic Colors ───────────────────────────────────────────────────
  static const Color income = Color(0xFF10B981);    // Emerald — money in
  static const Color expense = Color(0xFFEF4444);   // Red — money out
  static const Color warning = Color(0xFFF59E0B);   // Amber — warnings
  static const Color error = Color(0xFFEF4444);     // Red — errors
  static const Color success = Color(0xFF10B981);   // Emerald — success

  // ── Text ──────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFFAFAFA);
  static const Color textSecondary = Color(0xFFA0A0A0);
  static const Color textHint = Color(0xFF666666);

  // ── Chart Colors ──────────────────────────────────────────────────────
  static const Color chart1 = Color(0xFF6366F1); // Indigo
  static const Color chart2 = Color(0xFF8B5CF6); // Violet
  static const Color chart3 = Color(0xFFEC4899); // Pink
  static const Color chart4 = Color(0xFF10B981); // Emerald
  static const Color chart5 = Color(0xFFF59E0B); // Amber

  // ── Category Colors (for expense pie chart) ───────────────────────────
  static const Color catFood = Color(0xFFF59E0B);
  static const Color catTravel = Color(0xFF6366F1);
  static const Color catShopping = Color(0xFFEC4899);
  static const Color catCollege = Color(0xFF8B5CF6);
  static const Color catOthers = Color(0xFFA0A0A0);
  static const Color catHousing = Color(0xFF8B5CF6);
  static const Color catHealth = Color(0xFF10B981);
  static const Color catTech = Color(0xFF3B82F6);

  // ── Priority Colors ───────────────────────────────────────────────────
  static const Color priorityHigh = Color(0xFFEF4444);
  static const Color priorityMedium = Color(0xFFF59E0B);
  static const Color priorityLow = Color(0xFF10B981);

  // ── Misc ──────────────────────────────────────────────────────────────
  static const Color divider = Color(0x14FFFFFF); // rgba(255,255,255,0.08)
  static const Color shimmer = Color(0xFF252525);
  static const Color cardBorder = Color(0x14FFFFFF); // rgba(255,255,255,0.08)
  static const Color inputBg = Color(0x0DFFFFFF); // rgba(255,255,255,0.05)

  /// Primary gradient: Indigo → Violet.
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, violet],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gradient for cards with primary tint.
  static const LinearGradient cardGradient = LinearGradient(
    colors: [
      Color(0x1A6366F1), // rgba(99,102,241,0.1)
      Color(0x1A8B5CF6), // rgba(139,92,246,0.1)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Expense gradient for hero cards.
  static LinearGradient expenseGradient = LinearGradient(
    colors: [
      expense.withOpacity(0.15),
      expense.withOpacity(0.05),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Income gradient for hero cards.
  static LinearGradient incomeGradient = LinearGradient(
    colors: [
      income.withOpacity(0.15),
      income.withOpacity(0.05),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Balance gradient — indigo/violet tint.
  static LinearGradient balanceGradient = LinearGradient(
    colors: [
      primary.withOpacity(0.15),
      violet.withOpacity(0.15),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Glassmorphism card decoration matching Figma.
  static BoxDecoration glassCard({double borderRadius = 16}) {
    return BoxDecoration(
      color: card,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: cardBorder, width: 1),
    );
  }

  /// Gradient hero card decoration.
  static BoxDecoration gradientCard({
    required LinearGradient gradient,
    double borderRadius = 16,
  }) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: cardBorder, width: 1),
    );
  }

  /// FAB glow shadow.
  static List<BoxShadow> fabGlow = [
    BoxShadow(
      color: primary.withOpacity(0.4),
      blurRadius: 32,
      offset: const Offset(0, 8),
    ),
  ];
}
