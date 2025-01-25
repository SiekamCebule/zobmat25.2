import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightYellowTheme({required TextTheme textTheme}) {
  return FlexThemeData.light(
    colors: const FlexSchemeColor(
      // Custom colors
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
    ),
    keyColors: const FlexKeyColors(useExpressiveOnContainerColors: false),
    tones: FlexSchemeVariant.soft
        .tones(Brightness.light)
        .copyWith(secondaryContainerTone: 94),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

ThemeData darkYellowTheme({required TextTheme textTheme}) {
  return FlexThemeData.dark(
    colors: const FlexSchemeColor(
      // Custom colors
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
    blendLevel: 15,
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
    ),
    keyColors: const FlexKeyColors(),
    tones: FlexSchemeVariant.soft.tones(Brightness.dark),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
