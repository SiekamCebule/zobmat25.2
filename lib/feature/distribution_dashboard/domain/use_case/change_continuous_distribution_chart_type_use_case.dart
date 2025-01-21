import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/continuous_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';

class ChangeContinuousDistributionChartTypeUseCase {
  const ChangeContinuousDistributionChartTypeUseCase({
    required this.distributionDashboardRepository,
  });

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<void> call(ContinuousDistributionChartType chartType) async {
    await distributionDashboardRepository.setContinuousChartType(chartType);
  }
}
