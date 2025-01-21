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
    this.isInteger = false,
  });

  final String id;
  final String name;
  final String description;
  final num min;
  final num max;
  final List<DistributionParameterRule> rules;
  final num defaultValue;
  final bool isInteger;

  @override
  List<Object?> get props => [id, name, description, min, max, defaultValue, isInteger];
}
