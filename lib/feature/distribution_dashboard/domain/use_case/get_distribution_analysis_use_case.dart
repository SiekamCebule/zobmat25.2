import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/distribution_analysis.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class GetDistributionAnalysisUseCase {
  const GetDistributionAnalysisUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<DistributionAnalysis?> call() async {
    final analysis = await distributionDashboard.getAnalysis();
    return analysis;
  }
}
