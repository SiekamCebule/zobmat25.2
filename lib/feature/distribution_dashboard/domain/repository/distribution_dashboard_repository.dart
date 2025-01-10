import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_chart_type.dart';

abstract interface class DistributionDashboardRepository {
  Future<Distribution?> getSelectedDistribution();
  Future<void> setSelectedDistribution(Distribution? distribution);

  Future<DistributionChartType> getChartType();
  Future<void> setChartType(DistributionChartType chartType);

  Future<DistributionParamsSetup?> getParamsSetup();
  Future<void> setParamsSetup(DistributionParamsSetup paramsSetup);

  Future<DistributionAnalysisSetup?> getAnalysisSetup();
  Future<void> setAnalysisSetup(DistributionAnalysisSetup analysisSetup);
}
