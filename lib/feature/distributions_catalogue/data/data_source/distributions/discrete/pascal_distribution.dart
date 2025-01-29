import 'dart:math';

import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_text_span.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

final pascalDistributionModel = DiscreteDistributionModel(
  id: 'pascal_distribution',
  name: 'Rozkład Pascala',
  shortDescription:
      'Rozkład dyskretny opisujący liczbę niepowodzeń przed osiągnięciem określonej liczby sukcesów w serii niezależnych prób Bernoulliego. Stosowany w analizie procesów powtarzanych aż do osiągnięcia określonej liczby sukcesów.',
  parameters: [
    DistributionParameter(
      'r',
      'Ilość wymaganych sukcesów (r)',
      'Liczba sukcesów które muszą wystąpić do zakończenia procesu.',
      min: 1,
      max: 1000,
      defaultValue: 3,
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
      DistributionDescriptionTextSpan(
        children: [
          DistributionDescriptionParagraph(
            text:
                'Rozkład Pascala jest często nazywany "ujemnym rozkładem dwumianowym". Jest on uogólnieniem rozkładu geometrycznego i opisuje on ilość nieudanych prób Bernoulliego przed osiągnięciem r sukcesów. Ważne jest to, że ',
          ),
          DistributionDescriptionParagraph(
            text: 'nie modeluje on całkowitej ilości prób',
            bold: true,
          ),
          DistributionDescriptionParagraph(
            text:
                ', ale ilość porażek do osiągnięcia r sukcesów. Jeśli chcemy znać ilość prób, wystarczy dodać do siebie ilość porażek (to co opisuje rozkład) i oczekiwaną przez nas ilość sukcesów.',
          ),
        ],
      ),
      DistributionDescriptionMathExpression(
        title: 'Masa prawdopodobieństwa',
        data: r'P(X = k) = \binom{k + r - 1}{k} p^r (1 - p)^k, \quad k \geq 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data: r'F(k; r, p) = I_{1 - p}(k + 1, r), \quad k \geq 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = \frac{r(1 - p)}{p}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \sqrt{\frac{r(1 - p)}{p^2}}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = \frac{r(1 - p)}{p^2}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data:
            r'Me \approx \frac{r(1 - p)}{p} - \frac{1}{3} + \frac{0.02}{r(1 - p) / p + 0.1}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Moda',
        data: r'Mo = \lfloor \frac{r - 1}{1 - p} \rfloor',
      ),

      DistributionDescriptionParagraph(
        text:
            'Rozkład Pascala może być stosowany w zarządzaniu projektami, w kontroli jakości, w obsłudze klienta, w marketingu, w zarządzaniu zapasami czy w zarządzaniu ryzykiem.\n\nRozkład ten może być alternatywą dla rozkładu Poissona, jeśli szukamy rozkładu z większą wariancją niż średnia (wariancja w rozkładzie Poissona jest równa średniej). Innymi słowy, jeśli ilość zdarzeń ma się znacząco różnić, lepszy będzie rozkład Pascala, nie Poissona.\n\n[Kliknij tutaj](https://en.wikipedia.org/wiki/Negative_binomial_distribution#Occurrence_and_applications), aby dowiedzieć się więcej o zastosowaniach tego rozkładu.',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);

num pascalDistributionPmf(int k, DistributionParamsSetup params) {
  final r = params.getValue('r') as int;
  final p = params.getValue('p');

  if (p <= 0 || p > 1) {
    throw ArgumentError("Probability p must be in the range (0,1].");
  }
  if (k < 0) return 0;

  num coefficient = 1.0;
  for (int i = 0; i < k; i++) {
    coefficient *= (r + i) / (i + 1);
  }

  return coefficient * pow(p, r) * pow(1 - p, k);
}

num pascalDistributionCdf(num k, DistributionParamsSetup params) {
  final p = params.getValue('p');

  if (p <= 0 || p > 1) {
    throw ArgumentError("Probability p must be in the range (0,1].");
  }

  num cdf = 0;
  for (int i = 0; i <= k; i++) {
    cdf += pascalDistributionPmf(i, params);
  }
  return cdf;
}

(int, int) pascalDistributionRangeGetter(DistributionParamsSetup params) {
  final upper = findDiscreteUpperBound(0.000001, params, pascalDistributionPmf);
  return (0, upper);
}

num pascalDistributionExpectedValue(DistributionParamsSetup params) {
  final r = params.getValue('r') as int;
  final p = params.getValue('p');

  if (p <= 0 || p > 1) {
    throw ArgumentError("Probability p must be in the range (0,1].");
  }

  return (r * (1 - p)) / p;
}

num pascalDistributionVariance(DistributionParamsSetup params) {
  final r = params.getValue('r') as int;
  final p = params.getValue('p');

  if (p <= 0 || p > 1) {
    throw ArgumentError("Probability p must be in the range (0,1].");
  }

  return (r * (1 - p)) / (p * p);
}

num pascalDistributionStandardDeviation(DistributionParamsSetup params) {
  return sqrt(pascalDistributionVariance(params));
}

num pascalDistributionMedian(DistributionParamsSetup params) {
  final r = params.getValue('r') as int;
  final p = params.getValue('p');

  if (p <= 0 || p > 1) {
    throw ArgumentError("Probability p must be in the range (0,1].");
  }

  return ((r * (1 - p)) / p) - (1 / 3) + (0.02 / ((r * (1 - p)) / p + 0.1));
}

num pascalDistributionMode(DistributionParamsSetup params) {
  final r = params.getValue('r') as int;
  final p = params.getValue('p');

  if (p <= 0 || p > 1) {
    throw ArgumentError("Probability p must be in the range (0,1].");
  }

  return (r - 1) ~/ (1 - p);
}
