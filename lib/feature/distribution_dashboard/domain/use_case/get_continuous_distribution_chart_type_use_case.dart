import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/continuous_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';

class GetContinuousDistributionChartTypeUseCase {
  const GetContinuousDistributionChartTypeUseCase({
    required this.distributionDashboardRepository,
  });

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<ContinuousDistributionChartType> call() async {
    return distributionDashboardRepository.getContinuousChartType();
  }
}
