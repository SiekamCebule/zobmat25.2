import 'package:zobmat25_2/core/distribution_math_typedefs.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/beta_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/chi_square_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/exponential_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/gamma_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/laplace_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/normal_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/cauchy_distribution.dart';

abstract interface class PredefinedDistributionMathFunctionsDataSource {
  Future<DistributionPdf> getPdf(String distributionId);
  Future<DistributionCdf> getCdf(String distributionId);
  Future<DistributionInverseCdf> getInverseCdf(String distributionId);
}

class PredefinedDistributionMathFunctionsDataSourceImpl
    implements PredefinedDistributionMathFunctionsDataSource {
  PredefinedDistributionMathFunctionsDataSourceImpl();

  static final Map<String, DistributionPdf> _pdfs = {
    'normal_distribution': normalDistributionPdf,
    'cauchy_distribution': cauchyDistributionPdf,
    'exponential_distribution': exponentialDistributionPdf,
    'gamma_distribution': gammaDistributionPdf,
    'beta_distribution': betaDistributionPdf,
    'laplace_distribution': laplaceDistributionPdf,
    'chi_square_distribution': chiSquareDistributionPdf,
  };
  static final Map<String, DistributionCdf> _cdfs = {
    'normal_distribution': normalDistributionCdf,
    'cauchy_distribution': cauchyDistributionCdf,
    'exponential_distribution': exponentialDistributionCdf,
    'gamma_distribution': gammaDistributionCdf,
    'beta_distribution': betaDistributionCdf,
    'laplace_distribution': laplaceDistributionCdf,
    'chi_square_distribution': chiSquareDistributionCdf,
  };
  static final Map<String, DistributionCdf> _inverseCdfs = {
    'normal_distribution': normalDistributionInverseCdf,
    'cauchy_distribution': cauchyDistributionInverseCdf,
    'exponential_distribution': exponentialDistributionInverseCdf,
    'gamma_distribution': gammaDistributionInverseCdf,
    'beta_distribution': betaDistributionInverseCdf,
    'laplace_distribution': laplaceDistributionInverseCdf,
    'chi_square_distribution': chiSquareDistributionInverseCdf,
  };

  @override
  Future<DistributionCdf> getPdf(String distributionId) async => _pdfs[distributionId]!;

  @override
  Future<DistributionCdf> getCdf(String distributionId) async => _cdfs[distributionId]!;

  @override
  Future<DistributionInverseCdf> getInverseCdf(String distributionId) async =>
      _inverseCdfs[distributionId]!;
}
