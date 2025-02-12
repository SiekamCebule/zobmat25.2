import 'package:equatable/equatable.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/distribution_chip_colors.dart';

class AppFlexThemeConfig with EquatableMixin {
  const AppFlexThemeConfig({
    required this.colors,
    required this.surfaceMode,
    required this.blendLevel,
    required this.usedColors,
    required this.textTheme,
    required this.keyColors,
    required this.subThemesData,
    required this.defaultFlexTones,
    required this.chipColors,
  });

  final FlexSchemeColor colors;
  final FlexSurfaceMode surfaceMode;
  final int blendLevel;
  final int usedColors;
  final TextTheme textTheme;
  final FlexKeyColors keyColors;
  final FlexSubThemesData subThemesData;
  final FlexTones defaultFlexTones;
  final DistributionChipColors chipColors;

  @override
  List<Object?> get props => [
        colors,
        surfaceMode,
        usedColors,
        textTheme,
        keyColors,
        subThemesData,
        defaultFlexTones,
        chipColors,
      ];
}
