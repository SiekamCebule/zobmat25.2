import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';

abstract interface class DistributionDashboardRepository {
  Future<Distribution?> getSelectedDistribution();
  Future<void> setSelectedDistribution(Distribution? distribution);
}
