import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/continuous_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/discrete_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';

class DistributionChartTypeSegmentedButton extends StatelessWidget {
  const DistributionChartTypeSegmentedButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardState =
        context.watch<DistributionDashboardCubit>().state
            as DistributionDashboardDistributionSelected;
    final distribution = dashboardState.distribution;
    if (distribution is ContinuousDistribution) {
      return SegmentedButton(
        showSelectedIcon: false,
        segments: [
          ButtonSegment(
            value: ContinuousDistributionChartType.pdf,
            label: Text('Funkcja gęstości'),
          ),
          ButtonSegment(
            value: ContinuousDistributionChartType.cdf,
            label: Text('Dystrybuanta'),
          ),
        ],
        selected: {dashboardState.continuousChartType},
        onSelectionChanged: (selection) {
          context.read<DistributionDashboardCubit>().changeContinuousDistributionChart(
            selection.single,
          );
        },
      );
    } else {
      return SegmentedButton(
        showSelectedIcon: false,
        segments: [
          ButtonSegment(
            value: DiscreteDistributionChartType.pmf,
            label: Text('Funkcja masy'),
          ),
          ButtonSegment(
            value: DiscreteDistributionChartType.cdf,
            label: Text('Dystrybuanta'),
          ),
        ],
        selected: {dashboardState.discreteChartType},
        onSelectionChanged: (selection) {
          context.read<DistributionDashboardCubit>().changeDiscreteDistributionChart(
            selection.single,
          );
        },
      );
    }
  }
}
