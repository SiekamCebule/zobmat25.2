import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_component.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_parameter_value.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';

class InitializeDistributionAnalysisSetupUseCase {
  const InitializeDistributionAnalysisSetupUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<void> call() async {
    final distribution = await distributionDashboard.getSelectedDistribution();
    if (distribution == null) {
      throw StateError('No distribution is selected, so cannot initialize the analysis');
    }
    late final DistributionAnalysisSetup analysisSetup;
    if (distribution is ContinuousDistribution) {
      final variableBelonging =
          DistributionAnalysisPredefinedComponents.continuousVariableBelonging;
      final variableEquality =
          DistributionAnalysisPredefinedComponents.continuousVariableEquality;
      analysisSetup = ContinuousDistributionAnalysisSetup(
        componentParameters: {
          variableBelonging: {
            variableBelonging.getParameter(
              'a',
            )!: DistributionAnalysisParameterInfinityValue(negative: true),
            variableBelonging.getParameter('b')!:
                DistributionAnalysisParameterInfinityValue(),
          },
          variableEquality: {
            variableEquality.getParameter('x')!: DistributionAnalysisParameterNumberValue(
              0,
            ),
          },
        },
      );
    } else {
      final variableBelonging =
          DistributionAnalysisPredefinedComponents.discreteVariableBelonging;
      final variableEquality =
          DistributionAnalysisPredefinedComponents.discreteVariableEquality;
      analysisSetup = DiscreteDistributionAnalysisSetup(
        componentParameters: {
          variableBelonging: {
            variableBelonging.getParameter(
              'a',
            )!: DistributionAnalysisParameterInfinityValue(negative: true),
            variableBelonging.getParameter('b')!:
                DistributionAnalysisParameterInfinityValue(),
          },
          variableEquality: {
            variableEquality.getParameter('x')!: DistributionAnalysisParameterNumberValue(
              0,
            ),
          },
        },
      );
    }
    await distributionDashboard.setAnalysisSetup(analysisSetup);
  }
}
