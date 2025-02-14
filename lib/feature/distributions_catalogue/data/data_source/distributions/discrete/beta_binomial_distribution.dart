import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/parameter_should_be_computed_numerically_exception.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

import 'package:data/data.dart' as data;

final betaBinomialDistribution = DiscreteDistributionModel(
  id: 'beta_binomial_distribution',
  name: 'Rozkład beta-dwumianowy',
  shortDescription:
      'Rozkład dyskretny modelujący liczbę sukcesów w n próbach, gdy prawdopodobieństwo sukcesu samo podlega rozkładowi beta.',
  parameters: [
    DistributionParameter(
      'n',
      'Ilość prób (n)',
      'Określa liczbę prób.',
      min: 0,
      max: 100000,
      defaultValue: 10,
      isInteger: true,
    ),
    DistributionParameter(
      'alpha',
      'Parametr alfa',
      'Parametr kształtu rozkładu beta.',
      min: 0,
      max: 74,
      defaultValue: 1,
    ),
    DistributionParameter(
      'beta',
      'Parametr beta',
      'Parametr kształtu rozkładu beta.',
      min: 0,
      max: 74,
      defaultValue: 1,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Dowiedz się więcej [tutaj (angielska Wikipedia)](https://en.wikipedia.org/wiki/Beta-binomial_distribution).',
      ),
      DistributionDescriptionMathExpression(
        title: 'Masa prawdopodobieństwa',
        data:
            r'f(k; n, \alpha, \beta) = \frac{\binom{n}{k} B(k+\alpha, n-k+\beta)}{B(\alpha, \beta)}, \quad k = 0, 1, \dots, n',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(k; n, \alpha, \beta) = \sum_{i=0}^{k} \frac{\binom{n}{i} B(i+\alpha, n-i+\beta)}{B(\alpha, \beta)}, \quad k = 0, 1, \dots, n',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = n \frac{\alpha}{\alpha + \beta}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data:
            r'\sigma = \sqrt{n \frac{\alpha \beta}{(\alpha + \beta)^2 (\alpha + \beta + 1)}}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data:
            r'\text{Var}(X) = n \frac{\alpha \beta}{(\alpha + \beta)^2 (\alpha + \beta + 1)}',
      ),
    ],
  ),
);

num betaBinomialDistributionPmf(int k, DistributionParamsSetup params) {
  final n = params.getValue('n') as int;
  final alpha = params.getValue('alpha');
  final beta = params.getValue('beta');

  if (k < 0 || k > n) return 0;

  num coefficient = 1.0;
  for (int i = 0; i < k; i++) {
    coefficient *= (n - i) / (i + 1);
  }

  return coefficient * data.beta(k + alpha, n - k + beta) / data.beta(alpha, beta);
}

num betaBinomialDistributionCdf(num k, DistributionParamsSetup params) {
  num cdf = 0;
  for (int i = 0; i <= k; i++) {
    cdf += betaBinomialDistributionPmf(i, params);
  }
  return cdf;
}

(int, int) betaBinomialDistributionRangeGetter(DistributionParamsSetup params) {
  final n = params.getValue('n') as int;
  return (0, n + 1);
}

num betaBinomialDistributionExpectedValue(DistributionParamsSetup params) {
  final n = params.getValue('n');
  final alpha = params.getValue('alpha');
  final beta = params.getValue('beta');
  return n * (alpha / (alpha + beta));
}

num betaBinomialDistributionVariance(DistributionParamsSetup params) {
  final n = params.getValue('n');
  final alpha = params.getValue('alpha');
  final beta = params.getValue('beta');
  return n * (alpha * beta) / ((alpha + beta) * (alpha + beta) * (alpha + beta + 1));
}

num betaBinomialDistributionMode(DistributionParamsSetup params) {
  final n = params.getValue('n');
  final alpha = params.getValue('alpha');
  final beta = params.getValue('beta');

  if (n == 0) return 0;
  if (alpha <= 1 || beta <= 1) {
    throw ParameterShouldBeComputedNumericallyException();
  }

  return ((n - 1) * (alpha - 1) / (alpha + beta - 2)).round();
}

num betaBinomialDistributionMedian(DistributionParamsSetup params) {
  throw ParameterShouldBeComputedNumericallyException();
}

num betaBinomialDistributionStandardDeviation(DistributionParamsSetup params) {
  final variance = betaBinomialDistributionVariance(params);
  return sqrt(variance);
}
