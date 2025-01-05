import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_filter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/repository/distribution_filters_repository.dart';

class InMemoryDistributionFiltersRepository implements DistributionFiltersRepository {
  InMemoryDistributionFiltersRepository({required Set<DistributionFilter> initialFilters})
    : _filters = initialFilters;

  Set<DistributionFilter> _filters;

  @override
  Future<Set<DistributionFilter>> getAllFilters() async => _filters;

  @override
  Future<void> setFilter(DistributionFilter filter, bool shouldBeActive) async {
    if (shouldBeActive) {
      _filters = {..._filters, filter};
    } else {
      _filters = _filters.where((f) => f != filter).toSet();
    }
  }

  @override
  Future<bool> isActive(DistributionFilter filter) async => _filters.contains(filter);
}
