import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

abstract class DistributionModel {
  const DistributionModel({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.parameters,
    required this.extendedDescription,
  });

  final String id;
  final String name;
  final String shortDescription;
  final List<DistributionParameter> parameters;
  final DistributionDescription extendedDescription; // Opis
}

class DiscreteDistributionModel extends DistributionModel {
  const DiscreteDistributionModel({
    required super.id,
    required super.name,
    required super.shortDescription,
    required super.parameters,
    required super.extendedDescription,
  });
}

class ContinuousDistributionModel extends DistributionModel {
  const ContinuousDistributionModel({
    required super.id,
    required super.name,
    required super.shortDescription,
    required super.parameters,
    required super.extendedDescription,
  });
}
