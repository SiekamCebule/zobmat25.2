import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme.dart';
import 'package:zobmat25_2/feature/theme/domain/use_cases/get_app_theme_use_case.dart';
import 'package:zobmat25_2/feature/theme/domain/use_cases/toggle_theme_mode_use_case.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required this.getAppThemeUseCase, required this.toggleThemeModeUseCase})
    : super(const ThemeInitial());

  final GetAppThemeUseCase getAppThemeUseCase;
  final ToggleThemeModeUseCase toggleThemeModeUseCase;

  Future<void> initialize() async {
    emit(ThemeAvaiable(await getAppThemeUseCase()));
  }

  void toggleThemeMode() async {
    await toggleThemeModeUseCase();
    emit(ThemeAvaiable(await getAppThemeUseCase()));
  }
}

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  const ThemeInitial();

  @override
  List<Object?> get props => [];
}

class ThemeAvaiable extends ThemeState {
  const ThemeAvaiable(this.theme);

  final AppTheme theme;

  @override
  List<Object?> get props => [theme];
}
