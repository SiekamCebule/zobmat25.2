import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

    const gapValue = 10.0;

    return ListView(
      shrinkWrap: true,
      children: [
        DistributionPropertyListItem(
          propertyName: 'Wartość oczekiwana',
          value: getValueForProperty('expectedValue'),
        ),
        Gap(gapValue),
        DistributionPropertyListItem(
          propertyName: 'Wariancja',
          value: getValueForProperty('variance'),
        ),
        Gap(gapValue),
        DistributionPropertyListItem(
          propertyName: 'Odchylenie standardowe',
          value: getValueForProperty('standardDeviation'),
        ),
        Gap(gapValue),
        DistributionPropertyListItem(
          propertyName: 'Median',
          value: getValueForProperty('median'),
        ),
        Gap(gapValue),
        DistributionPropertyListItem(
          propertyName: 'Mode',
          value: getValueForProperty('mode'),
        ),
      ],
    );
  }
}
