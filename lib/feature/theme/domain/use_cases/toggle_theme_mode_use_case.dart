import 'package:zobmat25_2/feature/theme/domain/repositories/theme_repository.dart';

class ToggleThemeModeUseCase {
  const ToggleThemeModeUseCase({required this.themeRepository});

  final ThemeRepository themeRepository;

  Future<void> call() async {
    final mode = await themeRepository.getThemeMode();
    await themeRepository.setThemeMode(mode.toggled());
  }
}
