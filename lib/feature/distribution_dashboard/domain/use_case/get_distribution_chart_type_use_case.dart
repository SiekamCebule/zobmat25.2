import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';

class GetDistributionChartTypeUseCase {
  const GetDistributionChartTypeUseCase({required this.distributionDashboardRepository});

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<DistributionChartType> call() async {
    return distributionDashboardRepository.getChartType();
  }
}
