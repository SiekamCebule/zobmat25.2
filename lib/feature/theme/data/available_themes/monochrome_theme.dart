import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

import 'package:zobmat25_2/feature/theme/domain/entities/distribution_chip_colors.dart';
import 'package:zobmat25_2/feature/theme/ui/my_app_flex_theme_config.dart';

AppFlexThemeConfig lightMonochromeTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
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
      navigationRailIndicatorRadius: 12,
      inputDecoratorRadius: 6,
      filledButtonRadius: 5,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHighest,
      inputDecoratorFocusedBorderWidth: 0.75,
      inputDecoratorBorderWidth: 0.75,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      useError: true,
      keepSecondary: true,
      keepPrimaryContainer: true,
    ),
    schemeVariant: FlexSchemeVariant.monochrome,
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(242, 242, 242, 1),
      continuousForeground: Color.fromRGBO(41, 43, 42, 1),
      discreteBackground: Color.fromRGBO(242, 242, 242, 1),
      discreteForeground: Color.fromRGBO(41, 43, 42, 1),
    ),
  );
}

AppFlexThemeConfig darkMonochromeTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
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
      navigationRailIndicatorRadius: 12,
      inputDecoratorRadius: 6,
      filledButtonRadius: 5,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHighest,
      inputDecoratorFocusedBorderWidth: 0.75,
      inputDecoratorBorderWidth: 0.75,
      inputCursorSchemeColor: SchemeColor.onSecondary,
    ),
    keyColors: const FlexKeyColors(
      useSecondary: true,
      useTertiary: true,
      useError: true,
      keepSecondary: true,
      keepPrimaryContainer: true,
      keepTertiaryContainer: true,
    ),
    schemeVariant: FlexSchemeVariant.monochrome,
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(41, 43, 42, 1),
      continuousForeground: Color.fromRGBO(242, 242, 242, 1),
      discreteBackground: Color.fromRGBO(41, 43, 42, 1),
      discreteForeground: Color.fromRGBO(242, 242, 242, 1),
    ),
  );
}
