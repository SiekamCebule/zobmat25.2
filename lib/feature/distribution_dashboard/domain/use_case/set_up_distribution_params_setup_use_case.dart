import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class SetUpDistributionParamsSetupUseCase {
  const SetUpDistributionParamsSetupUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<void> call() async {
    final distribution = await distributionDashboard.getSelectedDistribution();
    if (distribution == null) {
      throw StateError('No distribution is selected, so cannot generate a params setup');
    }
    final params = {for (final parameter in distribution.parameters) parameter: 0.0};
    final paramsSetup = DistributionParamsSetup(values: params);
    await distributionDashboard.setParamsSetup(paramsSetup);
  }
}
