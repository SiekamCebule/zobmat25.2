import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/core/distribution_function_typedefs.dart';

class ContinuousDistributionFunctions with EquatableMixin {
  const ContinuousDistributionFunctions({
    required this.pdf,
    required this.cdf,
    required this.inverseCdf,
    required this.getChartRange,
  });

  final ContinuousDistributionPdf pdf; // f(x), funkcja gęstości prawdopodobieństwa
  final ContinuousDistributionCdf
  cdf; // F(x), funkcja rozkładu skumulowanego (dystrybuanta)
  final ContinuousDistributionInverseCdf
  inverseCdf; // F-1(p) funkcja kwantylowa (odwrotna dystrybuanta)
  final ContinuousDistributionRangeGetter
  getChartRange; // Jaki jest najmniejszy i największy x jaki ma być widoczny na wykresie

  @override
  List<Object?> get props => [pdf, cdf, inverseCdf, getChartRange];
}
