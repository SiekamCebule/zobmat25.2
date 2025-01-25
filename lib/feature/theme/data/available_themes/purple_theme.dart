import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

ThemeData lightPurpleTheme() {
  return FlexThemeData.light(
    colors: const FlexSchemeColor(
      // Custom colors
      primary: Color(0xFF9784E1),
      primaryContainer: Color(0xFFFFD8E8),
      primaryLightRef: Color(0xFF9784E1),
      secondary: Color(0xFF625B71),
      secondaryContainer: Color(0xFF0A15FF),
      secondaryLightRef: Color(0xFF625B71),
      tertiary: Color(0xFFFF0035),
      tertiaryContainer: Color(0xFFFFD8E4),
      tertiaryLightRef: Color(0xFFFF0035),
      appBarColor: Color(0xFF0A15FF),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
    ),
    usedColors: 7,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      defaultRadius: 20,
      cardElevation: 0,
    ),
    keyColors: const FlexKeyColors(),
    tones: FlexSchemeVariant.material
        .tones(Brightness.light)
        .copyWith(primaryContainerTone: 90),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

ThemeData darkPurpleTheme() {
  return FlexThemeData.dark(
    colors: const FlexSchemeColor(
      // Custom colors
      primary: Color(0xFFA6D395),
      primaryContainer: Color(0xFF203D19),
      primaryLightRef: Color(0xFF9784E1),
      secondary: Color(0xFFCCC2DC),
      secondaryContainer: Color(0xFF4A4458),
      secondaryLightRef: Color(0xFF625B71),
      tertiary: Color(0xFFF1BB98),
      tertiaryContainer: Color(0xFF633B48),
      tertiaryLightRef: Color(0xFFFF0035),
      appBarColor: Color(0xFF0A15FF),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
    ),
    usedColors: 7,
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
      defaultRadius: 20,
      cardElevation: 0,
    ),
    keyColors: const FlexKeyColors(),
    tones: FlexSchemeVariant.material
        .tones(Brightness.dark)
        .copyWith(primaryContainerTone: 21),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
