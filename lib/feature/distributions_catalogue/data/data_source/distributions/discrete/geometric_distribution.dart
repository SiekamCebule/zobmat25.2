import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

final geometricDistributionModel = DiscreteDistributionModel(
  id: 'geometric_distribution',
  name: 'Rozkład geometryczny',
  shortDescription:
      'Rozkład opisujący ilość procesów Bernoulliego do wystąpienia pierwszego sukcesu (np. wyrzucenia pierwszej "szóstki" na kostce)',
  parameters: [
    DistributionParameter(
      'p',
      'Prawdopodobieństwo sukcesu (p)',
      'Określa prawdopodobieństwo wartości sukcesu (1) w procesie Bernoulliego',
      min: 0,
      max: 1,
      defaultValue: 0.5,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionMathExpression(
        title: 'Masa prawdopodobieństwa',
        data: r'P(X = k) = (1 - p)^{k-1} p, \quad k \geq 1, \, 0 < p \leq 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data: r'F(k) = 1 - (1 - p)^k, \quad k \geq 1, \, 0 < p \leq 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = \frac{1}{p}, \quad 0 < p \leq 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = \frac{1 - p}{p^2}, \quad 0 < p \leq 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \sqrt{\frac{1 - p}{p^2}}, \quad 0 < p \leq 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data:
            r'\text{Me} = \lceil \frac{\ln 2}{\ln(1 / (1 - p))} \rceil, \quad 0 < p \leq 1',
      ),
      DistributionDescriptionMathExpression(title: 'Moda', data: r'\text{Mo} = 1'),
    ],
  ),
);

num geometricDistributionPmf(int k, DistributionParamsSetup params) {
  final p = params.getValue('p');
  if (p <= 0 || p > 1) throw ArgumentError("Probability p must be in the range (0, 1].");
  if (k < 1) return 0;
  return pow(1 - p, k - 1) * p;
}

num geometricDistributionCdf(num k, DistributionParamsSetup params) {
  final p = params.getValue('p');
  if (p <= 0 || p > 1) throw ArgumentError("Probability p must be in the range (0, 1].");
  if (k < 1) return 0;
  return 1 - pow(1 - p, k);
}

(int, int) geometricDistributionRangeGetter(DistributionParamsSetup params) {
  final p = params.getValue('p');
  if (p <= 0 || p > 1) throw ArgumentError("Probability p must be in the range (0, 1].");

  const requiredProbability = 0.000001;
  int maxK = 1;
  while (pow(1 - p, maxK - 1) * p > requiredProbability) {
    maxK++;
  }
  return (1, maxK);
}

num geometricDistributionExpectedValue(DistributionParamsSetup params) {
  final p = params.getValue('p');
  if (p <= 0 || p > 1) throw ArgumentError("Probability p must be in the range (0, 1].");
  return 1 / p;
}

num geometricDistributionVariance(DistributionParamsSetup params) {
  final p = params.getValue('p');
  if (p <= 0 || p > 1) throw ArgumentError("Probability p must be in the range (0, 1].");
  return (1 - p) / (p * p);
}

num geometricDistributionStandardDeviation(DistributionParamsSetup params) {
  final variance = geometricDistributionVariance(params);
  return sqrt(variance);
}

num geometricDistributionMedian(DistributionParamsSetup params) {
  final p = params.getValue('p');
  if (p <= 0 || p > 1) throw ArgumentError("Probability p must be in the range (0, 1].");
  return (log(2) / log(1 / (1 - p))).ceil();
}

num geometricDistributionMode(DistributionParamsSetup params) {
  return 1;
}
