import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

final cauchyDistributionModel = DistributionModel(
  id: 'cauchy_distribution',
  name: 'Rozkład Cauchy\'ego',
  shortDescription:
      'Rozkład charakteryzujący się szerokimi ogonami, modelujący procesy, gdzie wartości ekstremalne są znacznie bardziej prawdopodobne, takie jak błędy w pomiarach w bliskim polu lub rezonanse mechaniczne',
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
      'Określa "szerokość" rozkładu. Im większa skala, tym wartości są bardziej "rozciągnięte" na boki.',
      min: 0.001,
      defaultValue: 1.0,
      max: 150,
    ),
  ],
  extendedDescription: DistributionDescription(components: []),
);

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
