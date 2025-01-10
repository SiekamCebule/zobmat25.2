import 'package:equatable/equatable.dart';

import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

class DistributionParamsSetup with EquatableMixin {
  const DistributionParamsSetup({required this.values});

  final Map<DistributionParameter, double> values;

  double getValue(String parameter) {
    try {
      final key = values.keys.singleWhere((param) => parameter == param.id);
      return values[key]!;
    } catch (error) {
      throw ArgumentError(
        'DistributionParamsSetup does not have \'$parameter\' parameter',
      );
    }
  }

  @override
  List<Object?> get props => [values];

  DistributionParamsSetup copyWith({Map<DistributionParameter, double>? values}) {
    return DistributionParamsSetup(values: values ?? this.values);
  }
}
