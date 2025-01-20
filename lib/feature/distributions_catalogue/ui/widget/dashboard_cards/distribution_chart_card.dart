import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/dialog/drawed_numbers_dialog.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/continuous_distribution_chart_view.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/distribution_parameter_text_field.dart';

class DistributionChartCard extends StatelessWidget {
  const DistributionChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.watch<DistributionDashboardCubit>().state;
    final dashboardIsAvaiable =
        dashboardState is DistributionDashboardDistributionSelected;

    Distribution? distribution;
    late Widget chartWidget;
    if (dashboardIsAvaiable) {
      distribution = dashboardState.distribution;
      chartWidget =
          distribution is ContinuousDistribution
              ? ContinuousDistributionChartView(
                distribution: distribution,
                chartType: dashboardState.chartType,
              )
              : Placeholder();
    }

    return Card(
      clipBehavior: Clip.none,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  if (dashboardIsAvaiable) Positioned.fill(top: 80, child: chartWidget),
                  if (!dashboardIsAvaiable)
                    ColoredBox(
                      color: Colors.black26,
                      child: SizedBox.expand(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: SegmentedButton(
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment(
                          value: DistributionChartType.pdf,
                          label: Text('Funkcja gęstości'),
                        ),
                        ButtonSegment(
                          value: DistributionChartType.cdf,
                          label: Text('Dystrybuanta'),
                        ),
                      ],
                      selected:
                          dashboardIsAvaiable
                              ? {dashboardState.chartType}
                              : {DistributionChartType.pdf},
                      onSelectionChanged:
                          dashboardIsAvaiable
                              ? (selection) {
                                context.read<DistributionDashboardCubit>().changeChart(
                                  selection.single as DistributionChartType,
                                );
                              }
                              : null,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      onPressed:
                          dashboardIsAvaiable
                              ? () async {
                                context.read<DistributionDashboardCubit>().drawNumbers();
                                final dashboardCubit =
                                    context.read<DistributionDashboardCubit>();
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return BlocProvider.value(
                                      value: dashboardCubit,
                                      child: DrawedNumbersDialog(),
                                    );
                                  },
                                );
                              }
                              : null,
                      icon: Icon(Symbols.casino_rounded),
                      tooltip: 'Wylosuj 10 liczb',
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
