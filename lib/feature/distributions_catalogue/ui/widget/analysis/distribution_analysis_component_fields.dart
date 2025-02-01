import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_component.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/analysis/distribution_analysis_parameter_field.dart';

class DistributionAnalysisComponentFields extends StatelessWidget {
  const DistributionAnalysisComponentFields({super.key, required this.analysisComponent});

  final DistributionAnalysisComponent analysisComponent;

  @override
  Widget build(BuildContext context) {
    final dashboardState =
        context.watch<DistributionDashboardCubit>().state
            as DistributionDashboardDistributionSelected;

    return Row(
      children: [
        for (var parameter in analysisComponent.parameters) ...[
          Flexible(
            child: DistributionAnalysisParameterField(
              key: ValueKey([parameter.id, analysisComponent]),
              initialValue:
                  dashboardState
                      .analysisSetup!
                      .componentParameters[analysisComponent]![parameter]!,
              analysisComponent: analysisComponent,
              analysisParameter: parameter,
            ),
          ),
          Gap(10),
        ],
      ],
    );
  }
}
