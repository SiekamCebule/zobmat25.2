import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_component.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/discrete_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';

abstract class DistributionAnalysis<
  T_AS extends DistributionAnalysisSetup,
  T_D extends Distribution
>
    with EquatableMixin {
  const DistributionAnalysis({this.results = const {}});
  final Map<DistributionAnalysisComponent, num?> results;
  DistributionAnalysis analyze({
    required T_AS setup,
    required T_D distribution,
    required DistributionParamsSetup paramsSetup,
  });

  @override
  List<Object?> get props => [results];
}

class ContinuousDistributionAnalysis
    extends
        DistributionAnalysis<
          ContinuousDistributionAnalysisSetup,
          ContinuousDistribution
        > {
  const ContinuousDistributionAnalysis({super.results = const {}});

  @override
  ContinuousDistributionAnalysis analyze({
    required ContinuousDistributionAnalysisSetup setup,
    required ContinuousDistribution distribution,
    required DistributionParamsSetup paramsSetup,
  }) {
    final results = <ContinuousDistributionAnalysisComponent, num?>{};
    final components = setup.componentParameters.keys;
    for (final component in components) {
      final parameterValue = setup.componentParameters[component]!;
      if (component ==
          DistributionAnalysisPredefinedComponents.continuousVariableBelonging) {
        final a = parameterValue[component.getParameter('a')]!;
        final b = parameterValue[component.getParameter('b')]!;
        final chanceForBelonging = continuousVariableChanceForBelonging(
          cdf: distribution.functions.cdf,
          a: a.toNum(),
          b: b.toNum(),
          params: paramsSetup,
        );
        results[component] = chanceForBelonging;
      } else if (component ==
          DistributionAnalysisPredefinedComponents.continuousVariableEquality) {
        results[component] =
            0.0; // Dla rozkładów ciągłych X = x zawsze wynosi 0 (nieskończenie wiele wartości)
      } else {
        throw UnsupportedError(
          'Continuous distribution analyzer does not support ${component.runtimeType} components',
        );
      }
    }
    return ContinuousDistributionAnalysis(results: results);
  }
}

class DiscreteDistributionAnalysis
    extends
        DistributionAnalysis<DiscreteDistributionAnalysisSetup, DiscreteDistribution> {
  const DiscreteDistributionAnalysis({super.results = const {}});

  @override
  DiscreteDistributionAnalysis analyze({
    required DiscreteDistributionAnalysisSetup setup,
    required DiscreteDistribution distribution,
    required DistributionParamsSetup paramsSetup,
  }) {
    final results = <DiscreteDistributionAnalysisComponent, num?>{};
    final components = setup.componentParameters.keys;
    for (final component in components) {
      final parameterValue = setup.componentParameters[component]!;
      if (component ==
          DistributionAnalysisPredefinedComponents.discreteVariableBelonging) {
        final a = parameterValue[component.getParameter('a')]!;
        final b = parameterValue[component.getParameter('b')]!;
        final chanceForBelonging = discreteVariableChanceForBelonging(
          cdf: distribution.functions.cdf,
          a: a.toNum(),
          b: b.toNum(),
          params: paramsSetup,
        );
        results[component] = chanceForBelonging;
      } else if (component ==
          DistributionAnalysisPredefinedComponents.discreteVariableEquality) {
        final x = parameterValue[component.getParameter('x')]!.toNum().toInt();
        results[component] = distribution.functions.pmf(x, paramsSetup);
      } else {
        throw UnsupportedError(
          'Continuous distribution analyzer does not support ${component.runtimeType} components',
        );
      }
    }

    return DiscreteDistributionAnalysis(results: results);
  }
}
