import 'dart:math';

import 'package:zobmat25_2/core/distribution_math_typedefs.dart';

abstract interface class PredefinedDistributionMathFunctionsDataSource {
  Future<DistributionPdf> getPdf(String distributionName);
  Future<DistributionCdf> getCdf(String distributionName);
}

class PredefinedDistributionMathFunctionsDataSourceImpl
    implements PredefinedDistributionMathFunctionsDataSource {
  PredefinedDistributionMathFunctionsDataSourceImpl();

  static final Map<String, DistributionPdf> _pdfs = {
    'Rozkład normalny': normalDistributionPdf,
  };
  static final Map<String, DistributionCdf> _cdfs = {
    'Rozkład normalny': normalDistributionCdf,
  };

  @override
  Future<DistributionCdf> getPdf(String distributionName) async =>
      _pdfs[distributionName]!;

  @override
  Future<DistributionCdf> getCdf(String distributionName) async =>
      _cdfs[distributionName]!;
}

num normalDistributionPdf(num x, Map<String, num> param) {
  final mean = param['mean']!;
  final dev = param['dev']!;

  if (dev <= 0) {
    throw ArgumentError("Standard deviation (dev) must be greater than 0.");
  }
  final sqrt2Pi = sqrt(2 * pi);
  final exponent = -pow((x - mean) / dev, 2) / 2;
  return (1 / (dev * sqrt2Pi)) * exp(exponent);
}

num normalDistributionCdf(num x, Map<String, num> param) {
  final mean = param['mean']!;
  final dev = param['dev']!;

  if (dev <= 0) {
    throw ArgumentError("Standard deviation (dev) must be greater than 0.");
  }

  // Standardowa funkcja CDF oparta na erf
  final z = (x - mean) / (dev * sqrt(2));
  return 0.5 * (1 + erf(z));
}

num erf(num z) {
  const a1 = 0.254829592;
  const a2 = -0.284496736;
  const a3 = 1.421413741;
  const a4 = -1.453152027;
  const a5 = 1.061405429;
  const p = 0.3275911;

  final sign = z >= 0 ? 1 : -1;
  final absZ = z.abs();

  final t = 1.0 / (1.0 + p * absZ);
  final y =
      1.0 - (((((a5 * t + a4) * t) + a3) * t + a2) * t + a1) * t * exp(-absZ * absZ);

  return sign * y;
}
