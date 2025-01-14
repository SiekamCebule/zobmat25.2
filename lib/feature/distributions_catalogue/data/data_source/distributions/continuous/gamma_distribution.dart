import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_text_span.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';
import 'package:data/data.dart';

final gammaDistributionModel = DistributionModel(
  id: 'gamma_distribution',
  name: 'Rozkład gamma',
  shortDescription:
      'Uogólnienie rozkładu wykładniczego. Modeluje czas oczekiwania na kilka zdarzeń w procesie, w którym zdarzenia występują losowo, ale ze stałym prawdopodobieństwem w jednostce czasu (np. czas do przyjazdu 3 tramwajów)',
  type: DistributionType.continuous,
  parameters: [
    DistributionParameter(
      'shape',
      'Kształt (k)',
      'Jest to ilość zdarzeń, na które oczekujemy. Dla k=1 powstaje rozkład wykładniczy.',
      min: 0.0001,
      max: 100000,
      defaultValue: 1.0,
    ),
    DistributionParameter(
      'scale',
      'Skala (θ)',
      'Jest to przeciętny czas na wystąpienie pojedynczego zdarzenia. θ=2 może na przykład oznaczać, że tramwaj przyjeżdża 2 razy na godzinę,',
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
        type: DistributionDescriptionExpressionType.display,
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(x; k, \theta) = \frac{\gamma(k, \frac{x}{\theta})}{\Gamma(k)}, \quad x > 0',
        type: DistributionDescriptionExpressionType.text,
      ),
      DistributionDescriptionMathExpression(
        title: 'Odwrotna dystrybuanta',
        data: 'BRAK',
        type: DistributionDescriptionExpressionType.text,
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = k\theta',
        type: DistributionDescriptionExpressionType.text,
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \sqrt{k}\theta',
        type: DistributionDescriptionExpressionType.text,
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = k\theta^2',
        type: DistributionDescriptionExpressionType.text,
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
