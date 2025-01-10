import 'package:equatable/equatable.dart';

class DistributionAnalysisSetup with EquatableMixin {
  const DistributionAnalysisSetup({
    required this.analysisCondition,
    required this.parameters,
  });

  final DistributionAnalysisCondition analysisCondition;
  final Map<DistributionAnalysisParameter, double> parameters;

  @override
  List<Object?> get props => [analysisCondition, parameters];
}

enum DistributionAnalysisCondition {
  /// P(X>x)
  randomVariableIsGreaterThanX(parameters: [DistributionAnalysisParameter.x]),

  /// P(X<x)
  randomVariableIsLessThanX(parameters: [DistributionAnalysisParameter.x]),

  /// P(y<X<z)
  randomVariableInOpenInterval(
    parameters: [DistributionAnalysisParameter.y, DistributionAnalysisParameter.z],
  );

  const DistributionAnalysisCondition({required this.parameters});

  final List<DistributionAnalysisParameter> parameters;
}

enum DistributionAnalysisParameter {
  x('x'),
  y('y'),
  z('z');

  const DistributionAnalysisParameter(this.id);

  final String id;
}
