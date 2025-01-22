import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/data/repository/in_memory_distribution_dashboard_repository.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/continuous_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/discrete_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_knowledge_view_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/change_continuous_distribution_chart_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/change_discrete_distribution_chart_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/change_distribution_knowledge_view_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/change_distribution_parameter_in_setup_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/draw_numbers_by_distribution_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_continuous_distribution_chart_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_discrete_distribution_chart_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_distribution_analysis_setup_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_distribution_knowledge_view_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_distribution_params_setup_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_selected_distribution_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/toggle_distribution_selection_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/predefined_distribution_functions_data_source.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/predefined_distributions_data_source.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/repository/in_memory_distribution_filters_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/repository/predefined_distributions_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_filter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/use_case/get_distribution_filters_use_case.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/use_case/get_distributions_use_case.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/use_case/toggle_distributions_filter_use_case.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/bloc/distributions_catalogue_cubit.dart';
import 'package:zobmat25_2/feature/navigation/data/data_source/in_memory_navigation_data_source.dart';
import 'package:zobmat25_2/feature/navigation/data/repositories/in_memory_navigation_repository.dart';
import 'package:zobmat25_2/feature/navigation/domain/entity/navigation_entry.dart';
import 'package:zobmat25_2/feature/navigation/domain/use_case/get_navigation_entry_use_case.dart';
import 'package:zobmat25_2/feature/navigation/domain/use_case/go_to_navigation_entry_index_use_case.dart';
import 'package:zobmat25_2/feature/navigation/domain/use_case/go_to_navigation_entry_use_case.dart';
import 'package:zobmat25_2/feature/navigation/ui/bloc/navigation_cubit.dart';
import 'package:zobmat25_2/feature/navigation/ui/page/dynamic_page.dart';
import 'package:zobmat25_2/feature/theme/data/repository/in_memory_theme_repository.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';
import 'package:zobmat25_2/feature/theme/domain/use_cases/get_app_theme_use_case.dart';
import 'package:zobmat25_2/feature/theme/domain/use_cases/toggle_theme_mode_use_case.dart';
import 'package:zobmat25_2/feature/theme/ui/bloc/theme_cubit.dart';
import 'package:zobmat25_2/feature/theme/ui/flutter_theme_creator.dart';

