import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

final binomialDistributionModel = DiscreteDistributionModel(
  id: 'binomial_distribution',
  name: 'Rozkład dwumianowy',
  shortDescription:
      'Rozkład dyskretny modelujący ilość sukcesów w n niezależnych próbach Bernoulliego, gdzie sukces ma stałe prawdopodobieństwo.',
  parameters: [
    DistributionParameter(
      'n',
      'Ilość prób (n)',
      'Określa ilość uwzględnionych prób Bernoulliego.',
      min: 0,
      max: 1000,
      defaultValue: 10,
      isInteger: true,
    ),
    DistributionParameter(
      'p',
      'Prawdopodobieństwo sukcesu (p)',
      'Określa prawdopobobieństwo wylosowania sukcesu (1). Jeśli p=0.2, to mamy 20% szans na sukces (1) i 80% szans na porażkę (0).',
      min: 0,
      max: 1,
      defaultValue: 0.5,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Rozkład dwumianowy jest czasem nazywany rozkładem Bernoulliego (szczególnie w polskim piśmiennictwie). Jest uogólnieniem rozkładu zerojedynkowego, gdzie mamy do czynienia tylko z jedną [próbą Bernoulliego](https://pl.wikipedia.org/wiki/Pr%C3%B3ba_Bernoulliego) (próba bernoulliego to zdarzenie typu sukces/porażka).',
        containsMarkdownLinks: true,
      ),
      DistributionDescriptionMathExpression(
        title: 'Masa prawdopodobieństwa',
        data: r'f(k; n, p) = \binom{n}{k} p^k (1-p)^{n-k}, \quad k = 0, 1, \dots, n',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(k; n, p) = \sum_{i=0}^k \binom{n}{i} p^i (1-p)^{n-i}, \quad k = 0, 1, \dots, n',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = np',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \sqrt{np(1-p)}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = np(1-p)',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'Me \approx \lfloor np + p \rfloor',
      ),
      DistributionDescriptionMathExpression(
        title: 'Moda',
        data: r'Mo = \lfloor (n+1)p \rfloor, \quad \text{dla } (n+1)p \notin \mathbb{Z}',
      ),

      DistributionDescriptionParagraph(
        text:
            'Za pomocą rozkładu dwumianowego możemy na przykład sprawdzić, jaka jest szansa wypadnięcia "szóstki" na uczciwej kości do gry cztery razy z rzędu. Rozkład dwumianowy jest wykorzystywany m.in. w naukach społecznych, finansach, bankowości i w branży ubezpieczeniowej.',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);

num binomialDistributionPmf(int k, DistributionParamsSetup params) {
  final n = params.getValue('n') as int;
  final p = params.getValue('p');

  if (p < 0 || p > 1) throw ArgumentError("Probability p must be in the range [0, 1].");
  if (k < 0 || k > n) return 0;

  num coefficient = 1.0;
  for (int i = 0; i < k; i++) {
    coefficient *= (n - i) / (i + 1);
  }

  return coefficient * pow(p, k) * pow(1 - p, n - k);
}

num binomialDistributionCdf(num k, DistributionParamsSetup params) {
  final p = params.getValue('p');

  if (p < 0 || p > 1) {
    throw ArgumentError("Probability p must be in the range [0, 1].");
  }

  num cdf = 0;
  for (int i = 0; i <= k; i++) {
    cdf += binomialDistributionPmf(i, params);
  }
  return cdf;
}

(int, int) binomialDistributionRangeGetter(DistributionParamsSetup params) {
  final n = params.getValue('n') as int;
  return (0, n + 1);
}

num binomialDistributionExpectedValue(DistributionParamsSetup params) {
  final n = params.getValue('n');
  final p = params.getValue('p');
  return n * p;
}

num binomialDistributionVariance(DistributionParamsSetup params) {
  final n = params.getValue('n');
  final p = params.getValue('p');
  return n * p * (1 - p);
}

num binomialDistributionStandardDeviation(DistributionParamsSetup params) {
  final variance = binomialDistributionVariance(params);
  return sqrt(variance);
}

num binomialDistributionMedian(DistributionParamsSetup params) {
  final n = params.getValue('n');
  final p = params.getValue('p');
  return (n + 1) * p;
}

num binomialDistributionMode(DistributionParamsSetup params) {
  final n = params.getValue('n');
  final p = params.getValue('p');
  final mode = (n + 1) * p;

  if (mode.floor() == mode) {
    return mode.floor() - 1;
  } else {
    return mode.floor();
  }
}
