import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/core/distribution_function_typedefs.dart';

class DiscreteDistributionFunctions with EquatableMixin {
  const DiscreteDistributionFunctions({
    required this.pmf,
    required this.cdf,
    required this.getChartRange,
  });

  final DiscreteDistributionPmf pmf; // f(x), funkcja masy prawdopodobieństwa
  final DiscreteDistributionCdf cdf; // f(x), dystrybuanta
  final DiscreteDistributionRangeGetter
  getChartRange; // Jaki jest najmniejszy i największy x jaki ma być widoczny na wykresie

  @override
  List<Object?> get props => [pmf, cdf, getChartRange];
}
