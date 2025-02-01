import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/parameter_should_be_computed_numerically_exception.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter_rule.dart';

final hypergeometricDistributionModel = DiscreteDistributionModel(
  id: 'hypergeometric_distribution',
  name: 'Rozkład hipergeometryczny',
  shortDescription:
      'Rozkład opisujący prawdopodobieństwo k sukcesów w próbie n z populacji N zawierającej K sukcesów, przy losowaniu bez zwracania.',
  parameters: [
    DistributionParameter(
      'N',
      'Ilość elementów (N)',
      'Określa całkowitą liczbę elementów w populacji (np. ilość kart w talii).',
      min: 0,
      max: 10000,
      defaultValue: 20,
      rules: [
        DistributionParameterHigherRule(orEqual: true, otherParameterId: 'K'),
        DistributionParameterHigherRule(orEqual: true, otherParameterId: 'n'),
      ],
      isInteger: true,
    ),
    DistributionParameter(
      'K',
      'Ilość sukcesów w populacji (K)',
      'Liczba sukcesów w populacji, czyli elementów spełniających określone kryterium (np. liczba pożądanych kart, z tych które losujemy. Np. ilość wszystkich pików, jeśli chcemy wylosować piki).',
      min: 0,
      max: 10000,
      defaultValue: 5,
      rules: [DistributionParameterNotHigherRule(orEqual: true, otherParameterId: 'N')],
      isInteger: true,
    ),
    DistributionParameter(
      'n',
      'Ilość losowanych elementów (n)',
      'Liczba losowanych elementów z populacji (bez zwracania). Np. 10 razy losujemy karty z talii.',
      min: 0,
      max: 10000,
      defaultValue: 10,
      rules: [DistributionParameterNotHigherRule(orEqual: true, otherParameterId: 'N')],
      isInteger: true,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Żeby zrozumieć rozkład hipergeometryczny, wyobraź sobie następującą sytuację: masz talię z 52 kartami, i chcesz wylosować wszystkie trefle. Można opisać tę sytuację rozkładem hipergeometrycznym o liczebności populacji 52, ilości sukcesów 13 (tyle jest trefli) i ilości prób np. 30 (tyle razy próbujemy wylosować trefle). Rozkład pokaże szansę, że wylosujemy wszystkie trefle, ale pokaże też szansę, że wylosujemy ich mniej od 8.\n\nOtrzymaną ilość elementów oznaczamy jako k. k jest zawsze większe lub równe 0, a także mniejsze od liczby sukcesów w populacji. \n\nWarto dodać, że mimo podobnej nazwy, rozkład hipergeometryczny nie jest związany z rozkładem geometrycznym.',
      ),
      DistributionDescriptionMathExpression(
        title: 'Masa prawdopodobieństwa',
        data: r'P(X=k) = \frac{\binom{K}{k} \binom{N-K}{n-k}}{\binom{N}{n}}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data: r'F(k) = \sum_{i=0}^k P(X=i)',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = n \frac{K}{N}, \quad N > 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data:
            r'\text{Var}(X) = n \frac{K}{N} \frac{N - K}{N} \frac{N - n}{N - 1}, \quad N > 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data:
            r'\sigma = \sqrt{n \frac{K}{N} \frac{N - K}{N} \frac{N - n}{N - 1}}, \quad N > 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'\text{BRAK (do obliczenia numerycznego)}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Moda',
        data:
            r'\text{Mo} = \left\lfloor \frac{(n + 1)(K + 1)}{N + 2} \right\rfloor, \quad N > 0',
      ),
      DistributionDescriptionParagraph(
        text:
            'Za pomocą rozkładu hipergeometrycznego możemy obliczyć swoje szanse na trafienie "szóstki" w lotto, szanse na otrzymanie określonej kombinacji kart w pokerze, szanse na trafienie n liczb w grze Keno. Rozkład hipergeometryczny jest powszechnie stosowany w kontroli jakości a także w elektrochemii (dowiedz się więcej [tutaj](https://www.statisticshowto.com/hypergeometric-distribution-examples/)).',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);

num hypergeometricDistributionPmf(int k, DistributionParamsSetup params) {
  final N = params.getValue('N') as int; // Total population size
  final K = params.getValue('K') as int; // Total successes in the population
  final n = params.getValue('n') as int; // Sample size

  if (k < 0 || k > n || k > K || n - k > N - K) return 0;

  num binomialCoefficient(int a, int b) {
    if (b < 0 || b > a) return 0;
    num result = 1;
    for (int i = 0; i < b; i++) {
      result *= (a - i) / (i + 1);
    }
    return result;
  }

  return binomialCoefficient(K, k) *
      binomialCoefficient(N - K, n - k) /
      binomialCoefficient(N, n);
}

num hypergeometricDistributionCdf(num k, DistributionParamsSetup params) {
  num cdf = 0;
  for (int i = 0; i <= k; i++) {
    cdf += hypergeometricDistributionPmf(i, params);
  }
  return cdf;
}

(int, int) hypergeometricDistributionRangeGetter(DistributionParamsSetup params) {
  final N = params.getValue('N') as int;
  final K = params.getValue('K') as int;
  final n = params.getValue('n') as int;

  final minK = max(0, n + K - N);
  final maxK = min(n, K);

  return (minK, maxK + 1);
}

num hypergeometricDistributionExpectedValue(DistributionParamsSetup params) {
  final N = params.getValue('N');
  final K = params.getValue('K');
  final n = params.getValue('n');
  return n * (K / N);
}

num hypergeometricDistributionVariance(DistributionParamsSetup params) {
  final N = params.getValue('N');
  final K = params.getValue('K');
  final n = params.getValue('n');
  return n * (K / N) * ((N - K) / N) * ((N - n) / (N - 1));
}

num hypergeometricDistributionStandardDeviation(DistributionParamsSetup params) {
  final variance = hypergeometricDistributionVariance(params);
  return sqrt(variance);
}

num hypergeometricDistributionMedian(DistributionParamsSetup params) {
  throw ParameterShouldBeComputedNumericallyException();
}

num hypergeometricDistributionMode(DistributionParamsSetup params) {
  final N = params.getValue('N');
  final K = params.getValue('K');
  final n = params.getValue('n');
  return ((n + 1) * (K + 1) / (N + 2)).floor();
}
