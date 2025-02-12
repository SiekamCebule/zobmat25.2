import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_accessibility_mode.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';
import 'package:zobmat25_2/feature/theme/domain/repositories/theme_repository.dart';

class CachedThemeRepository implements ThemeRepository {
  const CachedThemeRepository({
    required this.preferences,
    required this.defaultThemeMode,
    required this.defaultColorScheme,
    required this.defaultAccessibilityMode,
  });

  final SharedPreferences preferences;
  final AppThemeMode defaultThemeMode;
  final AppColorScheme defaultColorScheme;
  final AppAccessibilityMode defaultAccessibilityMode;

  @override
  Future<AppThemeMode> getThemeMode() async {
    final themeModeString = preferences.getString('themeMode');
    final themeMode = AppThemeMode.values.singleWhereOrNull(
      (mode) => mode.name == themeModeString,
    );
    return themeMode ?? defaultThemeMode;
  }

  @override
  Future<AppColorScheme> getColorScheme() async {
    final colorSchemeString = preferences.getString('colorScheme');
    final colorScheme = AppColorScheme.values.singleWhereOrNull(
      (mode) => mode.name == colorSchemeString,
    );
    return colorScheme ?? defaultColorScheme;
  }

  @override
  Future<AppAccessibilityMode> getAccessibilityMode() async {
    final accessibilityModeString = preferences.getString('accessibilityMode');
    final accessibilityMode = AppAccessibilityMode.values
        .singleWhereOrNull((mode) => mode.name == accessibilityModeString);
    return accessibilityMode ?? defaultAccessibilityMode;
  }

  @override
  Future<void> setThemeMode(AppThemeMode mode) async {
    preferences.setString('themeMode', mode.name);
  }

  @override
  Future<void> setColorScheme(AppColorScheme scheme) async {
    preferences.setString('colorScheme', scheme.name);
  }

  @override
  Future<void> setAccessibilityMode(AppAccessibilityMode mode) async {
    preferences.setString('accessibilityMode', mode.name);
  }
}
