import 'package:zobmat25_2/feature/theme/domain/entities/app_theme.dart';
import 'package:zobmat25_2/feature/theme/domain/repositories/theme_repository.dart';

class GetAppThemeUseCase {
  const GetAppThemeUseCase({required this.themeRepository});

  final ThemeRepository themeRepository;

  Future<AppTheme> call() async {
    return AppTheme(
      colorScheme: await themeRepository.getColorScheme(),
      themeMode: await themeRepository.getThemeMode(),
    );
  }
}
