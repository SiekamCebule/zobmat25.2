import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/distribution_analysis.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/discrete_distribution.dart';

class UpdateDistributionAnalysisUseCase {
  const UpdateDistributionAnalysisUseCase({required this.distributionDashboard});

  final DistributionDashboard distributionDashboard;

  Future<void> call() async {
    final distribution = await distributionDashboard.getSelectedDistribution();
    if (distribution == null) {
      throw StateError('No distribution is selected, so cannot initialize the analysis');
    }
    //final analysis = await distributionDashboard.getAnalysis();
    final analysisSetup = await distributionDashboard.getAnalysisSetup();
    final paramsSetup = (await distributionDashboard.getParamsSetup())!;

    final DistributionAnalysis newAnalysis = switch (analysisSetup) {
      ContinuousDistributionAnalysisSetup() => ContinuousDistributionAnalysis().analyze(
        setup:
            await distributionDashboard.getAnalysisSetup()
                as ContinuousDistributionAnalysisSetup,
        distribution: distribution as ContinuousDistribution,
        paramsSetup: paramsSetup,
      ),
      DiscreteDistributionAnalysisSetup() => DiscreteDistributionAnalysis().analyze(
        setup:
            await distributionDashboard.getAnalysisSetup()
                as DiscreteDistributionAnalysisSetup,
        distribution: distribution as DiscreteDistribution,
        paramsSetup: paramsSetup,
      ),
      _ =>
        throw UnsupportedError(
          'An unknown distribution analysis setup type: ${analysisSetup.runtimeType.toString()}',
        ),
    };
    await distributionDashboard.setAnalysis(newAnalysis);
  }
}
