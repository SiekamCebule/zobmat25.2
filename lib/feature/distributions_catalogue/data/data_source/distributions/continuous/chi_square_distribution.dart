import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';
import 'package:data/data.dart' as data;

final chiSquareDistributionModel = DistributionModel(
  id: 'chi_square_distribution',
  name: 'Rozkład chi-kwadrat',
  shortDescription:
      'Rozkład używany w statystyce i analizie danych, oparty na sumie kwadratów odchyleń. Większe wartości wskazują na większe różnice, a mniejsze na lepsze dopasowanie. Pomaga ocenić zgodność danych z modelami i wykrywać odstępstwa.',
  type: DistributionType.continuous,
  parameters: [
    DistributionParameter(
      'degrees_of_freedom',
      'Stopnie swobody (k)',
      'Więcej stopni swobody (k) "rozciąga" rozkład. Możemy rozumieć je jako "liczbę niezależnych zmiennych"', // TODO
      min: 0.7,
      max: 245,
      defaultValue: 1,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Rozkład chi-kwadrat można opisać jako rozkład sumy kwadratów zmiennej losowej o rozkładzie normalnym (μ=0, σ=1).\n\nWyobraź sobie, że masz taki zbiór: {125, 111, 113, 134.5, 125, 128.5}. Musimy go ["zestandaryzować"](https://pl.wikipedia.org/wiki/Standaryzacja_(statystyka)), czyli doprowadzić do rozkładu normalnego (μ=0, σ=1). Wyjdzie coś takiego: {0.24,−1.30,−1.08,1.28,0.24,0.62}, gdzie poszczególne liczby oznaczają ilość odchyleń standardowych (σ) od średniej (czyli od zera).\nSuma KWADRATÓW owych liczb wynosi 5, czyli ilość ilość liczb (6) minus jeden. (nazywa się to stopniami swobody)',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);

num chiSquareDistributionPdf(num x, DistributionParamsSetup params) {
  final k = params.getValue('degrees_of_freedom');

  if (k <= 0) {
    throw ArgumentError("Degrees of freedom must be greater than 0.");
  }

  if (x < 0) return 0.0;

  //return pow(x, (k / 2) - 1) * exp(-x / 2) / (pow(2, k / 2) * data.gamma(k / 2));
  return pow(x, (k / 2) - 1) * exp(-x / 2) / (pow(2, k / 2) * gammaStirling(k / 2));
}

double gammaStirling(num x) {
  const double sqrtTwoPi = 2.5066282746310002; // sqrt(2 * pi)

  // Wyrazy poprawkowe Stirlinga
  final corrections = [
    1.0 / (12 * x),
    1.0 / (288 * x * x),
    -139.0 / (51840 * x * x * x),
    -571.0 / (2488320 * x * x * x * x),
    163879.0 / (209018880 * x * x * x * x * x),
    5246819.0 / (75246796800 * x * x * x * x * x * x),
  ];

  // Suma wyrazów poprawkowych
  double correctionSum = 1.0; // Początkowa wartość to 1 (stała w Stirlingu)
  for (final correction in corrections) {
    correctionSum += correction;
  }

  // Przybliżenie Stirlinga
  return sqrtTwoPi * pow(x, x - 0.5) * exp(-x) * correctionSum;
}

double gammaApprox(num x) {
  if (x < 0.5) {
    return pi / (sin(pi * x) * gammaApprox(1 - x));
  }
  return sqrt(2 * pi) * pow(x, x - 0.5) * exp(-x);
}

double autoOptimizedGamma(num x) {
  const eulerGamma = 0.5772156649015329;
  if (x > 0 && x < 1) {
    return (1 / x) - eulerGamma + (x / 2);
  }
  return gammaApprox(x); // W innych przypadkach użyj Lanczosa.
}

num chiSquareDistributionCdf(num x, DistributionParamsSetup params) {
  final k = params.getValue('degrees_of_freedom');

  if (k <= 0) {
    throw ArgumentError("Degrees of freedom must be greater than 0.");
  }

  if (x < 0) return 0.0;

  return data.lowRegGamma(k / 2, x / 2);
}

num chiSquareDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final k = params.getValue('degrees_of_freedom');

  if (k <= 0) {
    throw ArgumentError("Degrees of freedom must be greater than 0.");
  }

  if (p <= 0 || p >= 1) {
    throw ArgumentError("Probability (p) must be in the range (0, 1).");
  }

  return data.gammapInv(p, k / 2) * 2;
}
