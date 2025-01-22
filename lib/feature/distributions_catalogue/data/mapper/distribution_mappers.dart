import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/continuous_distribution_functions.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/discrete_distribution_functions.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/distribution_property_functions.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/discrete_distribution.dart';

ContinuousDistribution continuousDistributionFromModel(
  ContinuousDistributionModel model, {
  required ContinuousDistributionFunctions functions,
  required DistributionPropertyFunctions propertyFunctions,
}) {
  return ContinuousDistribution(
    id: model.id,
    name: model.name,
    shortDescription: model.shortDescription,
    functions: functions,
    propertyFunctions: propertyFunctions,
    parameters: model.parameters,
    extendedDescription: model.extendedDescription,
  );
}

DiscreteDistribution discreteDistributionFromModel(
  DiscreteDistributionModel model, {
  required DiscreteDistributionFunctions functions,
  required DistributionPropertyFunctions propertyFunctions,
}) {
  return DiscreteDistribution(
    id: model.id,
    name: model.name,
    shortDescription: model.shortDescription,
    functions: functions,
    propertyFunctions: propertyFunctions,
    parameters: model.parameters,
    extendedDescription: model.extendedDescription,
  );
}
