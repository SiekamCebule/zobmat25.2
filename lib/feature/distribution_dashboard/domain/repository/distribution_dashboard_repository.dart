import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/discrete_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_knowledge_view_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/continuous_distribution_chart_type.dart';

abstract interface class DistributionDashboardRepository {
  Future<Distribution?> getSelectedDistribution();
  Future<void> setSelectedDistribution(Distribution? distribution);

  Future<ContinuousDistributionChartType> getContinuousChartType();
  Future<void> setContinuousChartType(ContinuousDistributionChartType chartType);

  Future<DiscreteDistributionChartType> getDiscreteChartType();
  Future<void> setDiscreteChartType(DiscreteDistributionChartType chartType);

  Future<DistributionKnowledgeViewType> getKnowledgeViewType();
  Future<void> setKnowledgeViewType(DistributionKnowledgeViewType chartType);

  Future<DistributionParamsSetup?> getParamsSetup();
  Future<void> setParamsSetup(DistributionParamsSetup paramsSetup);

  Future<DistributionAnalysisSetup?> getAnalysisSetup();
  Future<void> setAnalysisSetup(DistributionAnalysisSetup analysisSetup);
}
