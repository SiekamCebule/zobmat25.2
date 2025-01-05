import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/get_selected_distribution_use_case.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/use_case/toggle_distribution_selection_use_case.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';

class DistributionDashboardCubit extends Cubit<DistributionDashboardState> {
  DistributionDashboardCubit({
    required this.getSelectedDistributionUseCase,
    required this.toggleDistributionSelectionUseCase,
  }) : super(DistributionDashboardInitial());

  final GetSelectedDistributionUseCase getSelectedDistributionUseCase;
  final ToggleDistributionSelectionUseCase toggleDistributionSelectionUseCase;

  Future<void> initialize() async {
    emit(DistributionDashboardNoDistribution());
  }

  Future<void> toggleDistributionSelection(Distribution distribution) async {
    await toggleDistributionSelectionUseCase(distribution);
    final newSelected = await getSelectedDistributionUseCase();
    if (newSelected == null) {
      emit(DistributionDashboardNoDistribution());
    } else {
      emit(DistributionDashboardDistributionSelected(distribution: newSelected));
    }
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
  const DistributionDashboardDistributionSelected({required this.distribution});

  final Distribution distribution;

  @override
  List<Object?> get props => [distribution];
}
