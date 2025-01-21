import 'package:zobmat25_2/core/distribution_function_typedefs.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/beta_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/chi_square_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/exponential_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/gamma_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/laplace_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/log_normal_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/normal_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/cauchy_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/t_student_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/uniform_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/weibull_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/binomial_distribution.dart';

abstract interface class PredefinedDistributionFunctionsDataSource {
  Future<ContinuousDistributionPdf> getContinuousPdf(String distributionId);
  Future<ContinuousDistributionCdf> getContinuousCdf(String distributionId);
  Future<ContinuousDistributionInverseCdf> getContinuousInverseCdf(String distributionId);
  Future<DiscreteDistributionPmf> getDiscretePmf(String distributionId);
  Future<DiscreteDistributionCdf> getDiscreteCdf(String distributionId);
  Future<DiscreteDistributionRangeGetter> getDiscreteRangeGetter(String distributionId);
}

class PredefinedDistributionFunctionsDataSourceImpl
    implements PredefinedDistributionFunctionsDataSource {
  PredefinedDistributionFunctionsDataSourceImpl();

  static final Map<String, ContinuousDistributionPdf> _continuousPdfs = {
    'normal_distribution': normalDistributionPdf,
    'uniform_continuous_distribution': uniformDistributionPdf,
    'cauchy_distribution': cauchyDistributionPdf,
    'exponential_distribution': exponentialDistributionPdf,
    'gamma_distribution': gammaDistributionPdf,
    'beta_distribution': betaDistributionPdf,
    'laplace_distribution': laplaceDistributionPdf,
    'chi_square_distribution': chiSquareDistributionPdf,
    't_student_distribution': tStudentDistributionPdf,
    'log_normal_distribution': logNormalDistributionPdf,
    'weibull_distribution': weibullDistributionPdf,
  };
  static final Map<String, ContinuousDistributionCdf> _continuousCdfs = {
    'normal_distribution': normalDistributionCdf,
    'uniform_continuous_distribution': uniformDistributionCdf,
    'cauchy_distribution': cauchyDistributionCdf,
    'exponential_distribution': exponentialDistributionCdf,
    'gamma_distribution': gammaDistributionCdf,
    'beta_distribution': betaDistributionCdf,
    'laplace_distribution': laplaceDistributionCdf,
    'chi_square_distribution': chiSquareDistributionCdf,
    't_student_distribution': tStudentDistributionCdf,
    'log_normal_distribution': logNormalDistributionCdf,
    'weibull_distribution': weibullDistributionCdf,
  };
  static final Map<String, ContinuousDistributionCdf> _continuousInverseCdfs = {
    'normal_distribution': normalDistributionInverseCdf,
    'uniform_continuous_distribution': uniformDistributionInverseCdf,
    'cauchy_distribution': cauchyDistributionInverseCdf,
    'exponential_distribution': exponentialDistributionInverseCdf,
    'gamma_distribution': gammaDistributionInverseCdf,
    'beta_distribution': betaDistributionInverseCdf,
    'laplace_distribution': laplaceDistributionInverseCdf,
    'chi_square_distribution': chiSquareDistributionInverseCdf,
    't_student_distribution': tStudentDistributionInverseCdf,
    'log_normal_distribution': logNormalDistributionInverseCdf,
    'weibull_distribution': weibullDistributionInverseCdf,
  };

  static final Map<String, DiscreteDistributionPmf> _discretePmfs = {
    'binomial_distribution': binomialDistributionPmf,
  };

  static final Map<String, DiscreteDistributionCdf> _discreteCdfs = {
    'binomial_distribution': binomialDistributionCdf,
  };
  static final Map<String, DiscreteDistributionRangeGetter> _discreteRangeGetters = {
    'binomial_distribution': binomialDistributionRangeGetter,
  };

  @override
  Future<ContinuousDistributionCdf> getContinuousPdf(String distributionId) async =>
      _continuousPdfs[distributionId]!;

  @override
  Future<ContinuousDistributionCdf> getContinuousCdf(String distributionId) async =>
      _continuousCdfs[distributionId]!;

  @override
  Future<ContinuousDistributionInverseCdf> getContinuousInverseCdf(
    String distributionId,
  ) async => _continuousInverseCdfs[distributionId]!;

  @override
  Future<DiscreteDistributionPmf> getDiscretePmf(String distributionId) async =>
      _discretePmfs[distributionId]!;

  @override
  Future<DiscreteDistributionCdf> getDiscreteCdf(String distributionId) async =>
      _discreteCdfs[distributionId]!;

  @override
  Future<DiscreteDistributionRangeGetter> getDiscreteRangeGetter(
    String distributionId,
  ) async => _discreteRangeGetters[distributionId]!;
}
