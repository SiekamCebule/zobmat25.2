import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/core/shared_ui/numeral_text_field.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/dialog/parameter_help_dialog.dart';

class DistributionParameterTextField extends StatefulWidget {
  const DistributionParameterTextField({super.key, required this.parameter});

  final DistributionParameter parameter;

  @override
  State<DistributionParameterTextField> createState() =>
      _DistributionParameterTextFieldState();
}

class _DistributionParameterTextFieldState extends State<DistributionParameterTextField> {
  late final TextEditingController _controller;
  final GlobalKey<FormFieldState> _formKey = GlobalKey();

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState =
        context.watch<DistributionDashboardCubit>().state
            as DistributionDashboardDistributionSelected;

    return NumeralTextField(
      formKey: _formKey,
      controller: _controller,
      onSubmit: () {
        if (!_formKey.currentState!.validate()) {
          return;
        }
        final value = num.parse(_controller.text);
        context.read<DistributionDashboardCubit>().changeParameter(
          widget.parameter,
          value: value,
        );
      },
      initial: dashboardState.paramsSetup.values[widget.parameter]!,
      labelText: widget.parameter.name,
      maxDecimalPlaces: 6,
      step: 0.5,
      min: widget.parameter.min,
      max: widget.parameter.max,
      helpButtonTooltip: 'Czym jest ${widget.parameter.name.toLowerCase()}?',
      onHelpButtonTap: () async {
        await showParameterHelpDialog(context: context, parameter: widget.parameter);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Wprowadź parametr.';
        }

        if (value == '0.') {
          return 'Wpisz dziesiętną część liczby.';
        }

        final onlyNumbersRegex = RegExp(r'^-?[0-9.]+$');
        if (!onlyNumbersRegex.hasMatch(value)) {
          return 'Wpisz prawidłową liczbę (np. 2.94, -3.5).';
        }

        if (value.startsWith('00') &&
            !value.startsWith('0.') &&
            !value.startsWith('-0.')) {
          return 'Liczba nie może mieć wielu zer na początku.';
        }

        final regex = RegExp(r'^-?[0-9]+(\.[0-9]*)?$|^-?0(\.[0-9]*)?$');
        if (!regex.hasMatch(value)) {
          return 'Wpisz prawidłową liczbę (np. 2.94, -3.5).';
        }

        final number = num.parse(value);
        if (number < widget.parameter.min) {
          return 'Minimalna wartość to ${widget.parameter.min.toString()}';
        }
        if (number > widget.parameter.max) {
          return 'Maksymalna wartość to ${widget.parameter.max.toString()}';
        }

        return null;
      },
    );
  }
}
