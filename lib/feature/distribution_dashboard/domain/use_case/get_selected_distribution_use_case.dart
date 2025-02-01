import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';

class GetSelectedDistributionUseCase {
  const GetSelectedDistributionUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<Distribution?> call() async {
    return distributionDashboard.getSelectedDistribution();
  }
}
