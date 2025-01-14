import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

final exponentialDistributionModel = DistributionModel(
  id: 'exponential_distribution',
  name: 'Rozkład wykładniczy',
  shortDescription:
      'Modeluje czas oczekiwania na pierwsze zdarzenie w procesie, w którym zdarzenia występują losowo, ale ze stałym prawdopodobieństwem w jednostce czasu, takie jak czas do nadejścia połączenia telefonicznego lub awarii urządzenia.',
  type: DistributionType.continuous,
  parameters: [
    DistributionParameter(
      'lambda',
      'Lambda (λ)',
      'Można powiedzieć, że jest to "tempo", z jakim występuje zdarzenie. Wpływa na szybkość zaniku prawdopodobieństwa w miarę oddalania się od zera.',
      min: 0.0001,
      max: 100000,
      defaultValue: 1.0,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Na rozkład wykładniczy popatrzmy tak: wyobraź sobie autobus, który przyjeżdża średnio 2 razy na godzinę. Rozkład modeluje prawdopodobieństwo, że będziesz wciąż czekał po upływie jakiegoś czasu. Jakie jest prawdopodobieństwo, że autobus przyjedzie w 30 minut? Możesz sprawdzić to na wykresie dystrybuanty licząc 1 - F(x), gdzie x to czas (np. 0.5 dla 30 minut, jeśli lambda to ilość autobusów na godzinę). Lambda (λ) to jedyny parametr rozkładu. Jest to ilość zdarzeń w jednostce czasu (λ = 5, jeśli pięć na dzień/godzinę/minutę). Ważną cechą rozkładu wykładniczego jest "brak pamięci". Oznacza to, że ilość czasu spędzonego na czekaniu nie wpływa na prawdopodobieństwo zdarzenia w następnej chwili.',
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data: r'f(x; \lambda) = \lambda e^{-\lambda x}, \quad x \geq 0',
        type: DistributionDescriptionExpressionType.display,
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data: r'F(x; \lambda) = 1 - e^{-\lambda x}, \quad x \geq 0',
        type: DistributionDescriptionExpressionType.text,
      ),
      DistributionDescriptionMathExpression(
        title: 'Odwrotna dystrybuanta',
        data: r'F^{-1}(p; \lambda) = -\frac{\ln(1-p)}{\lambda}, \quad 0 \leq p < 1',
        type: DistributionDescriptionExpressionType.text,
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = \frac{1}{\lambda}',
        type: DistributionDescriptionExpressionType.text,
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \frac{1}{\lambda}',
        type: DistributionDescriptionExpressionType.text,
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = \frac{1}{\lambda^2}',
        type: DistributionDescriptionExpressionType.text,
      ),
      DistributionDescriptionParagraph(
        text:
            'Uogólnieniem tego rozkładu jest rozkład gamma, który równiez możesz sprawdzić. Rozkład wykładniczy ma swoje zastosowania. Pozwala przewidzieć czas do awarii, czas na połączenie telefoniczne w call center, czas między mutacjami genetycznymi. Jest wykorszystywany w fizyce i w hydrologii.',
      ),
    ],
  ),
);

num exponentialDistributionPdf(num x, DistributionParamsSetup params) {
  final lambda = params.getValue('lambda');

  if (lambda <= 0) {
    throw ArgumentError("Lambda parameter must be greater than 0.");
  }

  if (x < 0) return 0.0;

  return lambda * exp(-lambda * x);
}

num exponentialDistributionCdf(num x, DistributionParamsSetup params) {
  final lambda = params.getValue('lambda');

  if (lambda <= 0) {
    throw ArgumentError("Lambda parameter must be greater than 0.");
  }

  if (x < 0) return 0.0;

  return 1 - exp(-lambda * x);
}

num exponentialDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final lambda = params.getValue('lambda');

  if (lambda <= 0) {
    throw ArgumentError("Lambda parameter must be greater than 0.");
  }

  if (p <= 0 || p >= 1) {
    throw ArgumentError("Probability (p) must be in the range (0, 1).");
  }

  return -log(1 - p) / lambda;
}
