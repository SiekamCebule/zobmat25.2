import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/distribution_chip_colors.dart';
import 'package:zobmat25_2/feature/theme/ui/my_app_flex_theme_config.dart';

AppFlexThemeConfig lightOrangeTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
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
    blendLevel: 1,
    usedColors: 7,
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
      filledButtonRadius: 16,
      inputDecoratorRadius: 10,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHigh,
      inputDecoratorFocusedBorderWidth: 0.5,
      inputDecoratorBorderWidth: 0.5,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(
      useTertiary: true,
      useExpressiveOnContainerColors: false,
    ),
    defaultFlexTones: FlexSchemeVariant.material.tones(Brightness.light),
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(238, 237, 210, 1),
      continuousForeground: Color.fromRGBO(53, 50, 25, 1),
      discreteBackground: Color.fromRGBO(220, 238, 210, 1),
      discreteForeground: Color.fromRGBO(32, 53, 25, 1),
    ),
  );
}

AppFlexThemeConfig darkOrangeTheme({required TextTheme textTheme}) {
  return AppFlexThemeConfig(
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
      filledButtonRadius: 16,
      inputDecoratorRadius: 10,
      inputDecoratorBorderSchemeColor: SchemeColor.onSurfaceVariant,
      inputDecoratorSchemeColor: SchemeColor.surfaceContainerHigh,
      inputDecoratorFocusedBorderWidth: 0.5,
      inputDecoratorBorderWidth: 0.5,
      inputCursorSchemeColor: SchemeColor.secondary,
    ),
    keyColors: const FlexKeyColors(useTertiary: true),
    defaultFlexTones: FlexSchemeVariant.material
        .tones(Brightness.dark)
        .copyWith(primaryContainerTone: 22),
    chipColors: DistributionChipColors(
      continuousBackground: Color.fromRGBO(53, 26, 25, 1),
      continuousForeground: Color.fromRGBO(233, 214, 211, 1),
      discreteBackground: Color.fromRGBO(48, 46, 29, 1),
      discreteForeground: Color.fromRGBO(235, 233, 219, 1),
    ),
  );
}
