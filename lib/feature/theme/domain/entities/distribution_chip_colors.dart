import 'package:flutter/material.dart';

class DistributionChipColors extends ThemeExtension<DistributionChipColors> {
  const DistributionChipColors({
    required this.continuousBackground,
    required this.continuousForeground,
    required this.discreteBackground,
    required this.discreteForeground,
  });

  final Color continuousBackground;
  final Color continuousForeground;
  final Color discreteBackground;
  final Color discreteForeground;

  @override
  DistributionChipColors copyWith({
    Color? continuousBackground,
    Color? continuousForeground,
    Color? discreteBackground,
    Color? discreteForeground,
  }) {
    return DistributionChipColors(
      continuousBackground: continuousBackground ?? this.continuousBackground,
      continuousForeground: continuousForeground ?? this.continuousForeground,
      discreteBackground: discreteBackground ?? this.discreteBackground,
      discreteForeground: discreteForeground ?? this.discreteForeground,
    );
  }

  @override
  DistributionChipColors lerp(ThemeExtension<DistributionChipColors>? other, double t) {
    if (other is! DistributionChipColors) {
      return this;
    }

    return DistributionChipColors(
      continuousBackground:
          Color.lerp(continuousBackground, other.continuousBackground, t) ??
          continuousBackground,
      continuousForeground:
          Color.lerp(continuousForeground, other.continuousForeground, t) ??
          continuousForeground,
      discreteBackground:
          Color.lerp(discreteBackground, other.discreteBackground, t) ??
          discreteBackground,
      discreteForeground:
          Color.lerp(discreteForeground, other.discreteForeground, t) ??
          discreteForeground,
    );
  }
}
