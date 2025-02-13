import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_component.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/analysis/distribution_analysis_parameter_field.dart';

class DistributionAnalysisComponentFields extends StatefulWidget {
  const DistributionAnalysisComponentFields({super.key, required this.analysisComponent});

  final DistributionAnalysisComponent analysisComponent;

  @override
  State<DistributionAnalysisComponentFields> createState() =>
      _DistributionAnalysisComponentFieldsState();
}

class _DistributionAnalysisComponentFieldsState
    extends State<DistributionAnalysisComponentFields> {
  final Map<String, FocusNode> _focusNodes = {};

  @override
  void initState() {
    super.initState();
    _initFocusNodes();
  }

  @override
  void didUpdateWidget(covariant DistributionAnalysisComponentFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.analysisComponent != oldWidget.analysisComponent) {
      _clearFocusNodes();
      _initFocusNodes();
    }
  }

  void _initFocusNodes() {
    for (var parameter in widget.analysisComponent.parameters) {
      _focusNodes.putIfAbsent(parameter.id, () => FocusNode());
    }
  }

  void _clearFocusNodes() {
    for (var node in _focusNodes.values) {
      node.dispose();
    }
    _focusNodes.clear();
  }

  @override
  void dispose() {
    _clearFocusNodes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.watch<DistributionDashboardCubit>().state
        as DistributionDashboardDistributionSelected;

    return Row(
      children: [
        for (var parameter in widget.analysisComponent.parameters) ...[
          Flexible(
            child: DistributionAnalysisParameterField(
              key: ValueKey(parameter.id),
              focusNode: _focusNodes.putIfAbsent(parameter.id, () => FocusNode()),
              initialValue: dashboardState.analysisSetup!
                  .componentParameters[widget.analysisComponent]![parameter]!,
              analysisComponent: widget.analysisComponent,
              analysisParameter: parameter,
            ),
          ),
          const Gap(10),
        ],
      ],
    );
  }
}