void main() {
  final themeRepository = InMemoryThemeRepository(
    initialColorScheme: AppColorScheme.blueDefault,
    initialThemeMode: AppThemeMode.dark,
  );
  runApp(
    BlocProvider(
      create:
          (context) => ThemeCubit(
            getAppThemeUseCase: GetAppThemeUseCase(themeRepository: themeRepository),
            toggleThemeModeUseCase: ToggleThemeModeUseCase(
              themeRepository: themeRepository,
            ),
          )..initialize(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const isRunningWithWasm = bool.fromEnvironment('dart.tool.dart2wasm');
    debugPrint('App uses WebAssembly: $isRunningWithWasm');
    final themeState = context.watch<ThemeCubit>().state;
    late final ThemeData flutterTheme;
    if (themeState is ThemeInitial) {
      flutterTheme = ThemeData.light(useMaterial3: true);
    } else if (themeState is ThemeAvaiable) {
      flutterTheme = FlutterThemeCreator().createFlutterTheme(themeState.theme);
    }
    final navigationRepository = InMemoryNavigationRepository(
      dataSource: InMemoryNavigationDataSourceImpl(initial: NavigationEntry.home),
    );
    final distributionsRepository = PredefinedDistributionsRepository(
      distributionsDataSource: PredefinedDistributionsDataSourceImpl(),
      mathFunctionsDataSource: PredefinedDistributionFunctionsDataSourceImpl(),
    );
    final distributionFiltersRepository = InMemoryDistributionFiltersRepository(
      initialFilters: {DistributionFilter.continuous, DistributionFilter.discrete},
    );
    final distributionDashboardRepository = InMemoryDistributionDashboardRepository(
      initialDistribution: null,
      initialContinuousChartType: ContinuousDistributionChartType.pdf,
      initialDiscreteChartType: DiscreteDistributionChartType.pmf,
      initialKnowledgeViewType: DistributionKnowledgeViewType.description,
      initialParamsSetup: null,
      initialAnalysisSetup: null,
    );
    return MaterialApp(
      theme: flutterTheme,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => NavigationCubit(
                  goToNavigationEntryUseCase: GoToNavigationEntryUseCase(
                    navigationRepository: navigationRepository,
                  ),
                  goToNavigationEntryIndexUseCase: GoToNavigationEntryIndexUseCase(
                    navigationRepository: navigationRepository,
                  ),
                  getNavigationEntryUseCase: GetNavigationEntryUseCase(
                    navigationRepository: navigationRepository,
                  ),
                )..initialize(),
          ),
          BlocProvider(
            create:
                (context) => DistributionsCatalogueCubit(
                  getDistributionsUseCase: GetDistributionsUseCase(
                    distributionsRepository: distributionsRepository,
                    distributionFiltersRepository: distributionFiltersRepository,
                  ),
                  getDistributionFiltersUseCase: GetDistributionFiltersUseCase(
                    distributionFiltersRepository: distributionFiltersRepository,
                  ),
                  toggleDistributionsFilterUseCase: ToggleDistributionsFilterUseCase(
                    distributionsRepository: distributionsRepository,
                    distributionFiltersRepository: distributionFiltersRepository,
                  ),
                )..initialize(),
          ),
          BlocProvider(
            create:
                (context) => DistributionDashboardCubit(
                  getSelectedDistributionUseCase: GetSelectedDistributionUseCase(
                    distributionDashboardRepository: distributionDashboardRepository,
                  ),
                  toggleDistributionSelectionUseCase: ToggleDistributionSelectionUseCase(
                    distributionDashboardRepository: distributionDashboardRepository,
                  ),
                  getContinuousDistributionChartTypeUseCase:
                      GetContinuousDistributionChartTypeUseCase(
                        distributionDashboardRepository: distributionDashboardRepository,
                      ),
                  changeContinuousDistributionChartTypeUseCase:
                      ChangeContinuousDistributionChartTypeUseCase(
                        distributionDashboardRepository: distributionDashboardRepository,
                      ),
                  getDiscreteDistributionChartTypeUseCase:
                      GetDiscreteDistributionChartTypeUseCase(
                        distributionDashboardRepository: distributionDashboardRepository,
                      ),
                  changeDiscreteDistributionChartTypeUseCase:
                      ChangeDiscreteDistributionChartTypeUseCase(
                        distributionDashboardRepository: distributionDashboardRepository,
                      ),
                  getDistributionKnowledgeViewTypeUseCase:
                      GetDistributionKnowledgeViewTypeUseCase(
                        distributionDashboardRepository: distributionDashboardRepository,
                      ),
                  changeDistributionKnowledgeViewTypeUseCase:
                      ChangeDistributionKnowledgeViewTypeUseCase(
                        distributionDashboardRepository: distributionDashboardRepository,
                      ),
                  getDistributionParamsSetupUseCase: GetDistributionParamsSetupUseCase(
                    distributionDashboardRepository: distributionDashboardRepository,
                  ),
                  changeDistributionParameterInSetupUseCase:
                      ChangeDistributionParameterInSetupUseCase(
                        distributionDashboardRepository: distributionDashboardRepository,
                      ),
                  getDistributionAnalysisSetupUseCase:
                      GetDistributionAnalysisSetupUseCase(
                        distributionDashboardRepository: distributionDashboardRepository,
                      ),
                  drawNumbersByDistributionUseCase: DrawNumbersByDistributionUseCase(
                    distributionDashboardRepository: distributionDashboardRepository,
                  ),
                )..initialize(),
          ),
        ],
        child: DynamicPage(),
      ),
    );
  }
}
