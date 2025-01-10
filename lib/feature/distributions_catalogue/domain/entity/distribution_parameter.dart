import 'package:equatable/equatable.dart';

class DistributionParameter with EquatableMixin {
  const DistributionParameter(
    this.id,
    this.name,
    this.description, {
    required this.min,
    required this.max,
    required this.defaultValue,
  });

  final String id;
  final String name;
  final String description;
  final double min;
  final double max;
  final double defaultValue;

  @override
  List<Object?> get props => [id, name, description, min, max, defaultValue];
}
