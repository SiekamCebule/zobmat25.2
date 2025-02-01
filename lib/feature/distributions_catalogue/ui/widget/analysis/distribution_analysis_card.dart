import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/distribution_analysis.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_component.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_setup.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/analysis/distribution_analysis_component_dropdown.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/analysis/distribution_analysis_component_fields.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/analysis/distribution_analysis_result_widget.dart';

class DistributionAnalysisCard extends StatelessWidget {
  const DistributionAnalysisCard({
    super.key,
    required this.analysisComponent,
    required this.analysisSetup,
    required this.analysis,
  });

  final DistributionAnalysisComponent? analysisComponent;
  final DistributionAnalysisSetup? analysisSetup;
  final DistributionAnalysis? analysis;

  @override
  Widget build(BuildContext context) {
    late final Widget mainBody;

    if (analysisSetup == null || analysisComponent == null || analysis == null) {
      mainBody = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        child: Center(
          /*child: Text(
            'Błąd: Nie znaleziono instancji DistributionAnalysisSetup. Nie powinno się to wydarzyć...',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.italic),
          ),*/
        ),
      );
    } else {
      mainBody = Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gap(15),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DistributionAnalysisComponentDropdown(
                    initialComponent: analysisComponent!,
                    key: ValueKey(analysisComponent),
                    components:
                        analysisSetup is ContinuousDistributionAnalysisSetup
                            ? [
                              DistributionAnalysisPredefinedComponents
                                  .continuousVariableBelonging,
                              DistributionAnalysisPredefinedComponents
                                  .continuousVariableEquality,
                            ]
                            : [
                              DistributionAnalysisPredefinedComponents
                                  .discreteVariableBelonging,
                              DistributionAnalysisPredefinedComponents
                                  .discreteVariableEquality,
                            ],
                    onSelected: (component) async {
                      await context
                          .read<DistributionDashboardCubit>()
                          .changeAnalysisComponent(component: component!);
                    },
                  ),
                  Gap(15),
                  Flexible(
                    child: DistributionAnalysisComponentFields(
                      analysisComponent: analysisComponent!,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            DistributionAnalysisResultWidget(
              key: ValueKey(analysis),
              analysisComponent: analysisComponent!,
              analysis: analysis!,
            ),
            Spacer(),
          ],
        ),
      );
    }

    return Card(
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      child: mainBody,
    );
  }
}
