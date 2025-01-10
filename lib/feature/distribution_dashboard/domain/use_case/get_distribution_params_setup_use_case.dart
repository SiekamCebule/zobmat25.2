import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';

class GetDistributionParamsSetupUseCase {
  const GetDistributionParamsSetupUseCase({
    required this.distributionDashboardRepository,
  });

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<DistributionParamsSetup?> call() async {
    return distributionDashboardRepository.getParamsSetup();
  }
}
