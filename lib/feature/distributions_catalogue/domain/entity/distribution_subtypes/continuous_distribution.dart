import 'package:zobmat25_2/core/distribution_function_typedefs.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

class ContinuousDistribution extends Distribution {
  const ContinuousDistribution({
    required super.id,
    required super.name,
    required super.shortDescription,
    required super.extendedDescription,
    required super.parameters,
    required this.pdf,
    required this.cdf,
    required this.inverseCdf,
  });

  final ContinuousDistributionPdf pdf; // f(x), funkcja gęstości prawdopodobieństwa
  final ContinuousDistributionCdf
  cdf; // F(x), funkcja rozkładu skumulowanego (dystrybuanta)
  final ContinuousDistributionInverseCdf
  inverseCdf; // F-1(p) funkcja kwantylowa (odwrotna dystrybuanta)

  @override
  DistributionType get type => DistributionType.continuous;

  @override
  List<Object?> get props => [super.props, pdf, cdf, inverseCdf];
}
