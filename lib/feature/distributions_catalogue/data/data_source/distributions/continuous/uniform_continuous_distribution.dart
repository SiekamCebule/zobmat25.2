import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_text_span.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/distribution_property_undefined_exception.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter_rule.dart';

final uniformContinuousDistributionModel = ContinuousDistributionModel(
  id: 'uniform_continuous_distribution',
  name: 'Rozkład ciągły jednostajny',
  shortDescription:
      'Prosty rozkład, gdzie każda wartość ma taką samą gęstość prawdopodobieństwa.',

  parameters: [
    DistributionParameter(
      'a',
      'Początek (a)',
      'Od jakiego miejsca gęstość prawdopodobieństwa jest niezerowa.',
      min: -10000000,
      max: 10000000,
      defaultValue: 0,
      rules: [DistributionParameterNotHigherRule(otherParameterId: 'b')],
    ),
    DistributionParameter(
      'b',
      'Koniec (b)',
      'Do jakiego miejsca gęstość prawdopodobieństwa jest niezerowa.',
      min: -10000000,
      max: 10000000,
      defaultValue: 1,
      rules: [DistributionParameterHigherRule(otherParameterId: 'a')],
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

num uniformContinuousDistributionPdf(num x, DistributionParamsSetup params) {
  final a = params.getValue('a');
  final b = params.getValue('b');

  if (x >= a && x <= b) {
    return 1;
  }
  return 0;
}

num uniformContinuousDistributionCdf(num x, DistributionParamsSetup params) {
  final a = params.getValue('a');
  final b = params.getValue('b');

  if (x < a) {
    return 0;
  } else if (x > b) {
    return 1;
  } else {
    return (x - a) / (b - a);
  }
}

num uniformContinuousDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final a = params.getValue('a');
  final b = params.getValue('b');

  if (p < 0 || p > 1) {
    throw ArgumentError('Probability p must be in the range [0, 1].');
  }

  return a + p * (b - a);
}

num uniformContinuousDistributionExpectedValue(DistributionParamsSetup params) {
  final a = params.getValue('a');
  final b = params.getValue('b');
  if (a >= b) {
    throw ArgumentError("Parameter 'a' must be less than 'b'.");
  }
  return (a + b) / 2;
}

num uniformContinuousDistributionVariance(DistributionParamsSetup params) {
  final a = params.getValue('a');
  final b = params.getValue('b');
  if (a >= b) {
    throw ArgumentError("Parameter 'a' must be less than 'b'.");
  }
  return pow(b - a, 2) / 12;
}

num uniformContinuousDistributionStandardDeviation(DistributionParamsSetup params) {
  final a = params.getValue('a');
  final b = params.getValue('b');
  if (a >= b) {
    throw ArgumentError("Parameter 'a' must be less than 'b'.");
  }
  return sqrt(pow(b - a, 2) / 12);
}

num uniformContinuousDistributionMedian(DistributionParamsSetup params) {
  final a = params.getValue('a');
  final b = params.getValue('b');
  if (a >= b) {
    throw ArgumentError("Parameter 'a' must be less than 'b'.");
  }
  return (a + b) / 2;
}

num uniformContinuousDistributionMode(DistributionParamsSetup params) {
  throw DistributionPropertyUndefinedException();
}
