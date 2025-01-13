import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_component.dart';

class DistributionDescription with EquatableMixin {
  const DistributionDescription({required this.components});

  final List<DistributionDescriptionComponent> components;

  @override
  List<Object?> get props => [components];
}
