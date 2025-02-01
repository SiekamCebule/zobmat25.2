import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class GetDistributionAnalysisSetupUseCase {
  const GetDistributionAnalysisSetupUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<DistributionAnalysisSetup?> call() async {
    return distributionDashboard.getAnalysisSetup();
  }
}
