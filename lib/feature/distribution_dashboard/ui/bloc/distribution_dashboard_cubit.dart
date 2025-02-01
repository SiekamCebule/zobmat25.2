import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/distribution_analysis.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_component.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_parameter.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_parameter_value.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/continuous_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/discrete_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_knowledge_view_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
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
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';

class DistributionDashboardCubit extends Cubit<DistributionDashboardState> {
  DistributionDashboardCubit({
    required this.getSelectedDistributionUseCase,
    required this.toggleDistributionSelectionUseCase,
    required this.getContinuousDistributionChartTypeUseCase,
    required this.changeContinuousDistributionChartTypeUseCase,
    required this.getDiscreteDistributionChartTypeUseCase,
    required this.changeDiscreteDistributionChartTypeUseCase,
    required this.getDistributionKnowledgeViewTypeUseCase,
    required this.changeDistributionKnowledgeViewTypeUseCase,
    required this.getDistributionParamsSetupUseCase,
    required this.changeDistributionParameterInSetupUseCase,
    required this.initializeDistributionAnalysisSetupUseCase,
    required this.getDistributionAnalysisSetupUseCase,
    required this.drawNumbersByDistributionUseCase,
    required this.clearDistributionAnalysisUseCase,
    required this.getDistributionAnalysisUseCase,
    required this.changeDistributionAnalysisParameterUseCase,
    required this.updateDistributionAnalysisUseCase,
  }) : super(DistributionDashboardInitial());

  final GetSelectedDistributionUseCase getSelectedDistributionUseCase;
  final ToggleDistributionSelectionUseCase toggleDistributionSelectionUseCase;

  final GetContinuousDistributionChartTypeUseCase
  getContinuousDistributionChartTypeUseCase;
  final ChangeContinuousDistributionChartTypeUseCase
  changeContinuousDistributionChartTypeUseCase;
  final GetDiscreteDistributionChartTypeUseCase getDiscreteDistributionChartTypeUseCase;
  final ChangeDiscreteDistributionChartTypeUseCase
  changeDiscreteDistributionChartTypeUseCase;

  final GetDistributionKnowledgeViewTypeUseCase getDistributionKnowledgeViewTypeUseCase;
  final ChangeDistributionKnowledgeViewTypeUseCase
  changeDistributionKnowledgeViewTypeUseCase;

  final GetDistributionParamsSetupUseCase getDistributionParamsSetupUseCase;
  final ChangeDistributionParameterInSetupUseCase
  changeDistributionParameterInSetupUseCase;

  final InitializeDistributionAnalysisSetupUseCase
  initializeDistributionAnalysisSetupUseCase;
  final GetDistributionAnalysisSetupUseCase getDistributionAnalysisSetupUseCase;

  final DrawNumbersByDistributionUseCase drawNumbersByDistributionUseCase;

  final ClearDistributionAnalysisUseCase clearDistributionAnalysisUseCase;
  final GetDistributionAnalysisUseCase getDistributionAnalysisUseCase;
  final ChangeDistributionAnalysisParameterUseCase
  changeDistributionAnalysisParameterUseCase;
  final UpdateDistributionAnalysisUseCase updateDistributionAnalysisUseCase;

  Distribution? _lastSelectedDistribution;

  Future<void> initialize() async {
    emit(DistributionDashboardNoDistribution());
  }

  Future<void> toggleDistributionSelection(Distribution distribution) async {
    await toggleDistributionSelectionUseCase(distribution);
    final newSelected = await getSelectedDistributionUseCase();

    if (newSelected == null) {
      await clearDistributionAnalysisUseCase();
      _lastSelectedDistribution = newSelected;
      emit(DistributionDashboardNoDistribution());
    } else {
      if (_lastSelectedDistribution.runtimeType != newSelected.runtimeType) {
        await initializeDistributionAnalysisSetupUseCase();
      }
      await updateDistributionAnalysisUseCase();
      _lastSelectedDistribution = newSelected;
      final analysisSetup = await getDistributionAnalysisSetupUseCase();
      emit(
        DistributionDashboardDistributionSelected(
          distribution: newSelected,
          continuousChartType: await getContinuousDistributionChartTypeUseCase(),
          discreteChartType: await getDiscreteDistributionChartTypeUseCase(),
          knowledgeViewType: await getDistributionKnowledgeViewTypeUseCase(),
          paramsSetup: (await getDistributionParamsSetupUseCase())!,
          analysisSetup: await getDistributionAnalysisSetupUseCase(),
          analysisComponent:
              analysisSetup is ContinuousDistributionAnalysisSetup
                  ? DistributionAnalysisPredefinedComponents.continuousVariableBelonging
                  : DistributionAnalysisPredefinedComponents.discreteVariableBelonging,
          analysis: await getDistributionAnalysisUseCase(),
        ),
      );
    }
  }

