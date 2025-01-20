import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

abstract class Distribution extends Equatable {
  const Distribution({
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

  DistributionType get type;

  @override
  List<Object?> get props => [name, shortDescription, parameters, extendedDescription];
}
