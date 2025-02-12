import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_accessibility_mode.dart';
import 'package:zobmat25_2/feature/theme/ui/my_app_flex_theme_config.dart';

enum AccessibilityThemeCreatorBrightness {
  light,
  dark;

  Brightness toFlutterBrightness() {
    return this == AccessibilityThemeCreatorBrightness.light
        ? Brightness.light
        : Brightness.dark;
  }
}

class AccessibilityFlexThemeCreator {
  ThemeData create({
    required AccessibilityThemeCreatorBrightness brightness,
    required AppAccessibilityMode accessibilityMode,
    required AppFlexThemeConfig flexThemeConfig,
  }) {
    const defaultUsedColors = 6; // default calue is 6
    final accessibilityOn = accessibilityMode == AppAccessibilityMode.on ? true : false;
    var themeData = brightness == AccessibilityThemeCreatorBrightness.light
        ? FlexThemeData.light(
            colors: flexThemeConfig.colors,
            surfaceMode:
                accessibilityOn ? FlexSurfaceMode.level : flexThemeConfig.surfaceMode,
            usedColors: flexThemeConfig.usedColors ?? defaultUsedColors,
            textTheme: accessibilityOn
                ? flexThemeConfig.textTheme.apply(fontSizeFactor: 1.2)
                : flexThemeConfig.textTheme,
            subThemesData: accessibilityOn
                ? flexThemeConfig.subThemesData.copyWith(
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
                  )
                : flexThemeConfig.subThemesData,
            visualDensity: accessibilityOn
                ? VisualDensity.standard
                : FlexColorScheme.comfortablePlatformDensity,
            keyColors: flexThemeConfig.keyColors,
            tones: accessibilityOn
                ? (flexThemeConfig.schemeVariant == null
                    ? FlexTones.ultraContrast(brightness.toFlutterBrightness())
                    : null)
                : flexThemeConfig.defaultFlexTones,
            extensions: [
              flexThemeConfig.chipColors,
            ],
            variant: flexThemeConfig.schemeVariant,
            cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
          )
        : FlexThemeData.dark(
            colors: flexThemeConfig.colors,
            surfaceMode:
                accessibilityOn ? FlexSurfaceMode.level : flexThemeConfig.surfaceMode,
            usedColors: flexThemeConfig.usedColors ?? defaultUsedColors,
            textTheme: accessibilityOn
                ? flexThemeConfig.textTheme.apply(fontSizeFactor: 1.2)
                : flexThemeConfig.textTheme,
            subThemesData: accessibilityOn
                ? flexThemeConfig.subThemesData.copyWith(
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
                  )
                : flexThemeConfig.subThemesData,
            keyColors: flexThemeConfig.keyColors,
            visualDensity: accessibilityOn
                ? VisualDensity.standard
                : FlexColorScheme.comfortablePlatformDensity,
            tones: accessibilityOn
                ? FlexTones.ultraContrast(brightness.toFlutterBrightness())
                : flexThemeConfig.defaultFlexTones,
            extensions: [
              flexThemeConfig.chipColors,
            ],
            cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
          );

    themeData = themeData.copyWith(
        iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(iconSize: accessibilityOn ? 28 : null)));
    return themeData;
  }
}
