import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
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
  extendedDescription: DistributionDescription(components: []),
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
