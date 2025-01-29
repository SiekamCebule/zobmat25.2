import 'dart:math';

import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_bulleted_list.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

final poissonDistributionModel = DiscreteDistributionModel(
  id: 'poisson_distribution',
  name: 'Rozkład Poissona',
  shortDescription:
      'Rozkład modelujący liczbę zdarzeń występujących w ustalonym przedziale czasu lub przestrzeni, gdy zdarzenia te występują z określoną średnią częstotliwością i są niezależne.',
  parameters: [
    DistributionParameter(
      'lambda',
      'Częstotliwość zdarzeń (λ)',
      'Jest to średnia ilość zdarzeń na jednostkę czasu, tak samo jak w rozkładzie wykładniczym.',
      min: 0.001,
      max: 100000,
      defaultValue: 1,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Przy zgłębianiu tego rozkładu warto dowiedzieć się, czym jest [proces Poissona](https://pl.wikipedia.org/wiki/Proces_Poissona). Proces Poissona jest modelem opisującym występowanie zdarzeń w czasie,  takich że zdarzenia te są niezależne, a czas między kolejnymi zdarzeniami jest opisany [rozkładem wykładniczym](https://pl.wikipedia.org/wiki/Rozk%C5%82ad_wyk%C5%82adniczy). Rozkład Poissona jest powiązany z tym procesem i opisuje prawdopodobieństwo określonej ilości zdarzeń w jednostce czasu, jeśli czas oczekiwania jest opisany właśnie rozkładem wykładniczym.',
        containsMarkdownLinks: true,
      ),
      DistributionDescriptionMathExpression(
        title: 'Masa prawdopodobieństwa',
        data: r'P(X = k) = \frac{\lambda^k e^{-\lambda}}{k!}, \quad k = 0,1,2,\dots',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(k; \lambda) = e^{-\lambda} \sum_{i=0}^{k} \frac{\lambda^i}{i!}, \quad k \geq 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = \lambda',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \sqrt{\lambda}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = \lambda',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'Me \approx \lfloor \lambda + \frac{1}{3} - \frac{0.02}{\lambda} \rfloor',
      ),
      DistributionDescriptionMathExpression(
        title: 'Moda',
        data:
            r'Mo = \lfloor \lambda \rfloor, \quad \text{dla} \quad \lambda \notin \mathbb{Z} \quad \text{lub} \quad \{\lambda, \lambda - 1\} \quad \text{dla} \quad \lambda \in \mathbb{Z}',
      ),
      DistributionDescriptionParagraph(
        text: 'Niektóre z zastosowań rozkładu Poissona to:',
        containsMarkdownLinks: true,
      ),
      DistributionDescriptionBulletedList(
        items: [
          DistributionDescriptionParagraph(
            text: 'modelowanie liczby mutacji na nici DNA na jednostkę długości',
            containsMarkdownLinks: true,
          ),
          DistributionDescriptionParagraph(
            text:
                'modelowanie ilości rozpadów w danym przedziale czasu w próbce radioaktywnej',
            containsMarkdownLinks: true,
          ),
          DistributionDescriptionParagraph(
            text: 'modelowanie ilości połączeń do call center w ciągu minuty',
            containsMarkdownLinks: true,
          ),
          DistributionDescriptionParagraph(
            text:
                'modelowanie ilości bramek drużyny piłkarskiej w meczu ([dowiedz się więcej](https://bukmacher.org/rozklad-poissona-prognozuj-liczbe-goli-i-zwyciezce-meczu/?utm_source=chatgpt.com)). [Kliknij tutaj](https://sinceawin.com/data/tools/poisson), aby wejść na stronę modelującą szansę na wynik w meczu piłkarskim.',
            containsMarkdownLinks: true,
          ),
          DistributionDescriptionParagraph(
            text:
                'modelowanie ilości żołnierzy zabitych od kopnięć końskich rocznie w każdym korpusie pruskiej kawalerii (XIX wiek).',
          ),
          DistributionDescriptionParagraph(
            text:
                '[Kliknij tutaj](https://en.wikipedia.org/wiki/Poisson_distribution#Occurrence_and_applications), aby otworzyć obszerną listę zastosowań rozkładu Poissona (angielska Wikipedia)',
            containsMarkdownLinks: true,
          ),
        ],
      ),
    ],
  ),
);
num poissonDistributionPmf(int k, DistributionParamsSetup params) {
  final lambda = params.getValue('lambda');

  if (lambda <= 0) {
    throw ArgumentError("Lambda must be greater than 0.");
  }
  if (k < 0) return 0;

  if (k == 0) {
    return exp(-lambda); // P(X=0) = e^(-lambda)
  }

  num pPrev = exp(-lambda); // Start od P(X=0)
  num p = pPrev;

  for (int i = 1; i <= k; i++) {
    p = (lambda / i) * pPrev; // Korzystamy z rekurencji
    pPrev = p;
  }

  return p;
}

num poissonDistributionCdf(num k, DistributionParamsSetup params) {
  final lambda = params.getValue('lambda');

  if (lambda <= 0) {
    throw ArgumentError("Lambda must be greater than 0.");
  }

  num cdf = 0;
  for (int i = 0; i <= k; i++) {
    cdf += poissonDistributionPmf(i, params);
  }
  return cdf;
}

(int, int) poissonDistributionRangeGetter(DistributionParamsSetup params) {
  final upper = findDiscreteUpperBound(0.000001, params, poissonDistributionPmf);
  return (0, upper);
}

num poissonDistributionExpectedValue(DistributionParamsSetup params) {
  return params.getValue('lambda');
}

num poissonDistributionVariance(DistributionParamsSetup params) {
  return params.getValue('lambda');
}

num poissonDistributionStandardDeviation(DistributionParamsSetup params) {
  return sqrt(params.getValue('lambda'));
}

num poissonDistributionMedian(DistributionParamsSetup params) {
  final lambda = params.getValue('lambda');

  return (lambda + (1 / 3) - (0.02 / lambda)).floor();
}

num poissonDistributionMode(DistributionParamsSetup params) {
  final lambda = params.getValue('lambda');

  if (lambda.floor() == lambda) {
    return [lambda, lambda - 1].reduce((a, b) => a > b ? a : b);
  } else {
    return lambda.floor();
  }
}
