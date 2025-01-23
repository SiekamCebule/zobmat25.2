import 'package:equatable/equatable.dart';

sealed class DistributionParameterRule with EquatableMixin {
  const DistributionParameterRule();

  @override
  List<Object?> get props => [];
}

class DistributionParameterNotHigherRule extends DistributionParameterRule {
  const DistributionParameterNotHigherRule({
    this.orEqual = false,
    required this.otherParameterId,
  });

  final bool orEqual;
  final String otherParameterId;

  @override
  List<Object?> get props => [otherParameterId];
}

class DistributionParameterHigherRule extends DistributionParameterRule {
  const DistributionParameterHigherRule({
    this.orEqual = false,
    required this.otherParameterId,
  });

  final bool orEqual;
  final String otherParameterId;

  @override
  List<Object?> get props => [otherParameterId];
}
