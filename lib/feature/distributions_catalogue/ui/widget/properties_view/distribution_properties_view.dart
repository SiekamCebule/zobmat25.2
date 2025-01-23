import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/distribution_property_undefined_exception.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/parameter_should_be_computed_numerically_exception.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/properties_view/distribution_property_list_item.dart';

class DistributionPropertiesView extends StatelessWidget {
  const DistributionPropertiesView({
    super.key,
    required this.distribution,
    required this.paramsSetup,
  });

  final Distribution distribution;
  final DistributionParamsSetup paramsSetup;

  @override
  Widget build(BuildContext context) {
    dynamic getValueForProperty(String propertyId) {
      final propertyFunction = distribution.propertyFunctions.functionById(propertyId);
      try {
        return propertyFunction(paramsSetup);
      } on Exception catch (exception) {
        if (exception is DistributionPropertyUndefinedException ||
            exception is ParameterShouldBeComputedNumericallyException) {
          return exception;
        }
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 20,
      children: [
        DistributionPropertyListItem(
          propertyName: 'Wartość oczekiwana',
          value: getValueForProperty('expectedValue'),
        ),
        DistributionPropertyListItem(
          propertyName: 'Wariancja',
          value: getValueForProperty('variance'),
        ),
        DistributionPropertyListItem(
          propertyName: 'Odchylenie standardowe',
          value: getValueForProperty('standardDeviation'),
        ),
        DistributionPropertyListItem(
          propertyName: 'Mediana',
          value: getValueForProperty('median'),
        ),
        DistributionPropertyListItem(
          propertyName: 'Moda',
          value: getValueForProperty('mode'),
        ),
      ],
    );
  }
}
