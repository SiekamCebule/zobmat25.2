import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';

abstract interface class DistributionsRepository {
  Future<List<Distribution>> getAllDistributions();
}
