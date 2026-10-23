import 'package:flutter/material.dart';

/// Brand palette ("Calm Premium Wellness").
class NuvoraColors {
  static const midnightNavy = Color(0xFF17263C);
  static const sageGreen = Color(0xFF8FAF91);
  static const warmIvory = Color(0xFFF7F5EF);
  static const softGold = Color(0xFFD9B56D);
  static const mutedBlue = Color(0xFF8DAFC5);
  static const charcoal = Color(0xFF292F36);
  static const mutedGray = Color(0xFF7D8792);
  static const darkSurface = Color(0xFF202D40);

  // Status colors; always paired with an icon or label, never color alone.
  static const success = Color(0xFF4F8A5B);
  static const warning = Color(0xFFB7791F);
  static const error = Color(0xFFB3413B);
}

/// 8-point spacing scale.
class Space {
  static const double x1 = 8;
  static const double x2 = 16;
  static const double x3 = 24;
  static const double x4 = 32;
  static const double x5 = 40;
}

class Radii {
  static const double card = 20;
  static const double control = 14;
}

/// Section identities. Each resolves to colors that stay readable in both themes.
enum NuvoraSection { body, soul, mind }

extension NuvoraSectionStyle on NuvoraSection {
  Color accent(Brightness b) {
    final dark = b == Brightness.dark;
    switch (this) {
      case NuvoraSection.body:
        return dark ? NuvoraColors.sageGreen : const Color(0xFF4F7A55);
      case NuvoraSection.soul:
        return dark ? NuvoraColors.softGold : const Color(0xFF8A6A25);
      case NuvoraSection.mind:
        return dark ? NuvoraColors.mutedBlue : const Color(0xFF3C6A8A);
    }
  }

  IconData get icon {
    switch (this) {
      case NuvoraSection.body:
        return Icons.self_improvement_outlined;
      case NuvoraSection.soul:
        return Icons.nights_stay_outlined;
      case NuvoraSection.mind:
        return Icons.menu_book_outlined;
    }
  }
}
