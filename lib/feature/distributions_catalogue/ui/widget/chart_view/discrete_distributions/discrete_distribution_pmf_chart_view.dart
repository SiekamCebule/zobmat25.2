import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/discrete_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/shared/distribution_chart_shared_components.dart';

class DiscreteDistributionPmfChartView extends StatelessWidget {
  const DiscreteDistributionPmfChartView({super.key, required this.distribution});

  final DiscreteDistribution distribution;

  @override
  Widget build(BuildContext context) {
    final dashboardState =
        context.watch<DistributionDashboardCubit>().state
            as DistributionDashboardDistributionSelected;

    num pmf(int k) {
      return distribution.functions.pmf(k, dashboardState.paramsSetup);
    }

    final chartRange = distribution.functions.getChartRange(dashboardState.paramsSetup);
    final xList = List.generate(chartRange.$2, (x) => x);
    final values = [for (var x = 0; x < chartRange.$2; x++) pmf(x).toDouble()];

    final maxY = values.reduce((max, element) {
      return element > max ? element : max;
    });

    return BarChart(
      BarChartData(
        backgroundColor: DistributionChartSharedComponents.backgroundColor(context),
        borderData: FlBorderData(show: false),
        maxY: (maxY + 0.05).clamp(0, 1),
        minY: 0,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              maxIncluded: false,
              showTitles: true,
              reservedSize: 40,
              interval: 0.05,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toStringAsFixed(2),
                  style: Theme.of(context).textTheme.bodyMedium,
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              maxIncluded: false,
              minIncluded: false,
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final step = (chartRange.$2 / 15).ceil(); // Maksymalnie 20 etykiet
                if (value % step == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      value.toInt().toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        barGroups: [
          for (var x = 0; x < chartRange.$2; x++)
            BarChartGroupData(
              x: x,
              barRods: [
                BarChartRodData(
                  width: 7,
                  fromY: 0,
                  toY: values[x],
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ],
            ),
        ],
        gridData: FlGridData(
          drawHorizontalLine: true,
          drawVerticalLine: true,
          verticalInterval: 1.0,
          horizontalInterval: 0.05,
          getDrawingHorizontalLine: (y) {
            return DistributionChartSharedComponents.softFlGridLine(context);
          },
          getDrawingVerticalLine: (x) {
            return DistributionChartSharedComponents.flGridNoLine(context);
          },
        ),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (touchedSpot) {
              return DistributionChartSharedComponents.tooltipColor(context);
            },
            tooltipPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final x = xList[groupIndex];
              final y = values[groupIndex];
              return BarTooltipItem(
                'P(X = $x) = ${y.toStringAsFixed(5)}',
                DistributionChartSharedComponents.textStyle(context),
                textAlign: TextAlign.start,
              );
            },
          ),
        ),
      ),
      duration: Duration.zero,
      transformationConfig: FlTransformationConfig(
        scaleAxis: FlScaleAxis.horizontal,
        maxScale: 100,
      ),
    );
  }
}
