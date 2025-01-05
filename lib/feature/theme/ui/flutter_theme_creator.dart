import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/colors_schemes.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';

class FlutterThemeCreator {
  late ThemeData _themeData;

  ThemeData createFlutterTheme(AppTheme appTheme) {
    _themeData =
        appTheme.themeMode == AppThemeMode.light
            ? FlexThemeData.light(colorScheme: lightColorSchemes[appTheme.colorScheme])
            : FlexThemeData.dark(colorScheme: darkColorSchemes[appTheme.colorScheme]);
    _setUpTextStyle();
    return _themeData;
  }

  void _setUpTextStyle() {
    final textColor = _themeData.colorScheme.onSurface;
    final textTheme = TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 57,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 45,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
    _themeData = _themeData.copyWith(textTheme: textTheme);
  }
}
