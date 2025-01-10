import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_filter.dart';

enum DistributionType {
  continuous,
  discrete;

  DistributionFilter toFilter() =>
      this == DistributionType.continuous
          ? DistributionFilter.continuous
          : DistributionFilter.discrete;
}
