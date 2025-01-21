import 'package:equatable/equatable.dart';

import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

class DistributionParamsSetup with EquatableMixin {
  const DistributionParamsSetup({required this.values});

  final Map<DistributionParameter, num> values;

  num getValue(String parameterId) {
    try {
      final key = values.keys.singleWhere((param) => parameterId == param.id);
      return values[key]!;
    } catch (error) {
      throw ArgumentError(
        'DistributionParamsSetup does not have \'$parameterId\' parameter',
      );
    }
  }

  DistributionParameter getParameter(String parameterId) {
    return values.keys.singleWhere((parameter) => parameter.id == parameterId);
  }

  @override
  List<Object?> get props => [values];

  DistributionParamsSetup copyWith({Map<DistributionParameter, num>? values}) {
    return DistributionParamsSetup(values: values ?? this.values);
  }
}
