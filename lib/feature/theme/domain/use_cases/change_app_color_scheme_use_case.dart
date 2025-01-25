import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/repositories/theme_repository.dart';

class ChangeAppColorSchemeUseCase {
  const ChangeAppColorSchemeUseCase({required this.themeRepository});

  final ThemeRepository themeRepository;

  Future<void> call(AppColorScheme colorScheme) async {
    await themeRepository.setColorScheme(colorScheme);
  }
}
