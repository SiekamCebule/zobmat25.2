import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_component.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_parameter.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_parameter_value.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';

class ChangeDistributionAnalysisParameterUseCase {
  const ChangeDistributionAnalysisParameterUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<void> call({
    required DistributionAnalysisComponent component,
    required DistributionAnalysisParameter parameter,
    required DistributionAnalysisParameterValue value,
  }) async {
    final analysisSetup = await distributionDashboard.getAnalysisSetup();
    if (analysisSetup == null) {
      throw StateError('The distribution analysis setup is not avaiable');
    }
    final componentParameters = analysisSetup.componentParameters;
    final newComponentParameters = Map.of(componentParameters);
    final newComponentParameterValues = Map.of(
      newComponentParameters[component] ??
          <DistributionAnalysisParameter, DistributionAnalysisParameterValue>{},
    );
    newComponentParameterValues[parameter] = value;
    newComponentParameters[component] = newComponentParameterValues;
    late final DistributionAnalysisSetup newAnalysisSetup;
    if (analysisSetup is ContinuousDistributionAnalysisSetup) {
      newAnalysisSetup = ContinuousDistributionAnalysisSetup(
        componentParameters: newComponentParameters.cast(),
      );
    } else if (analysisSetup is DiscreteDistributionAnalysisSetup) {
      newAnalysisSetup = DiscreteDistributionAnalysisSetup(
        componentParameters: newComponentParameters.cast(),
      );
    }

    return await distributionDashboard.setAnalysisSetup(newAnalysisSetup);
  }
}
