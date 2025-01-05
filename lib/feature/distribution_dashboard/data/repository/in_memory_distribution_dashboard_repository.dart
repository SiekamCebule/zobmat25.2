import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';

class InMemoryDistributionDashboardRepository implements DistributionDashboardRepository {
  InMemoryDistributionDashboardRepository({required Distribution? initial})
    : _selected = initial;

  Distribution? _selected;

  @override
  Future<Distribution?> getSelectedDistribution() async => _selected;

  @override
  Future<void> setSelectedDistribution(Distribution? distribution) async =>
      _selected = distribution;
}
