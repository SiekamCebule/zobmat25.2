import 'package:equatable/equatable.dart';

sealed class DistributionParameterRule with EquatableMixin {
  const DistributionParameterRule();

  @override
  List<Object?> get props => [];
}

class DistributionParameterNotHigherRule extends DistributionParameterRule {
  const DistributionParameterNotHigherRule({required this.otherParameterId});

  final String otherParameterId;

  @override
  List<Object?> get props => [otherParameterId];
}

class DistributionParameterHigherRule extends DistributionParameterRule {
  const DistributionParameterHigherRule({required this.otherParameterId});

  final String otherParameterId;

  @override
  List<Object?> get props => [otherParameterId];
}
