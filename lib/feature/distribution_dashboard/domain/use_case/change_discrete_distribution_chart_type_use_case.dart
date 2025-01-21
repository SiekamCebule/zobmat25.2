import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/discrete_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';

class ChangeDiscreteDistributionChartTypeUseCase {
  const ChangeDiscreteDistributionChartTypeUseCase({
    required this.distributionDashboardRepository,
  });

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<void> call(DiscreteDistributionChartType chartType) async {
    await distributionDashboardRepository.setDiscreteChartType(chartType);
  }
}
