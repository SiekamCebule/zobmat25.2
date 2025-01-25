import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

ThemeData lightMonochromeTheme({required TextTheme textTheme}) {
  return FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: Color(0xFF00296B),
      primaryContainer: Color(0xFFDFDFDF),
      primaryLightRef: Color(0xFF00296B),
      secondary: Color(0xFF404040),
      secondaryContainer: Color(0xFFFFD270),
      secondaryLightRef: Color(0xFF404040),
      tertiary: Color(0xFF5C5C95),
      tertiaryContainer: Color(0xFFC8DBF8),
      tertiaryLightRef: Color(0xFF5C5C95),
      appBarColor: Color(0xFFFFD270),
      error: Color(0xFF000000),
      errorContainer: Color(0xFFFFDAD6),
    ),
    lightIsWhite: true,
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      scaffoldBackgroundBaseColor: FlexScaffoldBaseColor.lowestBase,
      useM2StyleDividerInM3: true,

      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      defaultRadius: 6.0,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      useError: true,
      keepSecondary: true,
      keepPrimaryContainer: true,
    ),
    variant: FlexSchemeVariant.monochrome,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}

ThemeData darkMonochromeTheme({required TextTheme textTheme}) {
  return FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color(0xFFB1CFF5),
      primaryContainer: Color(0xFF3B3B3B),
      primaryLightRef: Color(0xFF00296B),
      secondary: Color(0xFFCECECE),
      secondaryContainer: Color(0xFFD26900),
      secondaryLightRef: Color(0xFF404040),
      tertiary: Color(0xFFE2E2E2),
      tertiaryContainer: Color(0xFF666666),
      tertiaryLightRef: Color(0xFF5C5C95),
      appBarColor: Color(0xFFFFD270),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
    ),
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
      defaultRadius: 6.0,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      useError: true,
      keepSecondary: true,
      keepPrimaryContainer: true,
      keepTertiaryContainer: true,
    ),
    variant: FlexSchemeVariant.monochrome,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
  );
}
