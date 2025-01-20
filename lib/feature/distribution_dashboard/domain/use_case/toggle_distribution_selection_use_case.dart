import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';

class ToggleDistributionSelectionUseCase {
  const ToggleDistributionSelectionUseCase({
    required this.distributionDashboardRepository,
  });

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<void> call(Distribution distribution) async {
    final currentSelected =
        await distributionDashboardRepository.getSelectedDistribution();
    if (currentSelected == distribution) {
      await distributionDashboardRepository.setSelectedDistribution(null);
    } else {
      await distributionDashboardRepository.setSelectedDistribution(distribution);
      final params = {
        for (final parameter in distribution.parameters)
          parameter: parameter.defaultValue,
      };
      final paramsSetup = DistributionParamsSetup(values: params);
      await distributionDashboardRepository.setParamsSetup(paramsSetup);
    }
  }
}
