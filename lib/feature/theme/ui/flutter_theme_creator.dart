import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/blue_theme.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/experimental_accessibility_theme.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/green_theme.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/purple_theme.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/orange_theme.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/monochrome_theme.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/yellow_theme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_accessibility_mode.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';
import 'package:zobmat25_2/feature/theme/ui/accessibility_theme_creator.dart';

class FlutterThemeCreator {
  late ThemeData _themeData;
  late AppTheme _appTheme;

  ThemeData createFlutterTheme(AppTheme appTheme) {
    _appTheme = appTheme;
    final textTheme = _getTextTheme();

    return AccessibilityFlexThemeCreator().create(
        brightness: appTheme.themeMode.toAccessibilityCreatorBrightness(),
        accessibilityMode: appTheme.accessibilityMode,
        flexThemeConfig: switch(appTheme.themeMode) {
          AppThemeMode.light => switch(appTheme.colorScheme) {
            AppColorScheme.orange => lightOrangeTheme(textTheme: textTheme),
            _ => throw UnimplementedError(),
          },
          _ => throw UnimplementedError(), 
        });
    if (appTheme.accessibilityMode == AppAccessibilityMode.on) {
      return experimentalAccessibilityTheme(textTheme: textTheme);
    } else if (appTheme.themeMode == AppThemeMode.light) {
      _themeData = switch (appTheme.colorScheme) {
        AppColorScheme.orange => lightOrangeTheme(textTheme: textTheme),
        AppColorScheme.green => lightGreenTheme(textTheme: textTheme),
        AppColorScheme.purple => lightPurpleTheme(textTheme: textTheme),
        AppColorScheme.blue => lightBlueTheme(textTheme: textTheme),
        AppColorScheme.yellow => lightYellowTheme(textTheme: textTheme),
        AppColorScheme.monochrome => lightMonochromeTheme(textTheme: textTheme),
      };
    } else {
      _themeData = switch (appTheme.colorScheme) {
        AppColorScheme.orange => darkOrangeTheme(textTheme: textTheme),
        AppColorScheme.green => darkGreenTheme(textTheme: textTheme),
        AppColorScheme.purple => darkPurpleTheme(textTheme: textTheme),
        AppColorScheme.blue => darkBlueTheme(textTheme: textTheme),
        AppColorScheme.yellow => darkYellowTheme(textTheme: textTheme),
        AppColorScheme.monochrome => darkMonochromeTheme(textTheme: textTheme),
      };
    }
    return _themeData;
  }

  /*TextTheme _getPoppinsTextTheme() {
    const fontFamily = 'Poppins';
    final textColor = null;
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: textColor,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }*/

  TextTheme _getRalewayTextTheme() {
    const fontFamily = 'Raleway';
    final textColor = null;
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }

  TextTheme _getTextTheme() {
    var textTheme = _getRalewayTextTheme();
    if (_appTheme.accessibilityMode == AppAccessibilityMode.on) {
      textTheme = textTheme.apply(fontSizeFactor: 1.2);
    }
    return textTheme;
    // return _getPoppinsTextTheme();
  }
}
