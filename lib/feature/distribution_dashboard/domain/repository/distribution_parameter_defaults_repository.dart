import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

abstract interface class DistributionParameterDefaultsRepository {
  Future<num> getDefaultValue({
    required Distribution distribution,
    required DistributionParameter parameter,
  });
}
