import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/distribution_chip_colors.dart';

class AppFlexThemeConfig {
  const AppFlexThemeConfig({
    required this.colors,
    this.surfaceMode,
    this.blendLevel,
    this.usedColors,
    required this.textTheme,
    required this.keyColors,
    required this.subThemesData,
    this.defaultFlexTones,
    required this.chipColors,
    this.lightIsWhite,
    this.schemeVariant,
  });

  final FlexSchemeColor colors;
  final FlexSurfaceMode? surfaceMode;
  final int? blendLevel;
  final int? usedColors;
  final TextTheme textTheme;
  final FlexKeyColors keyColors;
  final FlexSubThemesData subThemesData;
  final FlexTones? defaultFlexTones;
  final DistributionChipColors chipColors;
  final bool? lightIsWhite;
  final FlexSchemeVariant? schemeVariant;
}
