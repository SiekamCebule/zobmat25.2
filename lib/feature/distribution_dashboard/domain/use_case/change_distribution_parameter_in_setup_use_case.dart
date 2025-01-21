import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

class ChangeDistributionParameterInSetupUseCase {
  const ChangeDistributionParameterInSetupUseCase({
    required this.distributionDashboardRepository,
  });

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<void> call(DistributionParameter parameter, {required num value}) async {
    final paramsSetup = await distributionDashboardRepository.getParamsSetup();
    if (paramsSetup == null) {
      throw StateError(
        'Cannot change distribution parameters setup, because params have not been initialized',
      );
    }
    final newParamsSetup = paramsSetup.copyWith(
      values: Map.of(paramsSetup.values)..[parameter] = value,
    );
    await distributionDashboardRepository.setParamsSetup(newParamsSetup);
  }
}
