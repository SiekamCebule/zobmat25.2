import 'dart:math';

import 'package:quiver/iterables.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';

class DrawNumbersByDistributionUseCase {
  const DrawNumbersByDistributionUseCase({required this.distributionDashboardRepository});

  final DistributionDashboardRepository distributionDashboardRepository;

  Future<List<num>> call({required int count}) async {
    final distribution =
        (await distributionDashboardRepository.getSelectedDistribution())!;
    final random = Random();
    final paramsSetup = (await distributionDashboardRepository.getParamsSetup())!;

    final list = <num>[];
    for (var _ in range(count)) {
      final uniformDouble = random.nextDouble();
      final generated = distribution.inverseCdf(uniformDouble, paramsSetup);
      list.add(generated);
    }
    return list;
  }
}
