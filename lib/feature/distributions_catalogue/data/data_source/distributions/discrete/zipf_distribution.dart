import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/distribution_property_undefined_exception.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

final zipfDistributionModel = DiscreteDistributionModel(
  id: 'zipf_distribution',
  name: 'Rozkład Zipfa',
  shortDescription:
      'Rozkład opisujący częstość występowania elementów w uporządkowanych zbiorach, gdzie niewiele elementów występuje bardzo często, a większość rzadko. Jest stosowany do modelowania rozkładów słów w języku naturalnym, popularności stron internetowych czy dystrybucji dochodów.',
  parameters: [
    DistributionParameter(
      's',
      'Kształt (s)',
      '''Określa kształt wykresu.
Dla s>0, wykres jest malejący (np. występowanie poszczególnych słów w języku).
Dla s=0, wykres jest stały (każdy rekord ma takie samo prawdopodobieństwo).
Dla s<0, wykres jest rosnący (im dalsza ranga w zbiorze, tym większe prawdopodobieństwo).
      ''',
      min: -100000,
      max: 100000,
      defaultValue: 1,
    ),
    DistributionParameter(
      'N',
      'Ilość rekordów (N)',
      'Określa, ile rekordów bierzemy pod uwage.',
      min: 1,
      max: 100000,
      defaultValue: 15,
      isInteger: true,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Rozkład Zipfa modeluje prawdopodobieństwo występowania pewnych rekordów, np. słów w języku. Ciekawą właściwością rozkładu Zipfa jest to, że zmieniając paarametr kształtu (s), wykres może być malejący, rosnący, a nawet stały.',
        containsMarkdownLinks: true,
      ),
      DistributionDescriptionMathExpression(
        title: 'Masa prawdopodobieństwa',
        data:
            r'P(X = k) = \frac{k^{-s}}{\sum_{n=1}^{N} n^{-s}}, \quad k = 1, 2, \dots, N',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(k) = \frac{\sum_{n=1}^{k} n^{-s}}{\sum_{n=1}^{N} n^{-s}}, \quad k = 1, 2, \dots, N',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data:
            r'\mathbb{E}[X] = \frac{\sum_{k=1}^{N} k^{1-s}}{\sum_{k=1}^{N} k^{-s}}, \quad \text{dla } s > 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data:
            r'\sigma = \sqrt{\frac{\sum_{k=1}^{N} k^{2-s}}{\sum_{k=1}^{N} k^{-s}} - \left(\frac{\sum_{k=1}^{N} k^{1-s}}{\sum_{k=1}^{N} k^{-s}}\right)^2}, \quad \text{dla } s > 2',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data:
            r'\text{Var}(X) = \frac{\sum_{k=1}^{N} k^{2-s}}{\sum_{k=1}^{N} k^{-s}} - \left(\frac{\sum_{k=1}^{N} k^{1-s}}{\sum_{k=1}^{N} k^{-s}}\right)^2, \quad \text{dla } s > 2',
      ),

      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'Me \approx 2^{\frac{1}{s}}',
      ),
      DistributionDescriptionMathExpression(title: 'Moda', data: r'Mo = 1'),
      DistributionDescriptionParagraph(
        text:
            'Intrygujące jest to, że [częstość występowania najpopularniejszych słów w językach świata układa się w rozkład Zipfa o parametrze s równym 1](https://en.wikipedia.org/wiki/Zipf%27s_law#Word_frequencies_in_natural_languages). Przeanalizowano m.in. teksty niemieckie, rosyjskie, włoskie, francuskie, a także teksty religijne - arabski Koran, hebrajską Torę i łacińskie księgi Nowego Testamentu. Wszędzie słowa układały się wg tego samego schematu.\nCo ciekawe, rozkład Zipfa jest wykorzystywany w analizie tekstu w celu przypisania autorstwa.',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);
num zipfDistributionPmf(int k, DistributionParamsSetup params) {
  final s = params.getValue('s');
  final N = params.getValue('N') as int;

  if (k < 1 || k > N) return 0;

  num normalizingConstant = 0;
  for (int n = 1; n <= N; n++) {
    normalizingConstant += pow(n, -s);
  }

  return pow(k, -s) / normalizingConstant;
}

num zipfDistributionCdf(num k, DistributionParamsSetup params) {
  final s = params.getValue('s');
  final N = params.getValue('N') as int;

  if (k < 1) return 0;
  if (k > N) return 1;

  num normalizingConstant = 0;
  for (int n = 1; n <= N; n++) {
    normalizingConstant += pow(n, -s);
  }

  num cumulativeSum = 0;
  for (int n = 1; n <= k; n++) {
    cumulativeSum += pow(n, -s);
  }

  return cumulativeSum / normalizingConstant;
}

(int, int) zipfDistributionRangeGetter(DistributionParamsSetup params) {
  final N = params.getValue('N') as int;
  return (1, N + 1);
}

num zipfDistributionExpectedValue(DistributionParamsSetup params) {
  final s = params.getValue('s');
  final N = params.getValue('N') as int;

  if (s <= 1) {
    throw DistributionPropertyUndefinedException();
  }

  num numerator = 0;
  num denominator = 0;
  for (int k = 1; k <= N; k++) {
    numerator += k * pow(k, -s);
    denominator += pow(k, -s);
  }

  return numerator / denominator;
}

num zipfDistributionVariance(DistributionParamsSetup params) {
  final s = params.getValue('s');
  final N = params.getValue('N') as int;

  if (s <= 2) {
    throw DistributionPropertyUndefinedException();
  }

  num numerator1 = 0;
  num numerator2 = 0;
  num denominator = 0;

  for (int k = 1; k <= N; k++) {
    numerator1 += pow(k, 2 - s);
    numerator2 += pow(k, 1 - s);
    denominator += pow(k, -s);
  }

  return (numerator1 / denominator) - pow(numerator2 / denominator, 2);
}

num zipfDistributionStandardDeviation(DistributionParamsSetup params) {
  return sqrt(zipfDistributionVariance(params));
}

num zipfDistributionMedian(DistributionParamsSetup params) {
  final s = params.getValue('s');
  return pow(2, 1 / s);
}

num zipfDistributionMode(DistributionParamsSetup params) {
  return 1;
}
