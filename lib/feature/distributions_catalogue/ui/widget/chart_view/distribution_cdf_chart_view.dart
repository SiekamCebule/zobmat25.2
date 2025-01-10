import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/core/util/decimal_places.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';

class DistributionCdfChartView extends StatelessWidget {
  const DistributionCdfChartView({super.key, required this.distribution});

  final Distribution distribution;

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.watch<DistributionDashboardCubit>().state;
    if (dashboardState is! DistributionDashboardDistributionSelected) {
      throw StateError('No distribution is selected when displaying a PDF chart');
    }
    final boldLineColor = Theme.of(context).colorScheme.tertiaryContainer;
    const boldLineStrokeWidth = 1.75;

    final normalLineColor = Theme.of(context).colorScheme.surfaceContainerHigh;
    const normalLineStrokeWidth = 0.75;

    num cdf(num x) {
      return distribution.cdf(x, dashboardState.paramsSetup);
    }

    const boundary = 0.0005;
    final minX =
        findQuantile(
          cdf: distribution.cdf,
          params: dashboardState.paramsSetup,
          targetProbability: boundary,
          lowerBound: -1000000,
          upperBound: 1000000,
        ).toDouble();
    final maxX =
        findQuantile(
          cdf: distribution.cdf,
          params: dashboardState.paramsSetup,
          targetProbability: 1 - boundary,
          lowerBound: -1000000,
          upperBound: 1000000,
        ).toDouble();

    final pixelDensity =
        MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    final numPoints = (pixelDensity * 0.8).toInt();
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
              return FlLine(strokeWidth: boldLineStrokeWidth, color: boldLineColor);
            } else {
              return FlLine(strokeWidth: normalLineStrokeWidth, color: normalLineColor);
            }
          },
          getDrawingVerticalLine: (x) {
            if (x == 0) {
              return FlLine(strokeWidth: boldLineStrokeWidth, color: boldLineColor);
            } else {
              return FlLine(strokeWidth: normalLineStrokeWidth, color: normalLineColor);
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
              maxIncluded: true,
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
        minY: 0,
        maxY: 1.0,
        baselineY: 0,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) {
              return Theme.of(context).colorScheme.tertiary;
            },
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((lineBarSpot) {
                final text =
                    'F(${lineBarSpot.x.toStringAsFixed(3)}) = ${lineBarSpot.y.toStringAsFixed(5)}';
                return LineTooltipItem(
                  text,
                  Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
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
