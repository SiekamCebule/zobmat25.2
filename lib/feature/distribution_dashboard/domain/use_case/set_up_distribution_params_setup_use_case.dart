import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';

class SetUpDistributionParamsSetupUseCase {
  const SetUpDistributionParamsSetupUseCase({
    required this.distributionDashboardRepository,
  });

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<void> call() async {
    final distribution = await distributionDashboardRepository.getSelectedDistribution();
    if (distribution == null) {
      throw StateError('No distribution is selected, so cannot generate a params setup');
    }
    final params = {for (final parameter in distribution.parameters) parameter: 0.0};
    final paramsSetup = DistributionParamsSetup(values: params);
    await distributionDashboardRepository.setParamsSetup(paramsSetup);
  }
}
