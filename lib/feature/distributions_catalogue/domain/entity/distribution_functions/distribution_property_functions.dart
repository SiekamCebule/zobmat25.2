import 'package:equatable/equatable.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';

class DistributionPropertyFunctions with EquatableMixin {
  const DistributionPropertyFunctions({
    required this.expectedValue,
    required this.variance,
    required this.standardDeviation,
    required this.median,
    required this.mode,
  });

  final num Function(DistributionParamsSetup params) expectedValue;
  final num Function(DistributionParamsSetup params) variance;
  final num Function(DistributionParamsSetup params) standardDeviation;
  final num Function(DistributionParamsSetup params) median;
  final num Function(DistributionParamsSetup params) mode;

  num Function(DistributionParamsSetup params) functionById(String id) {
    return switch (id) {
      'expectedValue' => expectedValue,
      'variance' => variance,
      'standardDeviation' => standardDeviation,
      'median' => median,
      'mode' => mode,
      _ => throw ArgumentError('Invalid distribution property function ID: $id'),
    };
  }

  @override
  List<Object?> get props => [expectedValue, variance, standardDeviation, median, mode];
}
