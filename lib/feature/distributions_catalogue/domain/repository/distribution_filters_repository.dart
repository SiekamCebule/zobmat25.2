import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_filter.dart';

abstract interface class DistributionFiltersRepository {
  Future<Set<DistributionFilter>> getAllFilters();
  Future<void> setFilter(DistributionFilter filter, bool shouldBeActive);
  Future<bool> isActive(DistributionFilter filter);
}
