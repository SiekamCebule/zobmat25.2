import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class GetDistributionParamsSetupUseCase {
  const GetDistributionParamsSetupUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<DistributionParamsSetup?> call() async {
    return distributionDashboard.getParamsSetup();
  }
}
