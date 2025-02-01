import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/continuous_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class ChangeContinuousDistributionChartTypeUseCase {
  const ChangeContinuousDistributionChartTypeUseCase({
    required this.distributionDashboard,
  });

  final DistributionDashboard distributionDashboard;

  Future<void> call(ContinuousDistributionChartType chartType) async {
    await distributionDashboard.setContinuousChartType(chartType);
  }
}
