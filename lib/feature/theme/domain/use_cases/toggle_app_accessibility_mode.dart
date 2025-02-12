import 'package:zobmat25_2/feature/theme/domain/repositories/theme_repository.dart';

class ToggleAppAccessibilityMode {
  const ToggleAppAccessibilityMode({required this.themeRepository});

  final ThemeRepository themeRepository;

  Future<void> call() async {
    final mode = await themeRepository.getAccessibilityMode();
    await themeRepository.setAccessibilityMode(mode.toggled());
  }
}
