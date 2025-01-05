import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_description_ui.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

class DistributionModel {
  const DistributionModel({
    required this.name,
    required this.shortDescription,
    required this.type,
    required this.parameters,
    required this.extendedDescription,
    required this.applicationsDescription,
  });

  final String name;
  final String shortDescription;
  final DistributionType type;
  final List<DistributionParameter> parameters;
  final DistributionDescriptionUi extendedDescription; // Opis
  final DistributionDescriptionUi? applicationsDescription; // Zastosowania i ciekawostki
}
