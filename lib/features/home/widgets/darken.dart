import 'package:flutter/material.dart';

extension ColorDarken on Color {
  /// Darkens the color by a given factor.
  Color darken([double amount = 0.1]) {
    // Clamp the amount between 0.0 and 1.0
    final clampedAmount = amount.clamp(0.0, 1.0);

    // Convert color to HSL (Hue, Saturation, Lightness)
    final hslColor = HSLColor.fromColor(this);

    // Darken the lightness by the given amount
    final darkenedHsl = hslColor.withLightness(
      (hslColor.lightness - clampedAmount).clamp(0.0, 1.0),
    );

    // Convert back to Color
    return darkenedHsl.toColor();
  }
}