  Future<void> changeContinuousDistributionChart(
    ContinuousDistributionChartType chartType,
  ) async {
    final state = this.state;

    if (state is! DistributionDashboardDistributionSelected) {
      throw StateError(
        'Cannot change the continuous distribution chart when no distribution is selected',
      );
    }
    await changeContinuousDistributionChartTypeUseCase(chartType);
    emit(
      state.copyWith(
        continuousChartType: await getContinuousDistributionChartTypeUseCase(),
      ),
    );
  }

  Future<void> changeDiscreteDistributionChart(
    DiscreteDistributionChartType chartType,
  ) async {
    final state = this.state;

    if (state is! DistributionDashboardDistributionSelected) {
      throw StateError(
        'Cannot change the discrete distribution chart when no distribution is selected',
      );
    }
    await changeDiscreteDistributionChartTypeUseCase(chartType);
    emit(
      state.copyWith(discreteChartType: await getDiscreteDistributionChartTypeUseCase()),
    );
  }

  Future<void> changeKnowledgeViewType(
    DistributionKnowledgeViewType knowledgeViewType,
  ) async {
    final state = this.state;
    if (state is! DistributionDashboardDistributionSelected) {
      throw StateError(
        'Cannot change the distribution knowledge type when no distribution is selected',
      );
    }
    await changeDistributionKnowledgeViewTypeUseCase(knowledgeViewType);
    emit(
      state.copyWith(knowledgeViewType: await getDistributionKnowledgeViewTypeUseCase()),
    );
  }

  Future<void> changeParameter(
    DistributionParameter parameter, {
    required num value,
  }) async {
    final state = this.state;
    if (state is! DistributionDashboardDistributionSelected) {
      throw StateError('Cannot change the parameter when no distribution is selected');
    }
    await changeDistributionParameterInSetupUseCase(parameter, value: value);
    await updateDistributionAnalysisUseCase();
    final analysis = await getDistributionAnalysisUseCase();
    emit(
      state.copyWith(
        paramsSetup: await getDistributionParamsSetupUseCase(),
        analysis: analysis,
      ),
    );
  }

  Future<void> drawNumbers() async {
    final state = this.state;
    if (state is! DistributionDashboardDistributionSelected) {
      throw StateError('Cannot draw numbers when no distribution is selected');
    }
    emit(
      state.copyWith(drawedNumbers: await drawNumbersByDistributionUseCase(count: 10)),
    );
  }

  Future<void> initializeAnalysis() async {
    final state = this.state;
    if (state is! DistributionDashboardDistributionSelected) {
      throw StateError('Cannot initialize the analysis when no distribution is selected');
    }
    await initializeDistributionAnalysisSetupUseCase();
    await updateDistributionAnalysisUseCase();
    final analysisSetup = await getDistributionAnalysisSetupUseCase();
    final analysis = await getDistributionAnalysisUseCase();
    emit(
      DistributionDashboardDistributionSelected(
        distribution: state.distribution,
        continuousChartType: state.continuousChartType,
        discreteChartType: state.discreteChartType,
        knowledgeViewType: state.knowledgeViewType,
        paramsSetup: state.paramsSetup,
        analysisComponent:
            analysisSetup is ContinuousDistributionAnalysisSetup
                ? DistributionAnalysisPredefinedComponents.continuousVariableBelonging
                : DistributionAnalysisPredefinedComponents.discreteVariableBelonging,
        analysisSetup: analysisSetup,
        drawedNumbers: state.drawedNumbers,
        analysis: analysis,
      ),
    );
  }

  Future<void> clearAnalysis() async {
    final state = this.state;
    if (state is! DistributionDashboardDistributionSelected) {
      throw StateError('Cannot initialize the analysis when no distribution is selected');
    }
    await clearDistributionAnalysisUseCase();
    final analysis = await getDistributionAnalysisUseCase();
    emit(
      DistributionDashboardDistributionSelected(
        distribution: state.distribution,
        continuousChartType: state.continuousChartType,
        discreteChartType: state.discreteChartType,
        knowledgeViewType: state.knowledgeViewType,
        paramsSetup: state.paramsSetup,
        analysisComponent: state.analysisComponent,
        analysisSetup: state.analysisSetup,
        drawedNumbers: state.drawedNumbers,
        analysis: analysis,
      ),
    );
  }

