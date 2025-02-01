import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/discrete_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class GetDiscreteDistributionChartTypeUseCase {
  const GetDiscreteDistributionChartTypeUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<DiscreteDistributionChartType> call() async {
    return distributionDashboard.getDiscreteChartType();
  }
}
