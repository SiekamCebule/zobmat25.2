import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/discrete_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class ChangeDiscreteDistributionChartTypeUseCase {
  const ChangeDiscreteDistributionChartTypeUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<void> call(DiscreteDistributionChartType chartType) async {
    await distributionDashboard.setDiscreteChartType(chartType);
  }
}
