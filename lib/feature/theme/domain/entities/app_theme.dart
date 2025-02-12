import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_accessibility_mode.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';

class AppTheme extends Equatable {
  const AppTheme({required this.colorScheme, required this.themeMode, required this.accessibilityMode});

  final AppColorScheme colorScheme;
  final AppThemeMode themeMode;
  final AppAccessibilityMode accessibilityMode;

  @override
  List<Object?> get props => [colorScheme, themeMode, accessibilityMode];
}
