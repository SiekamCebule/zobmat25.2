import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/discrete_distribution_functions.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

class DiscreteDistribution extends Distribution {
  const DiscreteDistribution({
    required super.id,
    required super.name,
    required super.shortDescription,
    required super.extendedDescription,
    required super.parameters,
    required super.propertyFunctions,
    required this.functions,
  });

  final DiscreteDistributionFunctions functions;

  @override
  DistributionType get type => DistributionType.discrete;

  @override
  List<Object?> get props => [super.props, functions];
}
