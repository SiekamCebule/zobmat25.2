import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_filter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/use_case/get_all_distributions_use_case.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/use_case/get_distribution_filters_use_case.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/use_case/get_filtered_distributions_use_case.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/use_case/toggle_distributions_filter_use_case.dart';

class DistributionsCatalogueCubit extends Cubit<DistributionsCatalogueState> {
  DistributionsCatalogueCubit({
    required this.getAllDistributionsUseCase,
    required this.getFilteredDistributionsUseCase,
    required this.getDistributionFiltersUseCase,
    required this.toggleDistributionsFilterUseCase,
  }) : super(DistributionsCatalogueInitial());

  final GetAllDistributionsUseCase getAllDistributionsUseCase;
  final GetFilteredDistributionsUseCase getFilteredDistributionsUseCase;
  final GetDistributionFiltersUseCase getDistributionFiltersUseCase;
  final ToggleDistributionsFilterUseCase toggleDistributionsFilterUseCase;

  Future<void> initialize() async {
    final filters = await getDistributionFiltersUseCase();
    emit(
      DistributionsCatalogueAvailable(
        filters: filters,
        filteredDistributions: await getFilteredDistributionsUseCase(),
        allDistributions: await getAllDistributionsUseCase(),
      ),
    );
  }

  Future<void> toggleFilter(DistributionFilter type) async {
    await toggleDistributionsFilterUseCase(type);
    emit(
      DistributionsCatalogueAvailable(
        filters: await getDistributionFiltersUseCase(),
        filteredDistributions: await getFilteredDistributionsUseCase(),
        allDistributions: await getAllDistributionsUseCase(),
      ),
    );
  }
}

abstract class DistributionsCatalogueState extends Equatable {
  const DistributionsCatalogueState();
}

class DistributionsCatalogueInitial extends DistributionsCatalogueState {
  const DistributionsCatalogueInitial();

  @override
  List<Object?> get props => [];
}

class DistributionsCatalogueAvailable extends DistributionsCatalogueState {
  const DistributionsCatalogueAvailable({
    required this.filters,
    required this.filteredDistributions,
    required this.allDistributions,
  });

  final Set<DistributionFilter> filters;
  final List<Distribution> filteredDistributions;
  final List<Distribution> allDistributions;

  @override
  List<Object?> get props => [filters, filteredDistributions, allDistributions];
}
