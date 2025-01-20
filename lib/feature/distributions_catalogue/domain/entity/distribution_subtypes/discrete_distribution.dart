import 'package:zobmat25_2/core/distribution_math_typedefs.dart';
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
  });

  final DiscreteDistributionPmf pmf; // f(x), funkcja masy prawdopodobieństwa
  final DiscreteDistributionCdf cdf; // f(x), dystrybuanta

  @override
  DistributionType get type => DistributionType.discrete;

  @override
  List<Object?> get props => [super.props, pmf, cdf];
}
