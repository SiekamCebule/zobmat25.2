import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';
import 'package:zobmat25_2/feature/theme/domain/repositories/theme_repository.dart';

class CachedThemeRepository implements ThemeRepository {
  const CachedThemeRepository({
    required this.preferences,
    required this.defaultThemeMode,
    required this.defaultColorScheme,
  });

  final SharedPreferences preferences;
  final AppThemeMode defaultThemeMode;
  final AppColorScheme defaultColorScheme;

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
  Future<void> setThemeMode(AppThemeMode mode) async {
    preferences.setString('themeMode', mode.name);
  }

  @override
  Future<void> setColorScheme(AppColorScheme scheme) async {
    preferences.setString('colorScheme', scheme.name);
  }
}
