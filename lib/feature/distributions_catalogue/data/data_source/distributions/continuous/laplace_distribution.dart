import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_description_ui.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

final laplaceDistributionModel = DistributionModel(
  id: 'laplace_distribution',
  name: 'Rozkład Laplace\'a',
  shortDescription:
      'Symetryczny rozkład w kształcie "szczupłego dzwonu", który ma szersze ogony niż rozkład normalny.',
  type: DistributionType.continuous,
  parameters: [
    DistributionParameter(
      'location',
      'Położenie (μ)',
      'Jest "środkiem" rozkładu. Jednocześnie oznacza też największą i najbardziej prawdopodobną wartość.',
      min: -100000,
      max: 100000,
      defaultValue: 0,
    ),
    DistributionParameter(
      'scale',
      'Skala (b)',
      'Określa "szerokość" rozkładu. Im większa skala, tym wartości są bardziej "rozciągnięte" na boki.',
      min: 0.0001,
      max: 10000,
      defaultValue: 1,
    ),
  ],
  extendedDescription: DistributionDescriptionUi(),
  applicationsDescription: DistributionDescriptionUi(),
);

num laplaceDistributionPdf(num x, DistributionParamsSetup params) {
  final location = params.getValue('location');
  final scale = params.getValue('scale');

  if (scale <= 0) {
    throw ArgumentError("Scale parameter must be greater than 0.");
  }

  return (1 / (2 * scale)) * exp(-((x - location).abs()) / scale);
}

num laplaceDistributionCdf(num x, DistributionParamsSetup params) {
  final location = params.getValue('location');
  final scale = params.getValue('scale');

  if (scale <= 0) {
    throw ArgumentError("Scale parameter must be greater than 0.");
  }

  if (x < location) {
    return 0.5 * exp((x - location) / scale);
  } else {
    return 1 - 0.5 * exp(-(x - location) / scale);
  }
}

num laplaceDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final location = params.getValue('location');
  final scale = params.getValue('scale');

  if (scale <= 0) {
    throw ArgumentError("Scale parameter must be greater than 0.");
  }

  if (p <= 0 || p >= 1) {
    throw ArgumentError('Probability (p) must be in the range (0, 1).');
  }

  if (p < 0.5) {
    return location + scale * log(2 * p);
  } else {
    return location - scale * log(2 * (1 - p));
  }
}
