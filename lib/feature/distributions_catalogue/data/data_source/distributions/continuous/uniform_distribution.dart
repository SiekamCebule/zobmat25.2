import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_description_ui.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter_rule.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

final uniformDistributionModel = DistributionModel(
  id: 'uniform_distribution',
  name: 'Rozkład jednostajny',
  shortDescription:
      'Prosty rozkład, gdzie każda wartość ma taką samą gęstość prawdopodobieństwa.',
  type: DistributionType.continuous,
  parameters: [
    DistributionParameter(
      'start',
      'Początek (a)',
      'Od jakiego miejsca gęstość prawdopodobieństwa jest niezerowa.',
      min: -10000000,
      max: 10000000,
      defaultValue: 0,
      rules: [DistributionParameterNotHigherRule(otherParameterId: 'end')],
    ),
    DistributionParameter(
      'end',
      'Koniec (b)',
      'Do jakiego miejsca gęstość prawdopodobieństwa jest niezerowa.',
      min: -10000000,
      max: 10000000,
      defaultValue: 1,
      rules: [DistributionParameterHigherRule(otherParameterId: 'start')],
    ),
  ],
  extendedDescription: DistributionDescriptionUi(),
  applicationsDescription: DistributionDescriptionUi(),
);

num uniformDistributionPdf(num x, DistributionParamsSetup params) {
  final start = params.getValue('start');
  final end = params.getValue('end');

  if (x >= start && x <= end) {
    return 1;
  }
  return 0;
}

num uniformDistributionCdf(num x, DistributionParamsSetup params) {
  final start = params.getValue('start');
  final end = params.getValue('end');

  if (x < start) {
    return 0;
  } else if (x > end) {
    return 1;
  } else {
    return (x - start) / (end - start);
  }
}

num uniformDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final start = params.getValue('start');
  final end = params.getValue('end');

  if (p < 0 || p > 1) {
    throw ArgumentError('Probability p must be in the range [0, 1].');
  }

  return start + p * (end - start);
}
