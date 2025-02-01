import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/continuous_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class GetContinuousDistributionChartTypeUseCase {
  const GetContinuousDistributionChartTypeUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<ContinuousDistributionChartType> call() async {
    return distributionDashboard.getContinuousChartType();
  }
}
