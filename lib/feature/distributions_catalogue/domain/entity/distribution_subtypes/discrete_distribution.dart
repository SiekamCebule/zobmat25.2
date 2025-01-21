import 'package:zobmat25_2/core/distribution_function_typedefs.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

class DiscreteDistribution extends Distribution {
  const DiscreteDistribution({
    required super.id,
    required super.name,
    required super.shortDescription,
    required super.extendedDescription,
    required super.parameters,
    required this.pmf,
    required this.cdf,
    required this.getChartRange,
  });

  final DiscreteDistributionPmf pmf; // f(x), funkcja masy prawdopodobieństwa
  final DiscreteDistributionCdf cdf; // f(x), dystrybuanta
  final DiscreteDistributionRangeGetter
  getChartRange; // Jaki jest najmniejszy i największy x jaki ma być widoczny na wykresie

  @override
  DistributionType get type => DistributionType.discrete;

  @override
  List<Object?> get props => [super.props, pmf, cdf, getChartRange];
}
