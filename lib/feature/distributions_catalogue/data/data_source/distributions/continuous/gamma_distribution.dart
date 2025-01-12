import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_description_ui.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';
import 'package:data/data.dart';

final gammaDistributionModel = DistributionModel(
  id: 'gamma_distribution',
  name: 'Rozkład gamma',
  shortDescription:
      'Uogólnienie rozkładu wykładniczego. Modeluje czas oczekiwania na kilka zdarzeń w procesie, w którym zdarzenia występują losowo, ale ze stałym prawdopodobieństwem w jednostce czasu (np. czas do przyjazdu 3 tramwajów)',
  type: DistributionType.continuous,
  parameters: [
    DistributionParameter(
      'shape',
      'Kształt (α)',
      'Jest to ilość zdarzeń, na które oczekujemy. Dla α=1 powstaje rozkład wykładniczy.',
      min: 0.0001,
      max: 100000,
      defaultValue: 1.0,
    ),
    DistributionParameter(
      'scale',
      'Skala (θ)',
      'Jest to przeciętny czas na wystąpienie pojedynczego zdarzenia. θ=2 może na przykład oznaczać, że tramwaj przyjeżdża 2 razy na godzinę,',
      min: 0.0001,
      max: 100000,
      defaultValue: 1.0,
    ),
  ],
  extendedDescription: DistributionDescriptionUi(),
  applicationsDescription: DistributionDescriptionUi(),
);

num gammaDistributionPdf(num x, DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  if (shape <= 0 || scale <= 0) {
    throw ArgumentError("Shape and scale parameters must be greater than 0.");
  }

  if (x < 0) return 0.0;

  return pow(x, shape - 1) * exp(-x / scale) / (pow(scale, shape) * gamma(shape));
}

num gammaDistributionCdf(num x, DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  if (shape <= 0 || scale <= 0) {
    throw ArgumentError("Shape and scale parameters must be greater than 0.");
  }

  if (x < 0) return 0.0;

  return lowRegGamma(shape, x / scale);
}

num gammaDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final shape = params.getValue('shape');
  final scale = params.getValue('scale');

  if (shape <= 0 || scale <= 0) {
    throw ArgumentError("Shape and scale parameters must be greater than 0.");
  }

  if (p <= 0 || p >= 1) {
    throw ArgumentError('Probability (p) must be in the range (0, 1).');
  }

  return gammapInv(p, shape) * scale;
}
