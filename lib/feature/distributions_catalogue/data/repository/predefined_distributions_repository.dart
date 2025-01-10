import 'package:zobmat25_2/core/util/async_map.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/predefined_distribution_math_functions_data_source.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/predefined_distributions_data_source.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/mapper/distribution_mappers.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/repository/distributions_repository.dart';

class PredefinedDistributionsRepository implements DistributionsRepository {
  const PredefinedDistributionsRepository({
    required this.distributionsDataSource,
    required this.mathFunctionsDataSource,
  });

  final PredefinedDistributionsDataSource distributionsDataSource;
  final PredefinedDistributionMathFunctionsDataSource mathFunctionsDataSource;

  @override
  Future<List<Distribution>> getAllDistributions() async {
    final models = await distributionsDataSource.getAll();
    final distributions = await models.asyncMap((model) async {
      return distributionFromModel(
        model,
        pdf: await mathFunctionsDataSource.getPdf(model.id),
        cdf: await mathFunctionsDataSource.getCdf(model.id),
        inverseCdf: await mathFunctionsDataSource.getInverseCdf(model.id),
      );
    });
    return distributions.toList();
  }
}
