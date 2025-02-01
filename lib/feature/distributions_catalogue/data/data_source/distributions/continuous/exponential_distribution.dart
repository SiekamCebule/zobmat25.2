import 'dart:math';

import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

final exponentialDistributionModel = ContinuousDistributionModel(
  id: 'exponential_distribution',
  name: 'Rozkład wykładniczy',
  shortDescription:
      'Modeluje czas oczekiwania na pierwsze zdarzenie w procesie, w którym zdarzenia występują losowo, ale ze stałym prawdopodobieństwem w jednostce czasu, takie jak czas do nadejścia połączenia telefonicznego lub awarii urządzenia.',

  parameters: [
    DistributionParameter(
      'lambda',
      'Lambda (λ)',
      'Jest to "tempo", z jakim występuje zdarzenie. Wpływa na szybkość zaniku prawdopodobieństwa w miarę oddalania się od zera. Przykłady? 20 autobusów dziennie: λ=20. Jeden autobus na 5 godzin: λ=0.2.',
      min: 0.0001,
      max: 100000,
      defaultValue: 1.0,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Na rozkład wykładniczy popatrzmy tak: wyobraź sobie autobus, który przyjeżdża średnio 2 razy na godzinę. Rozkład modeluje prawdopodobieństwo, że będziesz wciąż czekał po upływie jakiegoś czasu.\n\nJakie jest prawdopodobieństwo, że autobus przyjedzie w 30 minut? Możesz sprawdzić to na wykresie dystrybuanty licząc 1 - F(x), gdzie x to czas (np. 0.5 dla 30 minut, jeśli lambda to ilość autobusów na godzinę).\n\nLambda (λ) to jedyny parametr rozkładu. Jest to ilość zdarzeń w jednostce czasu (λ = 5, jeśli pięć na dzień/godzinę/minutę).\n\nWażną cechą rozkładu wykładniczego jest "brak pamięci". Oznacza to, że ilość czasu spędzonego na czekaniu nie wpływa na prawdopodobieństwo zdarzenia w następnej chwili.',
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data: r'f(x; \lambda) = \lambda e^{-\lambda x}, \quad x \geq 0',
        type: DistributionDescriptionExpressionType.display,
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data: r'F(x; \lambda) = 1 - e^{-\lambda x}, \quad x \geq 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odwrotna dystrybuanta',
        data: r'F^{-1}(p; \lambda) = -\frac{\ln(1-p)}{\lambda}, \quad 0 \leq p < 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = \frac{1}{\lambda}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \frac{1}{\lambda}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = \frac{1}{\lambda^2}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'Me = \frac{\ln(2)}{\lambda}',
      ),
      DistributionDescriptionMathExpression(title: 'Moda', data: r'Mo = 0'),
      DistributionDescriptionParagraph(
        text:
            'Rozkład wykładniczy pozwala przewidzieć czas do awarii, czas na połączenie telefoniczne w call center, czy czas między mutacjami genetycznymi. Jest też wykorzystywany w fizyce i w hydrologii. Uogólnieniem tego rozkładu jest rozkład gamma, który również jest dostępny w katalogu.',
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

(num, num) exponentialDistributionRangeGetter(DistributionParamsSetup params) {
  const prob = 0.00001;

  return (
    findQuantile(
      cdf: exponentialDistributionCdf,
      params: params,
      targetProbability: prob,
    ),
    findQuantile(
      cdf: exponentialDistributionCdf,
      params: params,
      targetProbability: 1 - prob,
    ),
  );
}

num exponentialDistributionExpectedValue(DistributionParamsSetup params) {
  final lambda = params.getValue('lambda');

  return 1 / lambda;
}

num exponentialDistributionVariance(DistributionParamsSetup params) {
  final lambda = params.getValue('lambda');

  return 1 / pow(lambda, 2);
}

num exponentialDistributionStandardDeviation(DistributionParamsSetup params) {
  final variance = exponentialDistributionVariance(params);

  return sqrt(variance);
}

num exponentialDistributionMedian(DistributionParamsSetup params) {
  final lambda = params.getValue('lambda');

  return log(2) / lambda;
}

num exponentialDistributionMode(DistributionParamsSetup params) {
  return 0;
}
