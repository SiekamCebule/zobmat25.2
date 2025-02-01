import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_component.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_parameter.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_parameter_value.dart';

abstract class DistributionAnalysisSetup<T extends DistributionAnalysisComponent>
    with EquatableMixin {
  const DistributionAnalysisSetup({required this.componentParameters});

  final Map<T, Map<DistributionAnalysisParameter, DistributionAnalysisParameterValue>>
  componentParameters;

  @override
  List<Object?> get props => [componentParameters];
}

class ContinuousDistributionAnalysisSetup
    extends DistributionAnalysisSetup<ContinuousDistributionAnalysisComponent> {
  const ContinuousDistributionAnalysisSetup({required super.componentParameters});
}

class DiscreteDistributionAnalysisSetup
    extends DistributionAnalysisSetup<DiscreteDistributionAnalysisComponent> {
  const DiscreteDistributionAnalysisSetup({required super.componentParameters});
}
