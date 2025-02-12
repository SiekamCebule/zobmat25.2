import 'package:flutter/cupertino.dart';
import 'package:zobmat25_2/feature/theme/ui/accessibility_theme_creator.dart';

enum AppThemeMode {
  light,
  dark;

  Brightness toFlutterBrightness() {
    return this == AppThemeMode.light ? Brightness.light : Brightness.dark;
  }

  AccessibilityThemeCreatorBrightness toAccessibilityCreatorBrightness() {
    return this == AppThemeMode.light ? AccessibilityThemeCreatorBrightness.light : AccessibilityThemeCreatorBrightness.dark;
  }

  AppThemeMode toggled() {
    return this == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;
  }
}
