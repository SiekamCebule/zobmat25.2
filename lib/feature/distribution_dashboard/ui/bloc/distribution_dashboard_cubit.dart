// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/change_distribution_chart_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/change_distribution_parameter_in_setup_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/draw_numbers_by_distribution_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_distribution_analysis_setup_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_distribution_chart_type_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_distribution_params_setup_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_selected_distribution_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/toggle_distribution_selection_use_case.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

class DistributionDashboardCubit extends Cubit<DistributionDashboardState> {
  DistributionDashboardCubit({
    required this.getSelectedDistributionUseCase,
    required this.toggleDistributionSelectionUseCase,
    required this.getDistributionChartTypeUseCase,
    required this.changeDistributionChartTypeUseCase,
    required this.getDistributionParamsSetupUseCase,
    required this.changeDistributionParameterInSetupUseCase,
    required this.getDistributionAnalysisSetupUseCase,
    required this.drawNumbersByDistributionUseCase,
  }) : super(DistributionDashboardInitial());

  final GetSelectedDistributionUseCase getSelectedDistributionUseCase;
  final ToggleDistributionSelectionUseCase toggleDistributionSelectionUseCase;

  final GetDistributionChartTypeUseCase getDistributionChartTypeUseCase;
  final ChangeDistributionChartTypeUseCase changeDistributionChartTypeUseCase;

  final GetDistributionParamsSetupUseCase getDistributionParamsSetupUseCase;
  final ChangeDistributionParameterInSetupUseCase
  changeDistributionParameterInSetupUseCase;

  final GetDistributionAnalysisSetupUseCase getDistributionAnalysisSetupUseCase;

  final DrawNumbersByDistributionUseCase drawNumbersByDistributionUseCase;

  Future<void> initialize() async {
    emit(DistributionDashboardNoDistribution());
  }

  Future<void> toggleDistributionSelection(Distribution distribution) async {
    await toggleDistributionSelectionUseCase(distribution);
    final newSelected = await getSelectedDistributionUseCase();
    if (newSelected == null) {
      emit(DistributionDashboardNoDistribution());
    } else {
      emit(
        DistributionDashboardDistributionSelected(
          distribution: newSelected,
          chartType: await getDistributionChartTypeUseCase(),
          paramsSetup: (await getDistributionParamsSetupUseCase())!,
          analysisSetup: await getDistributionAnalysisSetupUseCase(),
        ),
      );
    }
  }

  Future<void> changeChart(DistributionChartType chartType) async {
    final state = this.state;

    if (state is! DistributionDashboardDistributionSelected) {
      throw StateError('Cannot change the chart when no distribution is selected');
    }
    await changeDistributionChartTypeUseCase(chartType);
    emit(state.copyWith(chartType: await getDistributionChartTypeUseCase()));
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
    emit(state.copyWith(paramsSetup: await getDistributionParamsSetupUseCase()));
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
    required this.chartType,
    required this.paramsSetup,
    required this.analysisSetup,
    this.drawedNumbers,
  });

  final Distribution distribution;
  final DistributionChartType chartType;
  final DistributionParamsSetup paramsSetup;
  final DistributionAnalysisSetup? analysisSetup;
  final List<num>? drawedNumbers;

  @override
  List<Object?> get props => [
    distribution,
    chartType,
    paramsSetup,
    analysisSetup,
    drawedNumbers,
  ];

  DistributionDashboardDistributionSelected copyWith({
    Distribution? distribution,
    DistributionChartType? chartType,
    DistributionParamsSetup? paramsSetup,
    DistributionAnalysisSetup? analysisSetup,
    List<num>? drawedNumbers,
  }) {
    return DistributionDashboardDistributionSelected(
      distribution: distribution ?? this.distribution,
      chartType: chartType ?? this.chartType,
      paramsSetup: paramsSetup ?? this.paramsSetup,
      analysisSetup: analysisSetup ?? this.analysisSetup,
      drawedNumbers: drawedNumbers ?? this.drawedNumbers,
    );
  }
}
