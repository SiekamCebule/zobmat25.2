import 'package:equatable/equatable.dart';

abstract class DistributionAnalysisParameterValue with EquatableMixin {
  const DistributionAnalysisParameterValue();

  factory DistributionAnalysisParameterValue.fromNum(num number) {
    return switch (number) {
      double.infinity => DistributionAnalysisParameterInfinityValue(),
      double.negativeInfinity => DistributionAnalysisParameterInfinityValue(
        negative: true,
      ),
      _ => DistributionAnalysisParameterNumberValue(number),
    };
  }

  num toNum();
}

class DistributionAnalysisParameterNumberValue
    extends DistributionAnalysisParameterValue {
  const DistributionAnalysisParameterNumberValue(this.value);

  final num value;

  @override
  num toNum() => value;

  @override
  List<Object?> get props => [value];
}

class DistributionAnalysisParameterInfinityValue
    extends DistributionAnalysisParameterValue {
  const DistributionAnalysisParameterInfinityValue({this.negative = false});

  final bool negative;

  @override
  num toNum() => negative ? double.negativeInfinity : double.infinity;

  @override
  List<Object?> get props => [negative];
}
