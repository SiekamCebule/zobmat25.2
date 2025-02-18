import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/core/util/decimal_places.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/discrete_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/shared/distribution_chart_shared_components.dart';

class DiscreteDistributionCdfChartView extends StatelessWidget {
  const DiscreteDistributionCdfChartView({super.key, required this.distribution});

  final DiscreteDistribution distribution;

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.watch<DistributionDashboardCubit>().state
        as DistributionDashboardDistributionSelected;

    num cdf(int x) {
      return distribution.functions.cdf(x, dashboardState.paramsSetup);
    }

    final range = distribution.functions.getChartRange(dashboardState.paramsSetup);

    final values = {for (var x = range.$1; x < range.$2; x++) x: cdf(x)};

    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: values.keys
                .map((x) => FlSpot(x.toDouble(), values[x]!.toDouble()))
                .toList(),
            isCurved: false,
            color: DistributionChartSharedComponents.chartColor(context),
            barWidth: DistributionChartSharedComponents.lineChartWidth(context),
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, xPercentage, barData, index) {
                return FlDotCirclePainter(
                  color: DistributionChartSharedComponents.chartColor(context),
                  radius: 6,
                );
              },
            ),
          ),
        ],
        gridData: FlGridData(
          drawHorizontalLine: true,
          drawVerticalLine: true,
          verticalInterval: 1.0,
          horizontalInterval: 0.2,
          getDrawingHorizontalLine: (y) {
            if (roundToNDecimalPlaces(y, 3) == 0.000) {
              return DistributionChartSharedComponents.boldFlGridLine(context);
            } else {
              return DistributionChartSharedComponents.softFlGridLine(context);
            }
          },
          getDrawingVerticalLine: (x) {
            if (x == 0) {
              return DistributionChartSharedComponents.boldFlGridLine(context);
            } else {
              return DistributionChartSharedComponents.softFlGridLine(context);
            }
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1 / 5,
              reservedSize: 55,
              minIncluded: true,
              maxIncluded: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              //interval: (maxX - minX) / 7,
              reservedSize: 35,
              minIncluded: true,
              maxIncluded: true,
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        backgroundColor: DistributionChartSharedComponents.backgroundColor(context),
        baselineX: 0,
        baselineY: 0,
        minY: 0,
        maxY: 1.0 + 0.05,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) {
              return DistributionChartSharedComponents.tooltipColor(context);
            },
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((lineBarSpot) {
                final text =
                    'F(${lineBarSpot.x.toInt().toString()}) = ${lineBarSpot.y.toStringAsFixed(6)}';
                return LineTooltipItem(
                  text,
                  DistributionChartSharedComponents.textStyle(context),
                  textAlign: TextAlign.start,
                );
              }).toList();
            },
          ),
        ),
      ),
      duration: Duration.zero,
      transformationConfig: FlTransformationConfig(
        scaleAxis: FlScaleAxis.horizontal,
        minScale: 1,
        maxScale: 250,
      ),
    );
  }
}
