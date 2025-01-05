import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';

final lightColorSchemes = {
  AppColorScheme.blueDefault: SeedColorScheme.fromSeeds(
    brightness: Brightness.light,
    primaryKey: Color.fromRGBO(55, 135, 211, 1),
    secondaryKey: Color.fromRGBO(188, 102, 238, 1),
    tertiaryKey: Color.fromRGBO(119, 127, 134, 1),
    tones: FlexTones.material(Brightness.light).copyWith(neutralChroma: 4),
  ),
};

final darkColorSchemes = {
  AppColorScheme.blueDefault: SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    primaryKey: Color.fromRGBO(55, 135, 211, 1),
    secondaryKey: Color.fromRGBO(188, 102, 238, 1),
    tertiaryKey: Color.fromRGBO(126, 154, 180, 1),
    tones: FlexTones.material(Brightness.dark).copyWith(neutralChroma: 4),
  ),
};
