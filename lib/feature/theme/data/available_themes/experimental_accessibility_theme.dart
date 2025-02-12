import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/distribution_chip_colors.dart';

ThemeData experimentalAccessibilityTheme({required TextTheme textTheme}) {
  return FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color(0xFF87521A),
      primaryContainer: Color(0xFFFFE6C2),
      primaryLightRef: Color(0xFF87521A),
      secondary: Color(0xFF625B71),
      secondaryContainer: Color(0xFF0A15FF),
      secondaryLightRef: Color(0xFF625B71),
      tertiary: Color(0xFF624F00),
      tertiaryContainer: Color(0xFFFFD8E4),
      tertiaryLightRef: Color(0xFF624F00),
      appBarColor: Color(0xFF0A15FF),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
    ),
    surfaceMode: FlexSurfaceMode.level,
    blendLevel: 0,
    usedColors: 7,
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      cardElevation: 2,
      thinBorderWidth: 3,
      thickBorderWidth: 5,
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      fabRadius: 0,
      cardRadius: 0,
      chipRadius: 0,
      menuRadius: 0,
      dialogRadius: 0,
      defaultRadius: 0,
      textButtonRadius: 0,
      filledButtonRadius: 0,
      elevatedButtonRadius: 0,
      outlinedButtonRadius: 0,
      toggleButtonsRadius: 0,
      segmentedButtonRadius: 0,
      searchBarRadius: 0,
      inputDecoratorRadius: 0,
      defaultRadiusAdaptive: 0,
      menuBarRadius: 0,
      tooltipRadius: 0,
      inputDecoratorRadiusAdaptive: 0,
      navigationRailIndicatorRadius: 0,
      navigationBarIndicatorRadius: 0,
      tabBarIndicatorTopRadius: 0,
      drawerIndicatorRadius: 0,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerLowest,
      inputDecoratorFocusedBorderWidth: 2,
      inputDecoratorBorderWidth: 2,
      inputCursorSchemeColor: SchemeColor.primary,
    ),
    keyColors: const FlexKeyColors(
      useTertiary: true,
      useExpressiveOnContainerColors: false,
    ),
    tones: FlexSchemeVariant.ultraContrast.tones(Brightness.light),
    visualDensity: VisualDensity.standard,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    extensions: [
      DistributionChipColors(
        continuousBackground: Color.fromRGBO(238, 237, 210, 1),
        continuousForeground: Color.fromRGBO(53, 50, 25, 1),
        discreteBackground: Color.fromRGBO(220, 238, 210, 1),
        discreteForeground: Color.fromRGBO(32, 53, 25, 1),
      ),
    ],
  );
}

/*ThemeData darkOrangeTheme({required TextTheme textTheme}) {
  return FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color(0xFFD0BCFF),
      primaryContainer: Color(0xFF4F378B),
      primaryLightRef: Color(0xFF87521A),
      secondary: Color(0xFFCCC2DC),
      secondaryContainer: Color(0xFF4A4458),
      secondaryLightRef: Color(0xFF625B71),
      tertiary: Color(0xFFEFB8C8),
      tertiaryContainer: Color(0xFF633B48),
      tertiaryLightRef: Color(0xFF624F00),
      appBarColor: Color(0xFF0A15FF),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
    ),
    usedColors: 7,
    surfaceMode: FlexSurfaceMode.level,
    blendLevel: 0,
    textTheme: textTheme,
    subThemesData: const FlexSubThemesData(
      cardElevation: 1.0,
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      inputDecoratorRadius: 10,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHigh,
      inputDecoratorFocusedBorderWidth: 0.5,
      inputDecoratorBorderWidth: 0.5,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(useTertiary: true),
    tones: FlexSchemeVariant.material
        .tones(Brightness.dark)
        .copyWith(primaryContainerTone: 22),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    extensions: [
      DistributionChipColors(
        continuousBackground: Color.fromRGBO(53, 26, 25, 1),
        continuousForeground: Color.fromRGBO(233, 214, 211, 1),
        discreteBackground: Color.fromRGBO(48, 46, 29, 1),
        discreteForeground: Color.fromRGBO(235, 233, 219, 1),
      ),
    ],
  );
}*/
