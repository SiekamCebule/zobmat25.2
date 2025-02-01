import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/discrete_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/analysis/distribution_analysis_card.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/contiunous_distributions/continuous_distribution_chart_view.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/discrete_distributions/discrete_distribution_chart_view.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/distribution_chart_type_segmented_button.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/distribution_parameter_text_field.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/icon_buttons/draw_numbers_by_distribution_icon_button.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/icon_buttons/show_distribution_analysis_icon_button.dart';

class DistributionChartCard extends StatefulWidget {
  const DistributionChartCard({super.key});

  @override
  State<DistributionChartCard> createState() => _DistributionChartCardState();
}

class _DistributionChartCardState extends State<DistributionChartCard> {
  var _analysisEnabled = false;

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.watch<DistributionDashboardCubit>().state;
    final dashboardIsAvaiable =
        dashboardState is DistributionDashboardDistributionSelected;
    final analysisEnabled = dashboardIsAvaiable && _analysisEnabled;

    Distribution? distribution;
    late Widget chartWidget;
    if (dashboardIsAvaiable) {
      distribution = dashboardState.distribution;
      chartWidget =
          distribution is ContinuousDistribution
              ? ContinuousDistributionChartView(
                distribution: distribution,
                chartType: dashboardState.continuousChartType,
              )
              : DiscreteDistributionChartView(
                distribution: distribution as DiscreteDistribution,
                chartType: dashboardState.discreteChartType,
              );
    }

    return Card(
      clipBehavior: Clip.none,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  if (dashboardIsAvaiable) Positioned.fill(top: 50, child: chartWidget),
                  if (!dashboardIsAvaiable)
                    ColoredBox(
                      color: Colors.black26,
                      child: SizedBox.expand(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: DistributionChartTypeSegmentedButton(),
                  ),
                  AnimatedPositioned(
                    top: 50,
                    right: -10,
                    left: 15,
                    height: analysisEnabled ? 200 : 0,
                    duration: Durations.short3,
                    curve: Curves.fastOutSlowIn,
                    child: DistributionAnalysisCard(
                      analysisSetup:
                          analysisEnabled ? dashboardState.analysisSetup : null,
                      analysisComponent:
                          analysisEnabled ? dashboardState.analysisComponent : null,
                      analysis: analysisEnabled ? dashboardState.analysis : null,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Row(
                      children: [
                        ShowDistributionAnalysisIconButton(
                          selected: _analysisEnabled,
                          onSelectionChange: (selected) async {
                            if (!selected) {
                              await context
                                  .read<DistributionDashboardCubit>()
                                  .initializeAnalysis();
                            } else {
                              await context
                                  .read<DistributionDashboardCubit>()
                                  .clearAnalysis();
                            }
                            setState(() {
                              _analysisEnabled = !selected;
                            });
                          },
                        ),
                        DrawNumbersByDistributionIconButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (dashboardIsAvaiable) ...[
              Gap(10),
              for (final parameter in dashboardState.distribution.parameters) ...[
                Gap(10),
                DistributionParameterTextField(
                  key: ValueKey(parameter),
                  parameter: parameter,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
