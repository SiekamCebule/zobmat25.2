import 'dart:math';

import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:data/data.dart' as data;

final weibullDistributionModel = ContinuousDistributionModel(
  id: 'weibull_distribution',
  name: 'Rozkład Weibulla',
  shortDescription:
      'Elastyczny rozkład opisujący czas życia obiektów, gdy prawdopodobieństwo śmierci/awarii zmienia się w czasie.',

  parameters: [
    DistributionParameter(
      'scale',
      'Skala (λ)',
      'Wpływa na rozciągnięcie lub ściśnięcie rozkładu na osi czasu. Wyższe λ oznacza dłuższe oczekiwanie na zdarzenie (przesuwa wartości w prawo), a niższe λ skraca czas oczekiwania (przesuwa wartości w lewo)',
      min: 0.001,
      max: 100000,
      defaultValue: 1.0,
    ),
    DistributionParameter(
      'shape',
      'Kształt (k)',
      'Określa sposób zachowania prawdopodobieństwa.\nDla k<1, ryzyko awarii spada w czasie (tak jakby obiekt psuł się przez ewentualne wady wrodzone, a nie przez starzenie się).\nDla k=1 (jest to rozkład wykładniczy), ryzyko jest stałe (tak jakby psucie się było procesem w pełni losowym).\nDla k=2 (jest to rozkład Rayleigha), ryzyko liniowo wzrasta.\nDla k>1, ryzyko rośnie z czasem (tak, jakby zużywały się części, albo jakby człowiek się starzał).',
      min: 0.001,
      max: 100000,
      defaultValue: 1.0,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Rozkład Weibulla jest wszechstronnym rozkładem prawdopodobieństwa, który modeluje czas oczekiwania na zdarzenia (podobnie jak rozkład gamma i rozkład wykładniczy).\nWażną rolę odgrywa w nim parametr kształtu (k), który określa zachowanie prawdopodobieństwa (spadające/rosnące/stałe). Kliknij ikonkę pomocy przy parametrze, aby lepiej go zrozumieć.\nParametr skali (λ) wydłuża lub skraca  typowy czas oczekiwania na zdarzenie.',
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data:
            r'f(x) = \frac{k}{\lambda} \left(\frac{x}{\lambda}\right)^{k-1} e^{-\left(\frac{x}{\lambda}\right)^k}, \, x \geq 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data: r'F(x) = 1 - e^{-\left(\frac{x}{\lambda}\right)^k}, \, x \geq 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odwrotna dystrybuanta',
        data: r'F^{-1}(p) = \lambda \left(-\ln(1-p)\right)^{1/k}, \, 0 \leq p \leq 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = \lambda \Gamma\left(1 + \frac{1}{k}\right)',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data:
            r'\sigma = \sqrt{\lambda^2 \left[\Gamma\left(1 + \frac{2}{k}\right) - \Gamma^2\left(1 + \frac{1}{k}\right)\right]}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data:
            r'\text{Var}(X) = \lambda^2 \left[\Gamma\left(1 + \frac{2}{k}\right) - \Gamma^2\left(1 + \frac{1}{k}\right)\right]',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'Me = \lambda \cdot (\ln(2))^{1/k}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Moda',
        data:
            r'Mo = \begin{cases} \lambda \cdot \left(\frac{k - 1}{k}\right)^{1/k}, & k > 1 \\ \text{BRAK}, & k \leq 1 \end{cases}',
      ),
      DistributionDescriptionParagraph(
        text:
            'Rozkład Weibulla jest powszechnie stosowany w analizie niezawodności i czasu życia. Dla k<1 opisuje awarie wynikające z wad produkcyjnych, dla k=1 opisuje losowe awarie, a dla k>1 opisuje awarie związane ze starzeniem/zużyciem.\nJest używany w medycynie, inżynierii, prognozie pogody, analizie spadku produkcji, i nie tylko. [Kliknij tutaj](https://en.wikipedia.org/wiki/Weibull_distribution#Applications), aby otworzyć długą listę zastosowań tego rozkładu (angielska wikipedia).',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);

num weibullDistributionPdf(num x, DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  final shape = params.getValue('shape');

  if (x < 0) {
    throw ArgumentError("Value (x) must be greater or equal to 0.");
  }

  if (scale <= 0) {
    throw ArgumentError("Scale parameter (scale) must be greater than 0.");
  }

  if (shape <= 0) {
    throw ArgumentError("Shape parameter (shape) must be greater than 0.");
  }

  return (shape / scale) * pow(x / scale, shape - 1) * exp(-pow(x / scale, shape));
}

num weibullDistributionCdf(num x, DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  final shape = params.getValue('shape');

  if (x < 0) {
    throw ArgumentError("Value (x) must be greater or equal to 0.");
  }

  if (scale <= 0) {
    throw ArgumentError("Scale parameter (scale) must be greater than 0.");
  }

  if (shape <= 0) {
    throw ArgumentError("Shape parameter (shape) must be greater than 0.");
  }

  return 1 - exp(-pow(x / scale, shape));
}

num weibullDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  final shape = params.getValue('shape');

  if (p < 0 || p > 1) {
    throw ArgumentError("Probability (p) must be in the range <0, 1>.");
  }

  if (scale <= 0) {
    throw ArgumentError("Scale parameter (scale) must be greater than 0.");
  }

  if (shape <= 0) {
    throw ArgumentError("Shape parameter (shape) must be greater than 0.");
  }

  return scale * pow(-log(1 - p), 1 / shape);
}

(num, num) weibullDistributionRangeGetter(DistributionParamsSetup params) {
  final shape = params.getValue('shape').toDouble();
  late final double prob;
  if (shape <= 1) {
    prob = 0.005;
  } else {
    prob = 0.0001;
  }

  return (
    findQuantile(cdf: weibullDistributionCdf, params: params, targetProbability: prob),
    findQuantile(
      cdf: weibullDistributionCdf,
      params: params,
      targetProbability: 1 - prob,
    ),
  );
}

num weibullDistributionExpectedValue(DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  return scale * data.gamma(1 + 1 / shape);
}

num weibullDistributionVariance(DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  final gamma1 = data.gamma(1 + 1 / shape);
  final gamma2 = data.gamma(1 + 2 / shape);

  return pow(scale, 2) * (gamma2 - pow(gamma1, 2));
}

num weibullDistributionStandardDeviation(DistributionParamsSetup params) {
  final variance = weibullDistributionVariance(params);

  return sqrt(variance);
}

num weibullDistributionMedian(DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  final shape = params.getValue('shape');

  return scale * pow(log(2), 1 / shape);
}

num weibullDistributionMode(DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  if (shape > 1) {
    return scale * pow((shape - 1) / shape, 1 / shape);
  }
  return 0;
}
