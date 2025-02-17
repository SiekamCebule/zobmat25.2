import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/discrete_distribution.dart';
import 'package:quiver/iterables.dart' as quiver;

class DrawNumbersByDistributionUseCase {
  const DrawNumbersByDistributionUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<List<num>> call({required int count}) async {
    final distribution = (await distributionDashboard.getSelectedDistribution())!;
    final random = Random();
    final paramsSetup = (await distributionDashboard.getParamsSetup())!;

    final list = <num>[];
    if (distribution is ContinuousDistribution) {
      // Losowanie z rozkładu ciągłego
      for (var _ in quiver.range(count)) {
        final uniformDouble = random.nextDouble();
        final generated = distribution.functions.inverseCdf(uniformDouble, paramsSetup);
        list.add(generated);
      }
    } else if (distribution is DiscreteDistribution) {
      final xValuesRange = distribution.functions.getChartRange(paramsSetup);
      final possibleXValues = List.generate(
        xValuesRange.$2 - xValuesRange.$1 + 1,
        (i) => xValuesRange.$1 + i,
      );

      for (var _ in quiver.range(count)) {
        final uniformDouble = random.nextDouble();

        final generated = possibleXValues.firstWhere((x) {
          final prevCdf =
              x == xValuesRange.$1 ? 0 : distribution.functions.cdf(x - 1, paramsSetup);
          final currentCdf = distribution.functions.cdf(x, paramsSetup);
          return prevCdf < uniformDouble && uniformDouble <= currentCdf;
        });
        list.add(generated);
      }
    }

    return list;
  }
}
