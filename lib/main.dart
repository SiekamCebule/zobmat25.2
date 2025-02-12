import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zobmat25_2/config/distribution_description_text_components_rendering_params.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/data/repository/in_memory_distribution_dashboard_repository.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/continuous_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/discrete_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_knowledge_view_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/change_continuous_distribution_chart_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/change_discrete_distribution_chart_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/change_distribution_analysis_parameter_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/change_distribution_knowledge_view_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/change_distribution_parameter_in_setup_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/clear_distribution_analysis_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/draw_numbers_by_distribution_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_continuous_distribution_chart_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_discrete_distribution_chart_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_distribution_analysis_setup_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_distribution_analysis_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_distribution_knowledge_view_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_distribution_params_setup_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_selected_distribution_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/initialize_distribution_analysis_setup_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/toggle_distribution_selection_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/update_distribution_analysis_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/predefined_distribution_functions_data_source.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/predefined_distributions_data_source.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/repository/in_memory_distribution_filters_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/repository/predefined_distributions_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_filter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/use_case/get_all_distributions_use_case.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/use_case/get_distribution_filters_use_case.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/use_case/get_filtered_distributions_use_case.dart';
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
import 'package:zobmat25_2/feature/theme/data/repository/cached_theme_repository.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_accessibility_mode.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';
import 'package:zobmat25_2/feature/theme/domain/use_cases/change_app_color_scheme_use_case.dart';
import 'package:zobmat25_2/feature/theme/domain/use_cases/get_app_theme_use_case.dart';
import 'package:zobmat25_2/feature/theme/domain/use_cases/toggle_app_accessibility_mode.dart';
import 'package:zobmat25_2/feature/theme/domain/use_cases/toggle_theme_mode_use_case.dart';
import 'package:zobmat25_2/feature/theme/ui/bloc/theme_cubit.dart';
import 'package:zobmat25_2/feature/theme/ui/flutter_theme_creator.dart';

void main() async {
  final themeRepository = CachedThemeRepository(
      preferences: await SharedPreferences.getInstance(),
      defaultColorScheme: AppColorScheme.green,
      defaultThemeMode: AppThemeMode.dark,
      defaultAccessibilityMode: AppAccessibilityMode.off);
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(
        getAppThemeUseCase: GetAppThemeUseCase(themeRepository: themeRepository),
        toggleThemeModeUseCase: ToggleThemeModeUseCase(
          themeRepository: themeRepository,
        ),
        changeAppColorSchemeUseCase: ChangeAppColorSchemeUseCase(
          themeRepository: themeRepository,
        ),
        toggleAppAccessibilityModeUseCase:
            ToggleAppAccessibilityMode(themeRepository: themeRepository),
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
    final distributionDashboard = InMemoryDistributionDashboardRepository(
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
            create: (context) => NavigationCubit(
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
            create: (context) => DistributionsCatalogueCubit(
              getAllDistributionsUseCase: GetAllDistributionsUseCase(
                distributionsRepository: distributionsRepository,
              ),
              getFilteredDistributionsUseCase: GetFilteredDistributionsUseCase(
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
            create: (context) => DistributionDashboardCubit(
              getSelectedDistributionUseCase: GetSelectedDistributionUseCase(
                distributionDashboard: distributionDashboard,
              ),
              toggleDistributionSelectionUseCase: ToggleDistributionSelectionUseCase(
                distributionDashboard: distributionDashboard,
              ),
              getContinuousDistributionChartTypeUseCase:
                  GetContinuousDistributionChartTypeUseCase(
                distributionDashboard: distributionDashboard,
              ),
              changeContinuousDistributionChartTypeUseCase:
                  ChangeContinuousDistributionChartTypeUseCase(
                distributionDashboard: distributionDashboard,
              ),
              getDiscreteDistributionChartTypeUseCase:
                  GetDiscreteDistributionChartTypeUseCase(
                distributionDashboard: distributionDashboard,
              ),
              changeDiscreteDistributionChartTypeUseCase:
                  ChangeDiscreteDistributionChartTypeUseCase(
                distributionDashboard: distributionDashboard,
              ),
              getDistributionKnowledgeViewTypeUseCase:
                  GetDistributionKnowledgeViewTypeUseCase(
                distributionDashboard: distributionDashboard,
              ),
              changeDistributionKnowledgeViewTypeUseCase:
                  ChangeDistributionKnowledgeViewTypeUseCase(
                distributionDashboard: distributionDashboard,
              ),
              getDistributionParamsSetupUseCase: GetDistributionParamsSetupUseCase(
                distributionDashboard: distributionDashboard,
              ),
              changeDistributionParameterInSetupUseCase:
                  ChangeDistributionParameterInSetupUseCase(
                distributionDashboard: distributionDashboard,
              ),
              initializeDistributionAnalysisSetupUseCase:
                  InitializeDistributionAnalysisSetupUseCase(
                distributionDashboard: distributionDashboard,
              ),
              getDistributionAnalysisSetupUseCase: GetDistributionAnalysisSetupUseCase(
                distributionDashboard: distributionDashboard,
              ),
              drawNumbersByDistributionUseCase: DrawNumbersByDistributionUseCase(
                distributionDashboard: distributionDashboard,
              ),
              clearDistributionAnalysisUseCase: ClearDistributionAnalysisUseCase(
                distributionDashboard: distributionDashboard,
              ),
              getDistributionAnalysisUseCase: GetDistributionAnalysisUseCase(
                distributionDashboard: distributionDashboard,
              ),
              changeDistributionAnalysisParameterUseCase:
                  ChangeDistributionAnalysisParameterUseCase(
                distributionDashboard: distributionDashboard,
              ),
              updateDistributionAnalysisUseCase: UpdateDistributionAnalysisUseCase(
                distributionDashboard: distributionDashboard,
              ),
            )..initialize(),
          ),
        ],
        child: MultiProvider(providers: [
          ProxyProvider<ThemeCubit, DistributionDescriptionTextComponentsRenderingParams>(
            lazy: false,
            update: (context, themeCubit, renderingParams) {
              late double textScaleFactor;
              final themeState = themeCubit.state;
              if (themeState is ThemeInitial) {
                textScaleFactor = 1.0;
              } else if (themeState is ThemeAvaiable) {
                if (themeState.theme.accessibilityMode == AppAccessibilityMode.on) {
                  textScaleFactor = 1.2;
                } else {
                  textScaleFactor = 1.0;
                }
              }
              return DistributionDescriptionTextComponentsRenderingParams(
                  textScaleFactor: textScaleFactor);
            },
          ),
        ], child: DynamicPage()),
      ),
    );
  }
}
