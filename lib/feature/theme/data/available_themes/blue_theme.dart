import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightBlueTheme({required TextTheme textTheme}) {
  return FlexThemeData.light(
    colors: const FlexSchemeColor(
      // Custom colors
      primary: Color(0xFF2A5EA7),
      primaryContainer: Color(0xFF2A5EA7),
      primaryLightRef: Color(0xFF2A5EA7),
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
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 8.0,
      cardElevation: 2.5,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    keyColors: const FlexKeyColors(useSecondary: true, useTertiary: true),
    variant: FlexSchemeVariant.rainbow,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

ThemeData darkBlueTheme({required TextTheme textTheme}) {
  return FlexThemeData.dark(
    colors: const FlexSchemeColor(
      // Custom colors
      primary: Color(0xFF2A5EA7),
      primaryContainer: Color(0xFF203D19),
      primaryLightRef: Color(0xFF2A5EA7),
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
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      defaultRadius: 8.0,
      cardElevation: 2.5,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    keyColors: const FlexKeyColors(useSecondary: true, useTertiary: true),
    variant: FlexSchemeVariant.rainbow,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
