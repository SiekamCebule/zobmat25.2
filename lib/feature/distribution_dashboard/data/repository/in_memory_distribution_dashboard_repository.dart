import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/discrete_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/continuous_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_knowledge_view_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';

class InMemoryDistributionDashboardRepository implements DistributionDashboardRepository {
  InMemoryDistributionDashboardRepository({
    required Distribution? initialDistribution,
    required ContinuousDistributionChartType initialContinuousChartType,
    required DiscreteDistributionChartType initialDiscreteChartType,
    required DistributionKnowledgeViewType initialKnowledgeViewType,
    required DistributionParamsSetup? initialParamsSetup,
    required DistributionAnalysisSetup? initialAnalysisSetup,
  }) : _distribution = initialDistribution,
       _continuousChartType = initialContinuousChartType,
       _discreteChartType = initialDiscreteChartType,
       _knowledgeViewType = initialKnowledgeViewType,
       _paramsSetup = initialParamsSetup,
       _analysisSetup = initialAnalysisSetup;

  Distribution? _distribution;
  ContinuousDistributionChartType _continuousChartType;
  DiscreteDistributionChartType _discreteChartType;
  DistributionKnowledgeViewType _knowledgeViewType;
  DistributionParamsSetup? _paramsSetup;
  DistributionAnalysisSetup? _analysisSetup;

  @override
  Future<Distribution?> getSelectedDistribution() async => _distribution;

  @override
  Future<void> setSelectedDistribution(Distribution? distribution) async =>
      _distribution = distribution;

  @override
  Future<ContinuousDistributionChartType> getContinuousChartType() async =>
      _continuousChartType;

  @override
  Future<void> setContinuousChartType(ContinuousDistributionChartType chartType) async =>
      _continuousChartType = chartType;

  @override
  Future<DiscreteDistributionChartType> getDiscreteChartType() async =>
      _discreteChartType;

  @override
  Future<void> setDiscreteChartType(DiscreteDistributionChartType chartType) async =>
      _discreteChartType = chartType;

  @override
  Future<DistributionKnowledgeViewType> getKnowledgeViewType() async =>
      _knowledgeViewType;

  @override
  Future<void> setKnowledgeViewType(
    DistributionKnowledgeViewType knowledgeViewType,
  ) async => _knowledgeViewType = knowledgeViewType;

  @override
  Future<DistributionParamsSetup?> getParamsSetup() async => _paramsSetup;

  @override
  Future<void> setParamsSetup(DistributionParamsSetup paramsSetup) async {
    _paramsSetup = paramsSetup;
  }

  @override
  Future<DistributionAnalysisSetup?> getAnalysisSetup() async => _analysisSetup;

  @override
  Future<void> setAnalysisSetup(DistributionAnalysisSetup analysisSetup) async =>
      _analysisSetup = analysisSetup;
}