  Future<void> changeAnalysisParameter({
    required DistributionAnalysisComponent component,
    required DistributionAnalysisParameter parameter,
    required DistributionAnalysisParameterValue value,
  }) async {
    final state = this.state;
    if (state is! DistributionDashboardDistributionSelected) {
      throw StateError(
        'Cannot change an analysis parameter when no distribution is selected',
      );
    }
    await changeDistributionAnalysisParameterUseCase(
      component: component,
      parameter: parameter,
      value: value,
    );
    await updateDistributionAnalysisUseCase();
    final analysisSetup = await getDistributionAnalysisSetupUseCase();
    final analysis = await getDistributionAnalysisUseCase();
    emit(
      DistributionDashboardDistributionSelected(
        distribution: state.distribution,
        continuousChartType: state.continuousChartType,
        discreteChartType: state.discreteChartType,
        knowledgeViewType: state.knowledgeViewType,
        paramsSetup: state.paramsSetup,
        analysisComponent: state.analysisComponent,
        analysisSetup: analysisSetup,
        drawedNumbers: state.drawedNumbers,
        analysis: analysis,
      ),
    );
  }

  Future<void> changeAnalysisComponent({
    required DistributionAnalysisComponent component,
  }) async {
    final state = this.state;
    if (state is! DistributionDashboardDistributionSelected) {
      throw StateError(
        'Cannot change an analysis component when no distribution is selected',
      );
    }
    await updateDistributionAnalysisUseCase();
    emit(
      DistributionDashboardDistributionSelected(
        distribution: state.distribution,
        continuousChartType: state.continuousChartType,
        discreteChartType: state.discreteChartType,
        knowledgeViewType: state.knowledgeViewType,
        paramsSetup: state.paramsSetup,
        analysisComponent: component,
        analysisSetup: state.analysisSetup,
        drawedNumbers: state.drawedNumbers,
        analysis: await getDistributionAnalysisUseCase(),
      ),
    );
  }
}

abstract class DistributionDashboardState extends Equatable {
  const DistributionDashboardState();
}

class DistributionDashboardInitial extends DistributionDashboardState {
  const DistributionDashboardInitial();

  @override
  List<Object?> get props => [];
}

class DistributionDashboardNoDistribution extends DistributionDashboardState {
  const DistributionDashboardNoDistribution();

  @override
  List<Object?> get props => [];
}

class DistributionDashboardDistributionSelected extends DistributionDashboardState {
  const DistributionDashboardDistributionSelected({
    required this.distribution,
    required this.continuousChartType,
    required this.discreteChartType,
    required this.knowledgeViewType,
    required this.paramsSetup,
    this.drawedNumbers,
    this.analysisComponent,
    required this.analysisSetup,
    this.analysis,
  });

  final Distribution distribution;
  final ContinuousDistributionChartType continuousChartType;
  final DiscreteDistributionChartType discreteChartType;
  final DistributionKnowledgeViewType knowledgeViewType;
  final DistributionParamsSetup paramsSetup;
  final List<num>? drawedNumbers;
  final DistributionAnalysisComponent? analysisComponent;
  final DistributionAnalysisSetup? analysisSetup;
  final DistributionAnalysis? analysis;

  @override
  List<Object?> get props => [
    distribution,
    continuousChartType,
    discreteChartType,
    knowledgeViewType,
    paramsSetup,
    drawedNumbers,
    analysisComponent,
    analysisSetup,
    analysis,
  ];

  DistributionDashboardDistributionSelected copyWith({
    Distribution? distribution,
    ContinuousDistributionChartType? continuousChartType,
    DiscreteDistributionChartType? discreteChartType,
    DistributionKnowledgeViewType? knowledgeViewType,
    DistributionParamsSetup? paramsSetup,
    List<num>? drawedNumbers,
    DistributionAnalysisComponent? analysisComponent,
    DistributionAnalysisSetup? analysisSetup,
    DistributionAnalysis? analysis,
  }) {
    return DistributionDashboardDistributionSelected(
      distribution: distribution ?? this.distribution,
      continuousChartType: continuousChartType ?? this.continuousChartType,
      discreteChartType: discreteChartType ?? this.discreteChartType,
      knowledgeViewType: knowledgeViewType ?? this.knowledgeViewType,
      paramsSetup: paramsSetup ?? this.paramsSetup,
      drawedNumbers: drawedNumbers ?? this.drawedNumbers,
      analysisComponent: analysisComponent ?? this.analysisComponent,
      analysisSetup: analysisSetup ?? this.analysisSetup,
      analysis: analysis ?? this.analysis,
    );
  }
}
