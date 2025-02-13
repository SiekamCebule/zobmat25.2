import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/distribution_chip_colors.dart';
import 'package:zobmat25_2/feature/theme/ui/my_app_flex_theme_config.dart';

AppFlexThemeConfig lightBlueTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
    colors: const FlexSchemeColor(
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
      cardElevation: 2,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      inputDecoratorRadius: 6,
      filledButtonRadius: 12,
      inputDecoratorBorderSchemeColor: SchemeColor.primary,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHighest,
      inputDecoratorFocusedBorderWidth: 0.75,
      inputDecoratorBorderWidth: 0.75,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(useSecondary: true, useTertiary: true),
    schemeVariant: FlexSchemeVariant.rainbow,
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(211, 233, 224, 1),
      continuousForeground: Color.fromRGBO(25, 53, 42, 1),
      discreteBackground: Color.fromRGBO(228, 235, 219, 1),
      discreteForeground: Color.fromRGBO(42, 48, 29, 1),
    ),
  );
}

AppFlexThemeConfig darkBlueTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
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
      cardElevation: 2,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
      inputDecoratorRadius: 6,
      filledButtonRadius: 12,
      inputDecoratorBorderSchemeColor: SchemeColor.primary,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHighest,
      inputDecoratorFocusedBorderWidth: 0.75,
      inputDecoratorBorderWidth: 0.75,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(useSecondary: true, useTertiary: true),
    schemeVariant: FlexSchemeVariant.rainbow,
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(25, 53, 42, 1),
      continuousForeground: Color.fromRGBO(211, 233, 224, 1),
      discreteBackground: Color.fromRGBO(42, 48, 29, 1),
      discreteForeground: Color.fromRGBO(228, 235, 219, 1),
    ),
  );
}
