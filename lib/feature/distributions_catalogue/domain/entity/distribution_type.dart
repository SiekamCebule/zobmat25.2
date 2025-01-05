import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_filter.dart';

enum DistributionType {
  contiunous,
  discrete;

  DistributionFilter toFilter() =>
      this == DistributionType.contiunous
          ? DistributionFilter.continuous
          : DistributionFilter.discrete;
}
