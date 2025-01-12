import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter_rule.dart';

class DistributionParameter with EquatableMixin {
  const DistributionParameter(
    this.id,
    this.name,
    this.description, {
    required this.min,
    required this.max,
    this.rules = const [],
    required this.defaultValue,
  });

  final String id;
  final String name;
  final String description;
  final double min;
  final double max;
  final List<DistributionParameterRule> rules;
  final double defaultValue;

  @override
  List<Object?> get props => [id, name, description, min, max, defaultValue];
}
