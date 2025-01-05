import 'package:flutter/cupertino.dart';

enum AppThemeMode {
  light,
  dark;

  Brightness toFlutterBrightness() {
    return this == AppThemeMode.light ? Brightness.light : Brightness.dark;
  }

  AppThemeMode toggled() {
    return this == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;
  }
}
