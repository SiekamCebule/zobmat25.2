import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_parameter.dart';

abstract class DistributionAnalysisComponent with EquatableMixin {
  const DistributionAnalysisComponent({required this.parameters});

  final List<DistributionAnalysisParameter> parameters;

  DistributionAnalysisParameter? getParameter(String id) {
    return parameters.singleWhereOrNull((parameter) {
      return parameter.id == id;
    });
  }
}

class ContinuousDistributionAnalysisComponent extends DistributionAnalysisComponent {
  const ContinuousDistributionAnalysisComponent({required super.parameters});

  @override
  List<Object?> get props => [parameters];
}

class DiscreteDistributionAnalysisComponent extends DistributionAnalysisComponent {
  const DiscreteDistributionAnalysisComponent({required super.parameters});

  @override
  List<Object?> get props => [parameters];
}

abstract class DistributionAnalysisPredefinedComponents {
  static const continuousVariableBelonging = ContinuousDistributionAnalysisComponent(
    parameters: [
      DistributionAnalysisParameter(id: 'a', symbol: 'a'),
      DistributionAnalysisParameter(id: 'b', symbol: 'b'),
    ],
  );
  static const continuousVariableEquality = ContinuousDistributionAnalysisComponent(
    parameters: [DistributionAnalysisParameter(id: 'x', symbol: 'x')],
  );

  static const discreteVariableBelonging = DiscreteDistributionAnalysisComponent(
    parameters: [
      DistributionAnalysisParameter(id: 'a', symbol: 'a'),
      DistributionAnalysisParameter(id: 'b', symbol: 'b'),
    ],
  );

  static const discreteVariableEquality = DiscreteDistributionAnalysisComponent(
    parameters: [DistributionAnalysisParameter(id: 'x', symbol: 'x')],
  );
}
