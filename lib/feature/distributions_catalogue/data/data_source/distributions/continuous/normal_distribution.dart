import 'dart:math';

import 'package:zobmat25_2/core/math/erf.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

final normalDistributionModel = DistributionModel(
  id: 'normal_distribution',
  name: 'Rozkład normalny',
  shortDescription:
      'Symetryczny rozkład w kształcie dzwonu opisujący wiele naturalnych zjawisk, takich jak wzrost, waga czy wyniki testów, gdzie wartości bliskie średniej występują częściej niż wartości skrajne.',
  type: DistributionType.continuous,
  parameters: [
    DistributionParameter(
      'mean',
      'Średnia (μ)',
      'Jest "środkiem" rozkładu, czyli punktem, wokół którego wartości są symetrycznie rozmieszczone. Na przykład, jeśli średnia wynosi 5, cały rozkład jest przesunięty na x = 5, co oznacza, że losowane wartości będą skupione wokół 5.',
      min: -100000,
      max: 100000,
      defaultValue: 0.0,
    ),
    DistributionParameter(
      'dev',
      'Odchylenie standardowe (σ)',
      'Jest miarą rozrzutu danych wokół średniej. Im większe odchylenie standardowe, tym bardziej wartości są rozproszone i oddalone od średniej.',
      min: 0.001,
      max: 10000,
      defaultValue: 1.0,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Rozkład normalny, zwany również rozkładem Gaussa, opisuje zjawiska, w których większość wyników koncentruje się wokół średniej, a liczba wyników oddalonych od niej maleje w sposób symetryczny.',
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data: r'f(x) = \frac{1}{\sqrt{2\pi\sigma^2}} e^{-\frac{(x-\mu)^2}{2\sigma^2}}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(x) = \frac{1}{2} \left[ 1 + \text{erf}\left(\frac{x-\mu}{\sqrt{2}\sigma}\right) \right]',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odwrotna dystrybuanta',
        data: r'F^{-1}(p) = \mu + \sigma \sqrt{2} \, \text{erf}^{-1}(2p - 1)',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = \mu',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \sqrt{\text{Var}(X)} = \sigma',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = \sigma^2',
      ),

      DistributionDescriptionParagraph(
        text:
            'Rozkład ten znalazł swoje zastosowania w modelowaniu cech populacji (np. rozkład wzrostu i wagi ludzi), w kontroli jakości produktów, analizie finansowej czy ocenie produktywności pracownika.',
      ),
    ],
  ),
);

num normalDistributionPdf(num x, DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  final dev = params.getValue('dev');

  if (dev <= 0) {
    throw ArgumentError("Standard deviation (dev) must be greater than 0.");
  }
  final sqrt2Pi = sqrt(2 * pi);
  final exponent = -pow((x - mean) / dev, 2) / 2;
  return (1 / (dev * sqrt2Pi)) * exp(exponent);
}

num normalDistributionCdf(num x, DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  final dev = params.getValue('dev');

  if (dev <= 0) {
    throw ArgumentError("Standard deviation (dev) must be greater than 0.");
  }

  final z = (x - mean) / (dev * sqrt(2));
  return 0.5 * (1 + erf(z));
}

num normalDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  final dev = params.getValue('dev');

  if (dev <= 0) {
    throw ArgumentError("Standard deviation (dev) must be greater than 0.");
  }

  if (p <= 0 || p >= 1) {
    throw ArgumentError("Probability (p) must be in the range (0, 1).");
  }

  const a1 = -3.969683028665376e+01;
  const a2 = 2.209460984245205e+02;
  const a3 = -2.759285104469687e+02;
  const a4 = 1.383577518672690e+02;
  const a5 = -3.066479806614716e+01;
  const a6 = 2.506628277459239e+00;

  const b1 = -5.447609879822406e+01;
  const b2 = 1.615858368580409e+02;
  const b3 = -1.556989798598866e+02;
  const b4 = 6.680131188771972e+01;
  const b5 = -1.328068155288572e+01;

  const c1 = -7.784894002430293e-03;
  const c2 = -3.223964580411365e-01;
  const c3 = -2.400758277161838e+00;
  const c4 = -2.549732539343734e+00;
  const c5 = 4.374664141464968e+00;
  const c6 = 2.938163982698783e+00;

  const d1 = 7.784695709041462e-03;
  const d2 = 3.224671290700398e-01;
  const d3 = 2.445134137142996e+00;
  const d4 = 3.754408661907416e+00;

  const pLow = 0.02425;
  const pHigh = 1 - pLow;

  double q, r;

  if (p < pLow) {
    q = sqrt(-2 * log(p));
    return mean +
        dev *
            (((((c1 * q + c2) * q + c3) * q + c4) * q + c5) * q + c6) /
            ((((d1 * q + d2) * q + d3) * q + d4) * q + 1);
  } else if (p > pHigh) {
    q = sqrt(-2 * log(1 - p));
    return mean +
        dev *
            -(((((c1 * q + c2) * q + c3) * q + c4) * q + c5) * q + c6) /
            ((((d1 * q + d2) * q + d3) * q + d4) * q + 1);
  } else {
    q = p - 0.5;
    r = q * q;
    return mean +
        dev *
            (((((a1 * r + a2) * r + a3) * r + a4) * r + a5) * r + a6) *
            q /
            (((((b1 * r + b2) * r + b3) * r + b4) * r + b5) * r + 1);
  }
}
