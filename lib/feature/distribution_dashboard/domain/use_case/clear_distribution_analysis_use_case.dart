import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class ClearDistributionAnalysisUseCase {
  const ClearDistributionAnalysisUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<void> call() async {
    await distributionDashboard.setAnalysis(null);
  }
}
