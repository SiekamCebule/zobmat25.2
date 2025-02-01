import 'dart:math';

import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_text_span.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/distribution_property_undefined_exception.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/parameter_should_be_computed_numerically_exception.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

import 'package:data/data.dart';

final gammaDistributionModel = ContinuousDistributionModel(
  id: 'gamma_distribution',
  name: 'Rozkład gamma',
  shortDescription:
      'Uogólnienie rozkładu wykładniczego. Modeluje czas oczekiwania na kilka zdarzeń w procesie, w którym zdarzenia występują losowo, ale ze stałym prawdopodobieństwem w jednostce czasu (np. czas do przyjazdu 3 tramwajów)',

  parameters: [
    DistributionParameter(
      'shape',
      'Kształt (k)',
      'Ilość zdarzeń, na które oczekujemy. Dla k=1 powstaje rozkład wykładniczy.',
      min: 0.0001,
      max: 100000,
      defaultValue: 1.0,
    ),
    DistributionParameter(
      'scale',
      'Skala (θ)',
      'Przeciętny czas na wystąpienie pojedynczego zdarzenia. θ=1 oznacza, że zdarzenie występuje raz na jedną jednostkę czasu. Odwrotnością skali (θ) jest tempo zdarzeń (λ), które występuje jako parametr w rozkładzie wykładniczym.',
      min: 0.0001,
      max: 100000,
      defaultValue: 1.0,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionTextSpan(
        children: [
          DistributionDescriptionParagraph(
            text:
                'Rozkład gamma opisuje oczekiwanie na określoną ilość zdarzeń, więdząc o średnim czasie na jedno zdarzenie. Inaczej możemy wyjaśnić to tak: rozkład gamma opisuje sumę k niezależnych czasów oczekiwania, z których każdy jest opisany rozkładem wykładniczym.\n\nParametr kształtu (k) oznacza ilość zdarzeń (np. czekamy na 5 pociągów), a parametr skali (θ) oznacza średni czas oczekiwania (np. pociągi przyjeżdżają ŚREDNIO co 30 minut).\n\nRozkład wykładniczy jest szczególnym przypadkiem rozkładu gamma, kiedy k=1 (gdzie czekamy tylko na jedno zdarzenie). Ważne jest to, że w rozkładzie gamma mamy ',
          ),
          DistributionDescriptionParagraph(text: 'średni czas oczekiwania', bold: true),
          DistributionDescriptionParagraph(text: ', a rozkładzie wykładniczym '),
          DistributionDescriptionParagraph(text: 'tempo zdarzeń (λ)', bold: true),
          DistributionDescriptionParagraph(
            text:
                ' (czyli odwrotność czasu oczekiwania, λ = 1/θ).\n\nJeśli słyszałeś o [procesie Poissona](https://pl.wikipedia.org/wiki/Proces_Poissona), rozkład gamma o parametrze kształtu równym k i parametrze skali równym θ, opisuje czas oczekiwania na k-te zdarzenie w procesie Poissona. Innymi słowy, jeśli chcesz sprawdzić ile będziesz czekał na k-te zdarzenie z kolei, użyj modelu wykładniczego o parametrze tempa zdarzeń (λ) równym 1/θ.',
            containsMarkdownLinks: true,
          ),
        ],
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data:
            r'f(x; k, \theta) = \frac{x^{k-1} e^{-\frac{x}{\theta}}}{\Gamma(k) \theta^k}, \quad x > 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(x; k, \theta) = \frac{\gamma(k, \frac{x}{\theta})}{\Gamma(k)}, \quad x > 0',
      ),
      DistributionDescriptionMathExpression(title: 'Odwrotna dystrybuanta', data: 'BRAK'),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = k\theta',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \sqrt{k}\theta',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = k\theta^2',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'Me \approx \text{wartość wyliczona numerycznie dla } F(x) = 0.5',
      ),
      DistributionDescriptionMathExpression(
        title: 'Moda',
        data:
            r'Mo = \begin{cases} (k - 1)\theta, & k > 1 \\ \text{BRAK}, & k \leq 1 \end{cases}',
      ),
      DistributionDescriptionParagraph(
        text:
            'Podobnie jak w przypadku rozkładu wykładniczego, rozkładu gamma używamy do szacowania czasu na wystąpienie zdarzeń. Różnica jest taka, że rozkładem wykładniczym opiszemy czas do awarii jednej żarówki, a w rozkładzie gamma przysłowiowych "żarówek" może być wiele. [Kliknij tutaj](https://en.wikipedia.org/wiki/Gamma_distribution#Occurrence_and_applications), aby dowiedzieć się więcej o zastosowaniach tego rozkładu (Wikipedia).',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);

num gammaDistributionPdf(num x, DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  if (shape <= 0 || scale <= 0) {
    throw ArgumentError("Shape and scale parameters must be greater than 0.");
  }

  if (x < 0) return 0.0;

  return pow(x, shape - 1) * exp(-x / scale) / (pow(scale, shape) * gamma(shape));
}

num gammaDistributionCdf(num x, DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  if (shape <= 0 || scale <= 0) {
    throw ArgumentError("Shape and scale parameters must be greater than 0.");
  }

  if (x < 0) return 0.0;

  return lowRegGamma(shape, x / scale);
}

num gammaDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  if (shape <= 0 || scale <= 0) {
    throw ArgumentError("Shape and scale parameters must be greater than 0.");
  }

  if (p <= 0 || p >= 1) {
    throw ArgumentError('Probability (p) must be in the range (0, 1).');
  }

  return gammapInv(p, shape) * scale;
}

(num, num) gammaDistributionRangeGetter(DistributionParamsSetup params) {
  const prob = 0.00001;

  return (
    findQuantile(cdf: gammaDistributionCdf, params: params, targetProbability: prob),
    findQuantile(cdf: gammaDistributionCdf, params: params, targetProbability: 1 - prob),
  );
}

num gammaDistributionExpectedValue(DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  return shape * scale;
}

num gammaDistributionVariance(DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  return shape * pow(scale, 2);
}

num gammaDistributionStandardDeviation(DistributionParamsSetup params) {
  final variance = gammaDistributionVariance(params);

  return sqrt(variance);
}

num gammaDistributionMedian(DistributionParamsSetup params) {
  throw ParameterShouldBeComputedNumericallyException();
}

num gammaDistributionMode(DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  if (shape > 1) {
    return (shape - 1) * scale;
  }
  throw DistributionPropertyUndefinedException();
}
