import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_description_ui.dart';
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
      'Więcej stopni swobody (k) "rozciąga" rozkład. Możemy rozumieć je jako "liczbę niezależnych zmiennych"',
      min: 0.0001,
      max: 245,
      defaultValue: 1,
    ),
  ],
  extendedDescription: DistributionDescriptionUi(),
  applicationsDescription: DistributionDescriptionUi(),
);

num chiSquareDistributionPdf(num x, DistributionParamsSetup params) {
  final k = params.getValue('degrees_of_freedom');

  if (k <= 0) {
    throw ArgumentError("Degrees of freedom must be greater than 0.");
  }

  if (x < 0) return 0.0;

  return pow(x, (k / 2) - 1) * exp(-x / 2) / (pow(2, k / 2) * data.gamma(k / 2));
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
