import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';

class ToggleDistributionSelectionUseCase {
  const ToggleDistributionSelectionUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<void> call(Distribution distribution) async {
    final currentSelected = await distributionDashboard.getSelectedDistribution();
    if (currentSelected == distribution) {
      await distributionDashboard.setSelectedDistribution(null);
    } else {
      await distributionDashboard.setSelectedDistribution(distribution);
      final params = {
        for (final parameter in distribution.parameters)
          parameter: parameter.defaultValue,
      };
      final paramsSetup = DistributionParamsSetup(values: params);
      await distributionDashboard.setParamsSetup(paramsSetup);
    }
  }
}
