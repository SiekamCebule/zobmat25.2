import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/repository/distribution_filters_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/repository/distributions_repository.dart';

class GetDistributionsUseCase {
  const GetDistributionsUseCase({
    required this.distributionsRepository,
    required this.distributionFiltersRepository,
  });

  final DistributionsRepository distributionsRepository;
  final DistributionFiltersRepository distributionFiltersRepository;

  Future<List<Distribution>> call() async {
    final filters = await distributionFiltersRepository.getAllFilters();
    final distributions = await distributionsRepository.getAllDistributions();
    return distributions
        .where((distribution) => filters.contains(distribution.type.toFilter()))
        .toList();
  }
}
