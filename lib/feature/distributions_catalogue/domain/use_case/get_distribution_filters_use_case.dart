import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_filter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/repository/distribution_filters_repository.dart';

class GetDistributionFiltersUseCase {
  const GetDistributionFiltersUseCase({required this.distributionFiltersRepository});

  final DistributionFiltersRepository distributionFiltersRepository;

  Future<Set<DistributionFilter>> call() async {
    return await distributionFiltersRepository.getAllFilters();
  }
}
