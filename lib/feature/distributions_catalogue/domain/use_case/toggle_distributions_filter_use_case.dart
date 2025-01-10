import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_filter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/repository/distribution_filters_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/repository/distributions_repository.dart';

class ToggleDistributionsFilterUseCase {
  const ToggleDistributionsFilterUseCase({
    required this.distributionsRepository,
    required this.distributionFiltersRepository,
  });

  final DistributionsRepository distributionsRepository;
  final DistributionFiltersRepository distributionFiltersRepository;

  Future<void> call(DistributionFilter filter) async {
    final isActive = await distributionFiltersRepository.isActive(filter);
    await distributionFiltersRepository.setFilter(filter, !isActive);
  }
}
