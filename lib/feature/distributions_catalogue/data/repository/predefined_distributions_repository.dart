import 'package:zobmat25_2/core/util/async_map.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/predefined_distribution_math_functions_data_source.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/predefined_distributions_data_source.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/mapper/distribution_mappers.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
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
      if (model is ContinuousDistributionModel) {
        return continuousDistributionFromModel(
          model,
          pdf: await mathFunctionsDataSource.getContinuousPdf(model.id),
          cdf: await mathFunctionsDataSource.getContinuousCdf(model.id),
          inverseCdf: await mathFunctionsDataSource.getContinuousInverseCdf(model.id),
        );
      } else if (model is DiscreteDistributionModel) {
        return discreteDistributionFromModel(
          model,
          pmf: await mathFunctionsDataSource.getDiscretePmf(model.id),
          cdf: await mathFunctionsDataSource.getDiscreteCdf(model.id),
        );
      } else {
        throw UnsupportedError(
          '${model.runtimeType} distributions are not supported yet',
        );
      }
    });
    return distributions.toList();
  }
}
