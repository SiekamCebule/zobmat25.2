import 'dart:math';

import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

final laplaceDistributionModel = ContinuousDistributionModel(
  id: 'laplace_distribution',
  name: 'Rozkład Laplace\'a',
  shortDescription:
      'Symetryczny rozkład w kształcie "szczupłego dzwonu", który ma szersze ogony niż rozkład normalny.',

  parameters: [
    DistributionParameter(
      'mean',
      'Średnia (μ)',
      'Jest "środkiem" rozkładu. Jednocześnie oznacza też największą i najbardziej prawdopodobną wartość.',
      min: -100000,
      max: 100000,
      defaultValue: 0,
    ),
    DistributionParameter(
      'scale',
      'Skala (b)',
      'Określa szerokość rozkładu. Im większa skala, tym wartości są bardziej "rozciągnięte" na boki.',
      min: 0.0001,
      max: 10000,
      defaultValue: 1,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Rozkład Laplace\'a można porównać do "zaostrzonego" rozkładu normalnego. Różni się on tym, że ma grubsze "ogony", przez co wartości skrajne są bardziej prawdopodobne.\n\nParametr lokalizacji (μ) jest tym samym co średnia w rozkładzie normalnym.\n\nParametr skali (b) rozciąga wykres podobnie jak odchylenie standardowe (σ) w rozkładzie normalnym, ale NIE są to takie same rzeczy. Odchylenie standardowe liczy się z wzoru, który podano niżej.',
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data: r'f(x) = \frac{1}{2b} e^{-\frac{|x-\mu|}{b}}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(x) = \begin{cases} \frac{1}{2} e^{\frac{x-\mu}{b}}, & \text{dla } x < \mu, \\ 1 - \frac{1}{2} e^{-\frac{x-\mu}{b}}, & \text{dla } x \geq \mu, \end{cases}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odwrotna dystrybuanta',
        data:
            r'F^{-1}(p) = \begin{cases} \mu + b \ln(2p), & \text{dla } 0 < p \leq 0.5, \\ \mu - b \ln(2(1-p)), & \text{dla } 0.5 < p < 1, \end{cases}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = \mu',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \sqrt{2}b',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = 2b^2',
      ),
      DistributionDescriptionMathExpression(title: 'Mediana', data: r'Me = \mu'),
      DistributionDescriptionMathExpression(title: 'Moda', data: r'Mo = \mu'),

      DistributionDescriptionParagraph(
        text:
            'Ogólnie rzecz biorąc, rozkład Laplace\'a jest wykorzystywany w hydrologii (maksymalna wysokość rzeki w roku), w finansach, w przetwarzaniu mowy i obrazów, a także w prywatności różniczkowej.\nPewnie zastanawiasz się, czym jest prywatność różniczkowa. Aplikacja zbiera dane o liczbie kroków. Aby chronić prywatność, algorytm dodaje losowy szum (np. \u00B1500 kroków) z rozkładu Laplace’a. Dzięki temu nikt nie pozna twoich prawdziwych danych, ale średnia kroków w mieście nadal będzie dokładna, bo szumy się znoszą.\n\nAby przeczytać więcej o zastosowaniach tego rozkładu, [kliknij tutaj (Wikipedia)](https://en.wikipedia.org/wiki/Laplace_distribution#Occurrence_and_applications).',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);

num laplaceDistributionPdf(num x, DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  final scale = params.getValue('scale');

  if (scale <= 0) {
    throw ArgumentError("Scale parameter must be greater than 0.");
  }

  return (1 / (2 * scale)) * exp(-((x - mean).abs()) / scale);
}

num laplaceDistributionCdf(num x, DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  final scale = params.getValue('scale');

  if (scale <= 0) {
    throw ArgumentError("Scale parameter must be greater than 0.");
  }

  if (x < mean) {
    return 0.5 * exp((x - mean) / scale);
  } else {
    return 1 - 0.5 * exp(-(x - mean) / scale);
  }
}

num laplaceDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  final scale = params.getValue('scale');

  if (scale <= 0) {
    throw ArgumentError("Scale parameter must be greater than 0.");
  }

  if (p <= 0 || p >= 1) {
    throw ArgumentError('Probability (p) must be in the range (0, 1).');
  }

  if (p < 0.5) {
    return mean + scale * log(2 * p);
  } else {
    return mean - scale * log(2 * (1 - p));
  }
}

(num, num) laplaceDistributionRangeGetter(DistributionParamsSetup params) {
  const prob = 0.00001;

  return (
    findQuantile(cdf: laplaceDistributionCdf, params: params, targetProbability: prob),
    findQuantile(
      cdf: laplaceDistributionCdf,
      params: params,
      targetProbability: 1 - prob,
    ),
  );
}

num laplaceDistributionExpectedValue(DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  return mean;
}

num laplaceDistributionVariance(DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  return 2 * pow(scale, 2);
}

num laplaceDistributionStandardDeviation(DistributionParamsSetup params) {
  final variance = laplaceDistributionVariance(params);
  return sqrt(variance);
}

num laplaceDistributionMedian(DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  return mean;
}

num laplaceDistributionMode(DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  return mean;
}
