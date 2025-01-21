import 'package:zobmat25_2/core/distribution_function_typedefs.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/discrete_distribution.dart';

ContinuousDistribution continuousDistributionFromModel(
  ContinuousDistributionModel model, {
  required ContinuousDistributionPdf pdf,
  required ContinuousDistributionCdf cdf,
  required ContinuousDistributionInverseCdf inverseCdf,
}) {
  return ContinuousDistribution(
    id: model.id,
    name: model.name,
    shortDescription: model.shortDescription,
    pdf: pdf,
    cdf: cdf,
    inverseCdf: inverseCdf,
    parameters: model.parameters,
    extendedDescription: model.extendedDescription,
  );
}

DiscreteDistribution discreteDistributionFromModel(
  DiscreteDistributionModel model, {
  required DiscreteDistributionPmf pmf,
  required DiscreteDistributionCdf cdf,
  required DiscreteDistributionRangeGetter rangeGetter,
}) {
  return DiscreteDistribution(
    id: model.id,
    name: model.name,
    shortDescription: model.shortDescription,
    pmf: pmf,
    cdf: cdf,
    parameters: model.parameters,
    extendedDescription: model.extendedDescription,
    getChartRange: rangeGetter,
  );
}
