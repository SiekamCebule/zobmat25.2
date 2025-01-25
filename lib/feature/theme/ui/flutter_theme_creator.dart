import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/green_theme.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/purple_theme.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/orange_theme.dart';
import 'package:zobmat25_2/feature/theme/data/available_themes/monochrome_theme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';

class FlutterThemeCreator {
  late ThemeData _themeData;

  ThemeData createFlutterTheme(AppTheme appTheme) {
    if (appTheme.themeMode == AppThemeMode.light) {
      _themeData = switch (appTheme.colorScheme) {
        AppColorScheme.orange => lightOrangeTheme(),
        AppColorScheme.green => lightGreenTheme(),
        AppColorScheme.purple => lightPurpleTheme(),
        AppColorScheme.monochrome => lightMonochromeTheme(),
        _ => throw UnimplementedError(),
      };
    } else {
      _themeData = switch (appTheme.colorScheme) {
        AppColorScheme.orange => darkOrangeTheme(),
        AppColorScheme.green => darkGreenTheme(),
        AppColorScheme.purple => darkPurpleTheme(),
        AppColorScheme.monochrome => darkMonochromeTheme(),
        _ => throw UnimplementedError(),
      };
    }
    return _themeData.copyWith(textTheme: _getTextTheme());
  }

  TextTheme _getTextTheme() {
    const fontFamily = 'Raleway';
    final textColor = _themeData.colorScheme.onSurface;
    //final textColor = null;
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
}
