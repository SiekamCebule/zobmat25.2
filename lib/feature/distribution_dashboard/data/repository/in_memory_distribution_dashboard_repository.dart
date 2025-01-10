import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/repository/distribution_dashboard_repository.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';

class InMemoryDistributionDashboardRepository implements DistributionDashboardRepository {
  InMemoryDistributionDashboardRepository({
    required Distribution? initialDistribution,
    required DistributionChartType initialChartType,
    required DistributionParamsSetup? initialParamsSetup,
    required DistributionAnalysisSetup? initialAnalysisSetup,
  }) : _distribution = initialDistribution,
       _chartType = initialChartType,
       _paramsSetup = initialParamsSetup,
       _analysisSetup = initialAnalysisSetup;

  Distribution? _distribution;
  DistributionChartType _chartType;
  DistributionParamsSetup? _paramsSetup;
  DistributionAnalysisSetup? _analysisSetup;

  @override
  Future<Distribution?> getSelectedDistribution() async => _distribution;

  @override
  Future<void> setSelectedDistribution(Distribution? distribution) async =>
      _distribution = distribution;

  @override
  Future<DistributionChartType> getChartType() async => _chartType;

  @override
  Future<void> setChartType(DistributionChartType chartType) async =>
      _chartType = chartType;

  @override
  Future<DistributionParamsSetup?> getParamsSetup() async => _paramsSetup;

  @override
  Future<void> setParamsSetup(DistributionParamsSetup paramsSetup) async =>
      _paramsSetup = paramsSetup;

  @override
  Future<DistributionAnalysisSetup?> getAnalysisSetup() async => _analysisSetup;

  @override
  Future<void> setAnalysisSetup(DistributionAnalysisSetup analysisSetup) async =>
      _analysisSetup = analysisSetup;
}
