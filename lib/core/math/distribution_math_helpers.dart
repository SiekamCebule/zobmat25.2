import 'package:zobmat25_2/core/distribution_function_typedefs.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';

num findQuantile({
  required ContinuousDistributionCdf cdf,
  required DistributionParamsSetup params,
  required num targetProbability,
  num lowerBound = -1000,
  num upperBound = 1000,
  num tolerance = 1e-9,
  int maxIterations = 1000,
}) {
  if (targetProbability <= 0 || targetProbability >= 1) {
    throw ArgumentError('Target probability must be between 0 and 1 (exclusive).');
  }

  num lower = lowerBound;
  num upper = upperBound;
  int iteration = 0;

  while (upper - lower > tolerance && iteration < maxIterations) {
    final mid = (lower + upper) / 2;
    final prob = cdf(mid, params);

    if (prob < targetProbability) {
      lower = mid;
    } else {
      upper = mid;
    }
    iteration++;
  }

  if (iteration >= maxIterations) {
    throw Exception(
      'Max iterations reached. Quantile approximation may not be accurate.',
    );
  }

  return (lower + upper) / 2;
}

int findDiscreteUpperBound(
  num threshold,
  DistributionParamsSetup params,
  num Function(int, DistributionParamsSetup) pmf,
) {
  if (threshold <= 0 || threshold >= 1) {
    throw ArgumentError("Threshold must be in the range (0, 1).");
  }

  num cumulativeProbability = 0;
  int k = 0;

  while (true) {
    final pmfValue = pmf(k, params);

    if (pmfValue <= 0) {
      break;
    }

    cumulativeProbability += pmfValue;

    if (1 - cumulativeProbability < threshold) {
      return k;
    }

    k++;
  }

  return k;
}

num findInverseCdf(
  ContinuousDistributionCdf cdf,
  DistributionParamsSetup params,
  num target,
  num lowerBound,
  num upperBound, {
  num tolerance = 1e-6,
  int maxIterations = 100,
}) {
  var low = lowerBound;
  var high = upperBound;

  for (var i = 0; i < maxIterations; i++) {
    final mid = (low + high) / 2;
    final cdfValue = cdf(mid, params);

    if ((cdfValue - target).abs() < tolerance) {
      return mid; // Znaleziono wartość
    }

    if (cdfValue < target) {
      low = mid; // Szukamy w prawej części
    } else {
      high = mid; // Szukamy w lewej części
    }
  }

  throw StateError('Nie udało się znaleźć odwrotnej CDF w zadanym przedziale.');
}
