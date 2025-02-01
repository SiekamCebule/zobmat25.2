import 'dart:math';

import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/distribution_property_undefined_exception.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

final paretoDistributionModel = ContinuousDistributionModel(
  id: 'pareto_distribution',
  name: 'Rozkład Pareta',
  shortDescription:
      'Rozkład potęgowy często używany do modelowania zjawisk, w których niewielka liczba zdarzeń dominuje, np. rozkład bogactwa, wielkość miast czy liczba połączeń w sieciach.',

  parameters: [
    DistributionParameter(
      'scale',
      'Skala (x\u2098)',
      '"Rozciąga" lub "zawęża" rozkład, przez co wartości są mniejsze lub większe, bez zmiany kształtu rozkładu.',
      min: 0.0001,
      max: 100000,
      defaultValue: 1.0,
    ),
    DistributionParameter(
      'shape',
      'Kształt (k)',
      'Parametr kształtu (k) wpływa na "dominację" małych wartości. Jeśli zwiększymy k, mniejsze wartości będą jeszcze bardziej dominujące. Jeśli zmniejszymy k, będzie więcej wysokich wartości (jakby więcej osób było bogatych).',
      min: 0.0001,
      max: 100000,
      defaultValue: 1.0,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Możliwe, że słyszałeś o [zasadzie Pareta](https://pl.wikipedia.org/wiki/Zasada_Pareta). Opisuje ona sytuację, w której np. 80% bogactwa należy do 20% ludzi, lub 20% decyzji powoduje 80% skutków. Zasada ta jest stosowana m.in. w socjologii, w ustalaniu priorytetów i w biznesie.\n\nRozkład Pareta działa na identycznej zasadzie. Parametr kształtu (k) modyfikuje "dominację" małych wartości - im wyższe k, tym nasze "80 procent" jest jeszcze większe. Za to małe k zwiększa szansę na skrajne wartości ("bogactwo" staje się powszechniejsze wśród ludności).',
        containsMarkdownLinks: true,
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data:
            r'f(x; x_m, \alpha) = \frac{\alpha x_m^\alpha}{x^{\alpha+1}}, \quad x \geq x_m',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(x; x_m, \alpha) = 1 - \left(\frac{x_m}{x}\right)^\alpha, \quad x \geq x_m',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data:
            r'\mathbb{E}[X] = \begin{cases} \frac{\alpha x_m}{\alpha - 1}, & \alpha > 1 \\ \text{BRAK}, & \alpha \leq 1 \end{cases}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data:
            r'\sigma = \begin{cases} \frac{x_m \sqrt{\alpha}}{(\alpha - 1)\sqrt{\alpha - 2}}, & \alpha > 2 \\ \text{BRAK}, & \alpha \leq 2 \end{cases}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data:
            r'\text{Var}(X) = \begin{cases} \frac{x_m^2 \alpha}{(\alpha - 1)^2 (\alpha - 2)}, & \alpha > 2 \\ \text{BRAK}, & \alpha \leq 2 \end{cases}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'Me = x_m 2^{1/\alpha}',
      ),
      DistributionDescriptionMathExpression(title: 'Moda', data: r'Mo = x_m'),

      DistributionDescriptionParagraph(
        text:
            'W rozkład Pareta układają się m.in. wielkości meteorytów, rozmiary osad ludzkich, wielkości plików przesyłane protokołem TCP, wielkości ziaren piasku i czas spędzony w poszczególnych grach przez użytkownika na Steam.',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);
num paretoDistributionPdf(num x, DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  final shape = params.getValue('shape');

  if (scale <= 0 || shape <= 0) {
    throw ArgumentError("Scale (x_m) and shape (α) parameters must be greater than 0.");
  }
  if (x < scale) return 0;

  return (shape * pow(scale, shape)) / pow(x, shape + 1);
}

num paretoDistributionCdf(num x, DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  final shape = params.getValue('shape');

  if (scale <= 0 || shape <= 0) {
    throw ArgumentError("Scale (x_m) and shape (α) parameters must be greater than 0.");
  }
  if (x < scale) return 0;

  return 1 - pow(scale / x, shape);
}

num paretoDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  final shape = params.getValue('shape');

  if (scale <= 0 || shape <= 0) {
    throw ArgumentError("Scale (x_m) and shape (α) parameters must be greater than 0.");
  }
  if (p <= 0 || p >= 1) {
    throw ArgumentError("Probability (p) must be in the range (0, 1).");
  }

  return scale / pow(1 - p, 1 / shape);
}

(num, num) paretoDistributionRangeGetter(DistributionParamsSetup params) {
  const prob = 0.000001;

  return (
    findQuantile(cdf: paretoDistributionCdf, params: params, targetProbability: prob),
    findQuantile(cdf: paretoDistributionCdf, params: params, targetProbability: 1 - prob),
  );
}

num paretoDistributionExpectedValue(DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  final shape = params.getValue('shape');

  if (shape <= 1) {
    throw DistributionPropertyUndefinedException();
  }

  return (shape * scale) / (shape - 1);
}

num paretoDistributionVariance(DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  final shape = params.getValue('shape');

  if (shape <= 2) {
    throw DistributionPropertyUndefinedException();
  }

  return (scale * scale * shape) / ((shape - 1) * (shape - 1) * (shape - 2));
}

num paretoDistributionStandardDeviation(DistributionParamsSetup params) {
  return sqrt(paretoDistributionVariance(params));
}

num paretoDistributionMedian(DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  final shape = params.getValue('shape');

  return scale * pow(2, 1 / shape);
}

num paretoDistributionMode(DistributionParamsSetup params) {
  final scale = params.getValue('scale');
  return scale;
}
