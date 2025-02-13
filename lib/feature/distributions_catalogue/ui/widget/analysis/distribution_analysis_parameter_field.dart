import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_component.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_parameter.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_parameter_value.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/analysis/distribution_analysis_easter_egg.dart';

class DistributionAnalysisParameterField extends StatefulWidget {
  const DistributionAnalysisParameterField({
    super.key,
    required this.initialValue,
    required this.analysisComponent,
    required this.analysisParameter,
    required this.focusNode,
  });

  final DistributionAnalysisParameterValue initialValue;
  final DistributionAnalysisComponent analysisComponent;
  final DistributionAnalysisParameter analysisParameter;
  final FocusNode focusNode;

  @override
  State<DistributionAnalysisParameterField> createState() =>
      _DistributionAnalysisParameterFieldState();
}

class _DistributionAnalysisParameterFieldState
    extends State<DistributionAnalysisParameterField> {
  late final TextEditingController _controller;
  late final _formKey = GlobalKey<FormFieldState>();
  var _dialogIsShown = false;

  @override
  void initState() {
    _controller = TextEditingController();
    updateControllerByParameterValue(widget.initialValue);
    super.initState();
  }

  void updateControllerByParameterValue(DistributionAnalysisParameterValue value) {
    _controller.text = switch (value) {
      DistributionAnalysisParameterNumberValue(value: num val) => val.toString(),
      DistributionAnalysisParameterInfinityValue(negative: bool isNegative) =>
        isNegative ? '-inf' : 'inf',
      _ => throw ArgumentError(),
    };
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        key: _formKey,
        controller: _controller,
        focusNode: widget.focusNode,
        onEditingComplete: _onTextFieldChange,
        onFieldSubmitted: (_) => _onTextFieldChange(),
        onTapOutside: (_) => _onTextFieldChange(),
        decoration: InputDecoration(labelText: widget.analysisParameter.symbol),
        validator: (value) {
          if (value == null) {
            return 'Wpisz wartość';
          }
          if (!_dialogIsShown) {
            _dialogIsShown = true;
            handleDistributionAnalysisEasterEgg(value, context);
          } else {
            _dialogIsShown = false;
          }
          final number = _getNumberFromText();
          if (number == null) {
            return 'Wpisz liczbę';
          }
          return null;
        },
      ),
    );
  }

  void _onTextFieldChange() {
    if (_formKey.currentState!.validate()) {
      context.read<DistributionDashboardCubit>().changeAnalysisParameter(
            component: widget.analysisComponent,
            parameter: widget.analysisParameter,
            value: DistributionAnalysisParameterValue.fromNum(_getNumberFromText()!),
          );
    }
    Future.delayed(Duration.zero, () {
      widget.focusNode.requestFocus();
    });
  }

  num? _getNumberFromText() {
    final text = _controller.text.replaceAll(r',', r'.');
    return switch (text) {
      '-inf' => double.negativeInfinity,
      'inf' => double.infinity,
      _ => num.tryParse(text),
    };
  }
}
