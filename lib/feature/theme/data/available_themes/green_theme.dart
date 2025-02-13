import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/distribution_chip_colors.dart';
import 'package:zobmat25_2/feature/theme/ui/my_app_flex_theme_config.dart';

AppFlexThemeConfig lightGreenTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
    colors: const FlexSchemeColor(
      primary: Color(0xFF406835),
      primaryContainer: Color(0xFFC5FEB2),
      primaryLightRef: Color(0xFF406835),
      secondary: Color(0xFF625B71),
      secondaryContainer: Color(0xFF0A15FF),
      secondaryLightRef: Color(0xFF625B71),
      tertiary: Color(0xFF757E38),
      tertiaryContainer: Color(0xFFFFD8E4),
      tertiaryLightRef: Color(0xFF757E38),
      appBarColor: Color(0xFF0A15FF),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
    ),
    usedColors: 7,
    surfaceMode: FlexSurfaceMode.level,
    blendLevel: 25,
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      cardElevation: 1,
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      inputDecoratorRadius: 8,
      filledButtonRadius: 15,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHigh,
      inputDecoratorFocusedBorderWidth: 0.35,
      inputDecoratorBorderWidth: 0.35,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(
      useTertiary: true,
      keepPrimaryContainer: true,
      useExpressiveOnContainerColors: false,
    ),
    defaultFlexTones: FlexSchemeVariant.material.tones(Brightness.light),
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(232, 233, 211, 1),
      continuousForeground: Color.fromRGBO(53, 53, 25, 1),
      discreteBackground: Color.fromRGBO(219, 235, 234, 1),
      discreteForeground: Color.fromRGBO(29, 48, 45, 1),
    ),
  );
}

AppFlexThemeConfig darkGreenTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
    colors: const FlexSchemeColor(
      primary: Color(0xFFD0BCFF),
      primaryContainer: Color(0xFF1A3214),
      primaryLightRef: Color(0xFF406835),
      secondary: Color(0xFFCCC2DC),
      secondaryContainer: Color(0xFF4A4458),
      secondaryLightRef: Color(0xFF625B71),
      tertiary: Color(0xFFF1BB98),
      tertiaryContainer: Color(0xFF633B48),
      tertiaryLightRef: Color(0xFF757E38),
      appBarColor: Color(0xFF0A15FF),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
    ),
    surfaceMode: FlexSurfaceMode.level,
    blendLevel: 15,
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      cardElevation: 1,
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      inputDecoratorRadius: 8,
      filledButtonRadius: 15,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHigh,
      inputDecoratorFocusedBorderWidth: 0.35,
      inputDecoratorBorderWidth: 0.35,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(useTertiary: true, keepPrimaryContainer: true),
    defaultFlexTones: FlexSchemeVariant.material.tones(Brightness.dark),
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(53, 53, 25, 1),
      continuousForeground: Color.fromRGBO(232, 233, 211, 1),
      discreteBackground: Color.fromRGBO(29, 48, 45, 1),
      discreteForeground: Color.fromRGBO(219, 235, 234, 1),
    ),
  );
}
