import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';
import 'package:zobmat25_2/feature/theme/domain/repositories/theme_repository.dart';

class InMemoryThemeRepository implements ThemeRepository {
  InMemoryThemeRepository({
    required AppColorScheme initialColorScheme,
    required AppThemeMode initialThemeMode,
  }) : _colorScheme = initialColorScheme,
       _themeMode = initialThemeMode;

  AppColorScheme _colorScheme;
  AppThemeMode _themeMode;

  @override
  Future<AppColorScheme> getColorScheme() async {
    return _colorScheme;
  }

  @override
  Future<void> setColorScheme(AppColorScheme scheme) async {
    _colorScheme = scheme;
  }

  @override
  Future<void> setThemeMode(AppThemeMode mode) async {
    _themeMode = mode;
  }

  @override
  Future<AppThemeMode> getThemeMode() async {
    return _themeMode;
  }
}
