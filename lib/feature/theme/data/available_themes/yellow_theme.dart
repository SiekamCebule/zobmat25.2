import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/distribution_chip_colors.dart';
import 'package:zobmat25_2/feature/theme/ui/my_app_flex_theme_config.dart';

AppFlexThemeConfig lightYellowTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
    colors: const FlexSchemeColor(
      primary: Color(0xFF626100),
      primaryContainer: Color(0xFF2A5EA7),
      primaryLightRef: Color(0xFF626100),
      secondary: Color(0xFF005BFF),
      secondaryContainer: Color(0xFF0A15FF),
      secondaryLightRef: Color(0xFF005BFF),
      tertiary: Color(0xFF50817F),
      tertiaryContainer: Color(0xFFFFD8E4),
      tertiaryLightRef: Color(0xFF50817F),
      appBarColor: Color(0xFF0A15FF),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
    ),
    surfaceMode: FlexSurfaceMode.level,
    blendLevel: 35,
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      cardElevation: 0,
      inputDecoratorRadius: 8,
      filledButtonRadius: 11,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHigh,
      inputDecoratorFocusedBorderWidth: 0.1,
      inputDecoratorBorderWidth: 0.1,
      inputDecoratorFocusedHasBorder: true,
      inputDecoratorUnfocusedHasBorder: true,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(useExpressiveOnContainerColors: false),
    defaultFlexTones: FlexSchemeVariant.soft
        .tones(Brightness.light)
        .copyWith(secondaryContainerTone: 94),
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(245, 224, 209, 1),
      continuousForeground: Color.fromRGBO(53, 43, 25, 1),
      discreteBackground: Color.fromRGBO(222, 241, 227, 1),
      discreteForeground: Color.fromRGBO(29, 48, 33, 1),
    ),
  );
}

AppFlexThemeConfig darkYellowTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
    colors: const FlexSchemeColor(
      primary: Color(0xFFCDCC56),
      primaryContainer: Color(0xFF203D19),
      primaryLightRef: Color(0xFF626100),
      secondary: Color(0xFF595E72),
      secondaryContainer: Color(0xFF4A4458),
      secondaryLightRef: Color(0xFF005BFF),
      tertiary: Color(0xFF386664),
      tertiaryContainer: Color(0xFF000000),
      tertiaryLightRef: Color(0xFF50817F),
      appBarColor: Color(0xFF0A15FF),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
    ),
    surfaceMode: FlexSurfaceMode.level,
    blendLevel: 10,
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      cardElevation: 0,
      inputDecoratorRadius: 8,
      filledButtonRadius: 11,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHigh,
      inputDecoratorFocusedBorderWidth: 0.1,
      inputDecoratorBorderWidth: 0.1,
      inputDecoratorFocusedHasBorder: true,
      inputDecoratorUnfocusedHasBorder: true,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(),
    defaultFlexTones: FlexSchemeVariant.soft.tones(Brightness.dark),
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(53, 43, 25, 1),
      continuousForeground: Color.fromRGBO(245, 224, 209, 1),
      discreteForeground: Color.fromRGBO(222, 241, 227, 1),
      discreteBackground: Color.fromRGBO(29, 48, 33, 1),
    ),
  );
}
