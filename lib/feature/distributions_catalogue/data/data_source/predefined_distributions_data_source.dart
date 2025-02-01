import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/beta_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/cauchy_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/chi_square_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/exponential_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/gamma_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/laplace_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/log_normal_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/normal_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/pareto_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/t_student_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/uniform_continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/weibull_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/binomial_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/geometric_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/hypergeometric_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/pascal_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/poisson_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/discrete/zipf_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';

abstract interface class PredefinedDistributionsDataSource {
  Future<List<DistributionModel>> getAll();
}

class PredefinedDistributionsDataSourceImpl implements PredefinedDistributionsDataSource {
  @override
  Future<List<DistributionModel>> getAll() async {
    return [
      // CONTIUNOUS
      normalDistributionModel,
      uniformContinuousDistributionModel,
      cauchyDistributionModel,
      exponentialDistributionModel,
      gammaDistributionModel,
      betaDistributionModel,
      laplaceDistributionModel,
      chiSquareDistributionModel,
      tStudentDistributionModel,
      logNormalDistributionModel,
      weibullDistributionModel,
      paretoDistributionModel,

      // DISCRETE
      binomialDistributionModel,
      geometricDistributionModel,
      hypergeometricDistributionModel,
      poissonDistributionModel,
      pascalDistributionModel,
      zipfDistributionModel,
    ];
  }
}
