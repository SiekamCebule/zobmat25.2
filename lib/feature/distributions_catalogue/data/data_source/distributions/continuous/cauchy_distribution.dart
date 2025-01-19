import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

final cauchyDistributionModel = DistributionModel(
  id: 'cauchy_distribution',
  name: 'Rozkład Cauchy\'ego',
  shortDescription:
      'Rozkład charakteryzujący się bardzo grubymi ogonami, modelujący procesy, gdzie wartości ekstremalne są znacznie bardziej prawdopodobne, takie jak błędy w pomiarach w bliskim polu lub rezonanse mechaniczne',
  type: DistributionType.continuous,
  parameters: [
    DistributionParameter(
      'location',
      'Położenie (x\u2080)',
      'Jest "środkiem" rozkładu (nie mylić ze średnią, która w rozkładzie Cauchy\'ego nie istnieje).',
      min: -100000,
      max: 100000,
      defaultValue: 0.0,
    ),
    DistributionParameter(
      'scale',
      'Skala (γ)',
      'Określa szerokość rozkładu. Im większa skala, tym wartości są bardziej "rozciągnięte" na boki.',
      min: 0.001,
      defaultValue: 1.0,
      max: 150,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Rozkład Cauchy\'ego charakteryzuje się skrajnie szerokimi "ogonami". Spróbuj wylosować liczby (używając przycisku nad wykresem), a przekonasz się, że wiele wartości znacząco odbiega od średniej. Właśnie dlatego rozkład Cauchy\'ego nie ma zdefiniowanej średniej ([wartości oczekiwanej](https://pl.wikipedia.org/wiki/Warto%C5%9B%C4%87_oczekiwana)) ani [wariancji](https://pl.wikipedia.org/wiki/Wariancja).',
        containsMarkdownLinks: true,
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data:
            r'f(x; x_0, \gamma) = \frac{1}{\pi \gamma \left[1 + \left(\frac{x - x_0}{\gamma}\right)^2\right]}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(x; x_0, \gamma) = \frac{1}{\pi} \arctan\left(\frac{x - x_0}{\gamma}\right) + \frac{1}{2}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odwrotna dystrybuanta',
        data:
            r'F^{-1}(x; x_0, \gamma) = x_0 + \gamma \cdot \tan\left[\pi \left(x - \frac{1}{2}\right)\right], \quad x \in (0, 1)',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana, odchylenie standardowe, wariancja',
        data: r"\text{BRAK}",
      ),
      DistributionDescriptionMathExpression(title: 'Mediana', data: r'Me = x_0'),
      DistributionDescriptionMathExpression(title: 'Moda', data: r'Mo = x_0'),
      DistributionDescriptionParagraph(
        text:
            'Mimo że znaczaco różni się od innych rozkładów, jest wykorzystywany w hydrologii (maksymalne jednodniowe opady deszczu), w fizyce jądrowej, w spektroskopii, w mechanice kwantowej, [w biologii](https://stats.stackexchange.com/a/436727). Został nawet użyty do modelowania zmian umiejętności skoczków narciarskich w grze [SJ Manager](https://github.com/SiekamCebule/sj-manager).',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);
// https://en.wikipedia.org/wiki/Cauchy_distribution
// https://www.quora.com/What-are-the-uses-of-the-Cauchy-distribution-Why-is-it-so-important
// https://stats.stackexchange.com/questions/229474/practical-applications-of-the-laplace-and-cauchy-distributions

num cauchyDistributionPdf(num x, DistributionParamsSetup params) {
  final location = params.getValue('location');
  final scale = params.getValue('scale');

  if (scale <= 0) {
    throw ArgumentError("Scale parameter must be greater than 0.");
  }

  final pi = 3.141592653589793;
  final numerator = scale;
  final denominator = pi * (pow(x - location, 2) + pow(scale, 2));
  return numerator / denominator;
}

num cauchyDistributionCdf(num x, DistributionParamsSetup params) {
  final location = params.getValue('location');
  final scale = params.getValue('scale');

  if (scale <= 0) {
    throw ArgumentError("Scale parameter must be greater than 0.");
  }

  final pi = 3.141592653589793;

  if (x - location > 1e6) return 1.0;
  if (x - location < -1e6) return 0.0;

  return 0.5 + (1 / pi) * atan((x - location) / scale);
}

num cauchyDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final location = params.getValue('location');
  final scale = params.getValue('scale');

  if (scale <= 0) {
    throw ArgumentError("Scale parameter must be greater than 0.");
  }

  if (p <= 0 || p >= 1) {
    throw ArgumentError("Probability (p) must be in the range (0, 1).");
  }

  final pi = 3.141592653589793;
  return location + scale * tan(pi * (p - 0.5));
}
