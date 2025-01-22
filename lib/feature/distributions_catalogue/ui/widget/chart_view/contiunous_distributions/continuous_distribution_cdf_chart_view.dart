import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/core/util/decimal_places.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/shared/distribution_chart_shared_components.dart';

class ContinuousDistributionCdfChartView extends StatelessWidget {
  const ContinuousDistributionCdfChartView({super.key, required this.distribution});

  final ContinuousDistribution distribution;

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.watch<DistributionDashboardCubit>().state;
    if (dashboardState is! DistributionDashboardDistributionSelected) {
      throw StateError('No distribution is selected when displaying a PDF chart');
    }

    num cdf(num x) {
      return distribution.functions.cdf(x, dashboardState.paramsSetup);
    }

    const boundary = 0.0005;
    final minX =
        findQuantile(
          cdf: distribution.functions.cdf,
          params: dashboardState.paramsSetup,
          targetProbability: boundary,
          lowerBound: -1000000,
          upperBound: 1000000,
        ).toDouble();
    final maxX =
        findQuantile(
          cdf: distribution.functions.cdf,
          params: dashboardState.paramsSetup,
          targetProbability: 1 - boundary,
          lowerBound: -1000000,
          upperBound: 1000000,
        ).toDouble();

    final pixelDensity =
        MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    final numPoints = (pixelDensity * 3).toInt();
    final interval = (maxX - minX) / numPoints;
    final spots = {
      for (var x = minX; x < maxX; x += interval) FlSpot(x, cdf(x).toDouble()),
    };

    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots.toList(),
            color: Theme.of(context).colorScheme.tertiary,
            belowBarData: BarAreaData(color: Colors.yellow),
            isCurved: true,
            dotData: FlDotData(show: false),
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
              minIncluded: false,
              maxIncluded: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: (maxX - minX) / 7,
              reservedSize: 28,
              minIncluded: false,
              maxIncluded: false,
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
        minX: minX,
        maxX: maxX,
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
                    'F(${lineBarSpot.x.toStringAsFixed(3)}) = ${lineBarSpot.y.toStringAsFixed(6)}';
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
        scaleAxis: FlScaleAxis.free,
        minScale: 1,
        maxScale: 1 + maxX.abs(),
      ),
    );
  }
}
