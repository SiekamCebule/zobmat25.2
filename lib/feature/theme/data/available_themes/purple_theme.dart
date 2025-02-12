import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/distribution_chip_colors.dart';
import 'package:zobmat25_2/feature/theme/ui/my_app_flex_theme_config.dart';

AppFlexThemeConfig lightPurpleTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
    colors: const FlexSchemeColor(
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
      defaultRadius: 22,
      filledButtonRadius: 50,
      cardElevation: 0,
      inputDecoratorRadius: 14,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHigh,
      inputDecoratorFocusedBorderWidth: 0.5,
      inputDecoratorBorderWidth: 0.5,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(),
    defaultFlexTones: FlexSchemeVariant.material
        .tones(Brightness.light)
        .copyWith(primaryContainerTone: 90),
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(211, 224, 233, 1),
      continuousForeground: Color.fromRGBO(25, 40, 53, 1),
      discreteBackground: Color.fromRGBO(219, 235, 220, 1),
      discreteForeground: Color.fromRGBO(29, 48, 30, 1),
    ),
  );
}

AppFlexThemeConfig darkPurpleTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
    colors: const FlexSchemeColor(
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
      defaultRadius: 22,
      filledButtonRadius: 50,
      cardElevation: 0,
      inputDecoratorRadius: 14,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHigh,
      inputDecoratorFocusedBorderWidth: 0.5,
      inputDecoratorBorderWidth: 0.5,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(),
    defaultFlexTones: FlexSchemeVariant.material
        .tones(Brightness.dark)
        .copyWith(primaryContainerTone: 21),
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(25, 40, 53, 1),
      continuousForeground: Color.fromRGBO(211, 224, 233, 1),
      discreteBackground: Color.fromRGBO(29, 48, 30, 1),
      discreteForeground: Color.fromRGBO(219, 235, 220, 1),
    ),
  );
}
