import 'package:zobmat25_2/core/distribution_math_typedefs.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';

Distribution distributionFromModel(
  DistributionModel model, {
  required DistributionPdf pdf,
  required DistributionCdf cdf,
}) {
  return Distribution(
    name: model.name,
    shortDescription: model.shortDescription,
    pdf: pdf,
    cdf: cdf,
    type: model.type,
    parameters: model.parameters,
    extendedDescription: model.extendedDescription,
    applicationsDescription: model.applicationsDescription,
  );
}
