import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/beta_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/chi_square_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/exponential_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/gamma_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/laplace_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/log_normal_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/normal_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/cauchy_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/pareto_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/t_student_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/uniform_continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/weibull_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/binomial_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/geometric_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/hypergeometric_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/pascal_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/poisson_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/continuous_distribution_functions.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/discrete_distribution_functions.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/distribution_property_functions.dart';

abstract interface class PredefinedDistributionFunctionsDataSource {
  Future<ContinuousDistributionFunctions> getContinuousFunctions(String distributionId);
  Future<DiscreteDistributionFunctions> getDiscreteFunctions(String distributionId);
  Future<DistributionPropertyFunctions> getPropertyFunctions(String distributionId);
}

class PredefinedDistributionFunctionsDataSourceImpl
    implements PredefinedDistributionFunctionsDataSource {
  PredefinedDistributionFunctionsDataSourceImpl();

  @override
  Future<ContinuousDistributionFunctions> getContinuousFunctions(
    String distributionId,
  ) async {
    return switch (distributionId) {
      'normal_distribution' => ContinuousDistributionFunctions(
        pdf: normalDistributionPdf,
        cdf: normalDistributionCdf,
        inverseCdf: normalDistributionInverseCdf,
        getChartRange: normalDistributionRangeGetter,
      ),
      'uniform_continuous_distribution' => ContinuousDistributionFunctions(
        pdf: uniformContinuousDistributionPdf,
        cdf: uniformContinuousDistributionCdf,
        inverseCdf: uniformContinuousDistributionInverseCdf,
        getChartRange: uniformContinuousDistributionRangeGetter,
      ),
      'cauchy_distribution' => ContinuousDistributionFunctions(
        pdf: cauchyDistributionPdf,
        cdf: cauchyDistributionCdf,
        inverseCdf: cauchyDistributionInverseCdf,
        getChartRange: cauchyDistributionRangeGetter,
      ),
      'exponential_distribution' => ContinuousDistributionFunctions(
        pdf: exponentialDistributionPdf,
        cdf: exponentialDistributionCdf,
        inverseCdf: exponentialDistributionInverseCdf,
        getChartRange: exponentialDistributionRangeGetter,
      ),
      'gamma_distribution' => ContinuousDistributionFunctions(
        pdf: gammaDistributionPdf,
        cdf: gammaDistributionCdf,
        inverseCdf: gammaDistributionInverseCdf,
        getChartRange: gammaDistributionRangeGetter,
      ),
      'beta_distribution' => ContinuousDistributionFunctions(
        pdf: betaDistributionPdf,
        cdf: betaDistributionCdf,
        inverseCdf: betaDistributionInverseCdf,
        getChartRange: betaDistributionRangeGetter,
      ),
      'laplace_distribution' => ContinuousDistributionFunctions(
        pdf: laplaceDistributionPdf,
        cdf: laplaceDistributionCdf,
        inverseCdf: laplaceDistributionInverseCdf,
        getChartRange: laplaceDistributionRangeGetter,
      ),
      'chi_square_distribution' => ContinuousDistributionFunctions(
        pdf: chiSquareDistributionPdf,
        cdf: chiSquareDistributionCdf,
        inverseCdf: chiSquareDistributionInverseCdf,
        getChartRange: chiSquareDistributionRangeGetter,
      ),
      't_student_distribution' => ContinuousDistributionFunctions(
        pdf: tStudentDistributionPdf,
        cdf: tStudentDistributionCdf,
        inverseCdf: tStudentDistributionInverseCdf,
        getChartRange: tStudentDistributionRangeGetter,
      ),
      'log_normal_distribution' => ContinuousDistributionFunctions(
        pdf: logNormalDistributionPdf,
        cdf: logNormalDistributionCdf,
        inverseCdf: logNormalDistributionInverseCdf,
        getChartRange: logNormalDistributionRangeGetter,
      ),
      'weibull_distribution' => ContinuousDistributionFunctions(
        pdf: weibullDistributionPdf,
        cdf: weibullDistributionCdf,
        inverseCdf: weibullDistributionInverseCdf,
        getChartRange: weibullDistributionRangeGetter,
      ),
      'pareto_distribution' => ContinuousDistributionFunctions(
        pdf: paretoDistributionPdf,
        cdf: paretoDistributionCdf,
        inverseCdf: paretoDistributionInverseCdf,
        getChartRange: paretoDistributionRangeGetter,
      ),

      _ => throw ArgumentError('Unknown distribution ID: $distributionId'),
    };
  }

  @override
  Future<DiscreteDistributionFunctions> getDiscreteFunctions(
    String distributionId,
  ) async {
    return switch (distributionId) {
      'binomial_distribution' => DiscreteDistributionFunctions(
        pmf: binomialDistributionPmf,
        cdf: binomialDistributionCdf,
        getChartRange: binomialDistributionRangeGetter,
      ),
      'geometric_distribution' => DiscreteDistributionFunctions(
        pmf: geometricDistributionPmf,
        cdf: geometricDistributionCdf,
        getChartRange: geometricDistributionRangeGetter,
      ),
      'hypergeometric_distribution' => DiscreteDistributionFunctions(
        pmf: hypergeometricDistributionPmf,
        cdf: hypergeometricDistributionCdf,
        getChartRange: hypergeometricDistributionRangeGetter,
      ),
      'poisson_distribution' => DiscreteDistributionFunctions(
        pmf: poissonDistributionPmf,
        cdf: poissonDistributionCdf,
        getChartRange: poissonDistributionRangeGetter,
      ),
      'pascal_distribution' => DiscreteDistributionFunctions(
        pmf: pascalDistributionPmf,
        cdf: pascalDistributionCdf,
        getChartRange: pascalDistributionRangeGetter,
      ),
      _ => throw ArgumentError('Unknown distribution ID: $distributionId'),
    };
  }

  @override
  Future<DistributionPropertyFunctions> getPropertyFunctions(
    String distributionId,
  ) async {
    return switch (distributionId) {
      // CONTINUOUS
      'normal_distribution' => DistributionPropertyFunctions(
        expectedValue: normalDistributionExpectedValue,
        variance: normalDistributionVariance,
        standardDeviation: normalDistributionStandardDeviation,
        median: normalDistributionMedian,
        mode: normalDistributionMode,
      ),
      'uniform_continuous_distribution' => DistributionPropertyFunctions(
        expectedValue: uniformContinuousDistributionExpectedValue,
        variance: uniformContinuousDistributionVariance,
        standardDeviation: uniformContinuousDistributionStandardDeviation,
        median: uniformContinuousDistributionMedian,
        mode: uniformContinuousDistributionMode,
      ),
      'cauchy_distribution' => DistributionPropertyFunctions(
        expectedValue: cauchyDistributionExpectedValue,
        variance: cauchyDistributionVariance,
        standardDeviation: cauchyDistributionStandardDeviation,
        median: cauchyDistributionMedian,
        mode: cauchyDistributionMode,
      ),
      'exponential_distribution' => DistributionPropertyFunctions(
        expectedValue: exponentialDistributionExpectedValue,
        variance: exponentialDistributionVariance,
        standardDeviation: exponentialDistributionStandardDeviation,
        median: exponentialDistributionMedian,
        mode: exponentialDistributionMode,
      ),
      'gamma_distribution' => DistributionPropertyFunctions(
        expectedValue: gammaDistributionExpectedValue,
        variance: gammaDistributionVariance,
        standardDeviation: gammaDistributionStandardDeviation,
        median: gammaDistributionMedian,
        mode: gammaDistributionMode,
      ),
      'beta_distribution' => DistributionPropertyFunctions(
        expectedValue: betaDistributionExpectedValue,
        variance: betaDistributionVariance,
        standardDeviation: betaDistributionStandardDeviation,
        median: betaDistributionMedian,
        mode: betaDistributionMode,
      ),
      'laplace_distribution' => DistributionPropertyFunctions(
        expectedValue: laplaceDistributionExpectedValue,
        variance: laplaceDistributionVariance,
        standardDeviation: laplaceDistributionStandardDeviation,
        median: laplaceDistributionMedian,
        mode: laplaceDistributionMode,
      ),
      'chi_square_distribution' => DistributionPropertyFunctions(
        expectedValue: chiSquareDistributionExpectedValue,
        variance: chiSquareDistributionVariance,
        standardDeviation: chiSquareDistributionStandardDeviation,
        median: chiSquareDistributionMedian,
        mode: chiSquareDistributionMode,
      ),
      't_student_distribution' => DistributionPropertyFunctions(
        expectedValue: tStudentDistributionExpectedValue,
        variance: tStudentDistributionVariance,
        standardDeviation: tStudentDistributionStandardDeviation,
        median: tStudentDistributionMedian,
        mode: tStudentDistributionMode,
      ),
      'log_normal_distribution' => DistributionPropertyFunctions(
        expectedValue: logNormalDistributionExpectedValue,
        variance: logNormalDistributionVariance,
        standardDeviation: logNormalDistributionStandardDeviation,
        median: logNormalDistributionMedian,
        mode: logNormalDistributionMode,
      ),
      'weibull_distribution' => DistributionPropertyFunctions(
        expectedValue: weibullDistributionExpectedValue,
        variance: weibullDistributionVariance,
        standardDeviation: weibullDistributionStandardDeviation,
        median: weibullDistributionMedian,
        mode: weibullDistributionMode,
      ),
      'pareto_distribution' => DistributionPropertyFunctions(
        expectedValue: paretoDistributionExpectedValue,
        variance: paretoDistributionVariance,
        standardDeviation: paretoDistributionStandardDeviation,
        median: paretoDistributionMedian,
        mode: paretoDistributionMode,
      ),
      // DISCRETE
      'binomial_distribution' => DistributionPropertyFunctions(
        expectedValue: binomialDistributionExpectedValue,
        variance: binomialDistributionVariance,
        standardDeviation: binomialDistributionStandardDeviation,
        median: binomialDistributionMedian,
        mode: binomialDistributionMode,
      ),
      'geometric_distribution' => DistributionPropertyFunctions(
        expectedValue: geometricDistributionExpectedValue,
        variance: geometricDistributionVariance,
        standardDeviation: geometricDistributionStandardDeviation,
        median: geometricDistributionMedian,
        mode: geometricDistributionMode,
      ),
      'hypergeometric_distribution' => DistributionPropertyFunctions(
        expectedValue: hypergeometricDistributionExpectedValue,
        variance: hypergeometricDistributionVariance,
        standardDeviation: hypergeometricDistributionStandardDeviation,
        median: hypergeometricDistributionMedian,
        mode: hypergeometricDistributionMode,
      ),
      'poisson_distribution' => DistributionPropertyFunctions(
        expectedValue: poissonDistributionExpectedValue,
        variance: poissonDistributionVariance,
        standardDeviation: poissonDistributionStandardDeviation,
        median: poissonDistributionMedian,
        mode: poissonDistributionMode,
      ),
      'pascal_distribution' => DistributionPropertyFunctions(
        expectedValue: pascalDistributionExpectedValue,
        variance: pascalDistributionVariance,
        standardDeviation: pascalDistributionStandardDeviation,
        median: pascalDistributionMedian,
        mode: pascalDistributionMode,
      ),

      _ => throw ArgumentError('Unknown distribution ID: $distributionId'),
    };
  }
}
