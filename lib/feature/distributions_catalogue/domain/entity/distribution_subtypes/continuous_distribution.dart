import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/continuous_distribution_functions.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

class ContinuousDistribution extends Distribution {
  const ContinuousDistribution({
    required super.id,
    required super.name,
    required super.shortDescription,
    required super.extendedDescription,
    required super.parameters,
    required super.propertyFunctions,
    required this.functions,
  });

  final ContinuousDistributionFunctions functions;

  @override
  DistributionType get type => DistributionType.continuous;

  @override
  List<Object?> get props => [super.props, functions];
}
