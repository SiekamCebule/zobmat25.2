import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/distribution_property_undefined_exception.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/parameter_should_be_computed_numerically_exception.dart';

class DistributionPropertyListItem extends StatelessWidget {
  const DistributionPropertyListItem({
    super.key,
    required this.propertyName,
    required this.value,
  }) : assert(
         value is num ||
             value is DistributionPropertyUndefinedException ||
             value is ParameterShouldBeComputedNumericallyException,
       );

  final String propertyName;
  final dynamic value; // number or exception

  static const _valueDoublePrecision = 5;

  @override
  Widget build(BuildContext context) {
    String mathSymbol;
    switch (propertyName) {
      case 'Wartość oczekiwana':
        mathSymbol = '\\mathbb{E}[X]';
        break;
      case 'Wariancja':
        mathSymbol = '\\text{Var}(X)';
        break;
      case 'Odchylenie standardowe':
        mathSymbol = '\\sigma';
        break;
      case 'Mediana':
        mathSymbol = 'Me';
        break;
      case 'Moda':
        mathSymbol = 'Mo';
        break;
      default:
        throw ArgumentError('An unknown distribution property name: $propertyName');
    }

    late Widget mainBody;
    if (value is num) {
      mainBody = SelectableMath.tex(
        '$mathSymbol = ${value!.toStringAsFixed(_valueDoublePrecision)}',
        textScaleFactor: 1.1,
      );
    } else {
      late String text;
      if (value is DistributionPropertyUndefinedException) {
        text = 'Niezdefiniowane';
      } else if (value is ParameterShouldBeComputedNumericallyException) {
        text = 'Obliczane numerycznie';
      }
      mainBody = Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.italic),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap(5),
        Text(propertyName, style: Theme.of(context).textTheme.titleMedium),
        Gap(5),
        mainBody,
      ],
    );
  }
}
