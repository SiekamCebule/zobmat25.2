import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';

class GetSelectedDistributionUseCase {
  const GetSelectedDistributionUseCase({required this.distributionDashboardRepository});

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<Distribution?> call() async {
    return distributionDashboardRepository.getSelectedDistribution();
  }
}
