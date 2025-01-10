import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/cauchy_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/exponential_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/normal_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';

abstract interface class PredefinedDistributionsDataSource {
  Future<List<DistributionModel>> getAll();
}

class PredefinedDistributionsDataSourceImpl implements PredefinedDistributionsDataSource {
  @override
  Future<List<DistributionModel>> getAll() async {
    return [
      normalDistributionModel,
      cauchyDistributionModel,
      exponentialDistributionModel,
    ]; // TODO: ADD DISTRIBUTIONS
  }
}
