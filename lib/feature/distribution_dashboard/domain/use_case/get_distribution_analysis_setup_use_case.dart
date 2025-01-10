import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';

class GetDistributionAnalysisSetupUseCase {
  const GetDistributionAnalysisSetupUseCase({
    required this.distributionDashboardRepository,
  });

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<DistributionAnalysisSetup?> call() async {
    return distributionDashboardRepository.getAnalysisSetup();
  }
}
