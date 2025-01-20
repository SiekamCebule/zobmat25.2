import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_text_span.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter_rule.dart';

final uniformDistributionModel = ContinuousDistributionModel(
  id: 'uniform_continuous_distribution',
  name: 'Rozkład ciągły jednostajny',
  shortDescription:
      'Prosty rozkład, gdzie każda wartość ma taką samą gęstość prawdopodobieństwa.',

  parameters: [
    DistributionParameter(
      'start',
      'Początek (a)',
      'Od jakiego miejsca gęstość prawdopodobieństwa jest niezerowa.',
      min: -10000000,
      max: 10000000,
      defaultValue: 0,
      rules: [DistributionParameterNotHigherRule(otherParameterId: 'end')],
    ),
    DistributionParameter(
      'end',
      'Koniec (b)',
      'Do jakiego miejsca gęstość prawdopodobieństwa jest niezerowa.',
      min: -10000000,
      max: 10000000,
      defaultValue: 1,
      rules: [DistributionParameterHigherRule(otherParameterId: 'start')],
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'W tym rozkładzie każda wartość z przedziału od a do b ma taką samą gęstość prawdopodobieństwa.',
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data:
            r'f(x) = \begin{cases} \frac{1}{b - a}, & \text{dla } x \in [a, b], \\0, & \text{w przeciwnym wypadku.}\end{cases}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(x) = \begin{cases} 0, & \text{dla } x < a, \\\frac{x - a}{b - a}, & \text{dla } x \in [a, b], \\1, & \text{dla } x > b.\end{cases}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odwrotna dystrybuanta',
        data: r'F^{-1}(x) = a + x \cdot (b - a), \quad \text{dla } x \in [0, 1]',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = \frac{a + b}{2}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \sqrt{\text{Var}(X)} = \sqrt{\frac{(b - a)^2}{12}}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = \frac{(b - a)^2}{12}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'Me = \frac{a + b}{2}',
      ),
      DistributionDescriptionMathExpression(title: 'Moda', data: r'Mo = \text{BRAK}'),

      DistributionDescriptionTextSpan(
        children: [
          DistributionDescriptionParagraph(
            text:
                'Rozkład ciągły jednostajny jest ważny przy generowaniu liczb losowych z innych rozkładów (co zostało wykorzystane na tej stronie). Używa się go w symulacjach ',
          ),
          DistributionDescriptionParagraph(
            text: 'Monte Carlo',
            websiteUrl: 'https://pl.wikipedia.org/wiki/Metoda_Monte_Carlo',
          ),
          DistributionDescriptionParagraph(
            text:
                ', w kryptografii, a także w grach komputerowych (losowanie ze skrzynek, generowanie pozycji obiektów na mapie).',
          ),
        ],
      ),
    ],
  ),
);

num uniformDistributionPdf(num x, DistributionParamsSetup params) {
  final start = params.getValue('start');
  final end = params.getValue('end');

  if (x >= start && x <= end) {
    return 1;
  }
  return 0;
}

num uniformDistributionCdf(num x, DistributionParamsSetup params) {
  final start = params.getValue('start');
  final end = params.getValue('end');

  if (x < start) {
    return 0;
  } else if (x > end) {
    return 1;
  } else {
    return (x - start) / (end - start);
  }
}

num uniformDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final start = params.getValue('start');
  final end = params.getValue('end');

  if (p < 0 || p > 1) {
    throw ArgumentError('Probability p must be in the range [0, 1].');
  }

  return start + p * (end - start);
}
