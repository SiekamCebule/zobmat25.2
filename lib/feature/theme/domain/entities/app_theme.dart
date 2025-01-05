import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';

class AppTheme extends Equatable {
  const AppTheme({required this.colorScheme, required this.themeMode});

  final AppColorScheme colorScheme;
  final AppThemeMode themeMode;

  @override
  List<Object?> get props => [colorScheme, themeMode];
}
