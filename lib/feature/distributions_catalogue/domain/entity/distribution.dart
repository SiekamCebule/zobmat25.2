import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/core/distribution_math_typedefs.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_description_ui.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

class Distribution extends Equatable {
  const Distribution({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.pdf,
    required this.cdf,
    required this.inverseCdf,
    required this.type,
    required this.parameters,
    required this.extendedDescription,
    required this.applicationsDescription,
  });

  final String id;
  final String name;
  final String shortDescription;
  final DistributionPdf pdf; // f(x), funkcja gęstości prawdopodobieństwa
  final DistributionCdf cdf; // F(x), funkcja rozkładu skumulowanego (dystrybuanta)
  final DistributionInverseCdf
  inverseCdf; // F-1(p) funkcja kwantylowa (odwrotna dystrybuanta)
  final DistributionType type;
  final List<DistributionParameter> parameters;
  final DistributionDescriptionUi extendedDescription; // Opis
  final DistributionDescriptionUi? applicationsDescription; // Zastosowania i ciekawostki

  @override
  List<Object?> get props => [
    name,
    shortDescription,
    pdf,
    cdf,
    type,
    parameters,
    extendedDescription,
    applicationsDescription,
  ];
}
