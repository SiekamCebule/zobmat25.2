import 'package:zobmat25_2/feature/theme/domain/entities/app_accessibility_mode.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';

abstract interface class ThemeRepository {
  Future<void> setThemeMode(AppThemeMode mode);
  Future<AppThemeMode> getThemeMode();

  Future<void> setColorScheme(AppColorScheme scheme);
  Future<AppColorScheme> getColorScheme();

  Future<void> setAccessibilityMode(AppAccessibilityMode mode);
  Future<AppAccessibilityMode> getAccessibilityMode();
}
