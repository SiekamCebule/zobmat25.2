import 'package:equatable/equatable.dart';

class DistributionParameter with EquatableMixin {
  const DistributionParameter(this.id, this.name);

  final String id;
  final String name;

  @override
  List<Object?> get props => [id, name];
}
