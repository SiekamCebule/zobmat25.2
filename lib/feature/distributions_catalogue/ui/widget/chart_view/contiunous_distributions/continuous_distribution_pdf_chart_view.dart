import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/core/util/decimal_places.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/shared/distribution_chart_shared_components.dart';

class ContinuousDistributionPdfChartView extends StatelessWidget {
  const ContinuousDistributionPdfChartView({super.key, required this.distribution});

  final ContinuousDistribution distribution;

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.watch<DistributionDashboardCubit>().state;
    if (dashboardState is! DistributionDashboardDistributionSelected) {
      throw StateError('No distribution is selected when displaying a PDF chart');
    }

    num pdf(num x) {
      return distribution.functions.pdf(x, dashboardState.paramsSetup);
    }

    final minX =
        distribution.functions.getChartRange(dashboardState.paramsSetup).$1.toDouble();
    final maxX =
        distribution.functions.getChartRange(dashboardState.paramsSetup).$2.toDouble();

    final pixelDensity =
        MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio;
    final numPoints =
        (pixelDensity * 0.8).ceil(); // Dopasuj liczbę punktów do rozdzielczości ekranu
    var interval = (maxX - minX) / numPoints;
    if (interval == 0) {
      interval = 0.01;
    }
    debugPrint(
      'continuous_pdf_chart.x_interval: $interval (($maxX - $minX) / $numPoints)',
    );
    final spots = <FlSpot>{};
    final infinities = <num>{};
    for (var x = minX; x < maxX; x += interval) {
      final fx = pdf(x);
      if (fx == double.infinity) {
        infinities.add(x);
      } else {
        spots.add(FlSpot(x, pdf(x).toDouble()));
      }
    }
    final maxY = spots.fold(
      0.0,
      (currentMax, spot) => spot.y > currentMax ? spot.y : currentMax,
    );

    return LineChart(
      LineChartData(
        clipData: FlClipData.all(),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots.toList(),
            color: DistributionChartSharedComponents.chartColor(context),
            belowBarData: BarAreaData(color: Colors.yellow),
            isCurved: true,
            curveSmoothness: 0.35,
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
              interval: (maxY) / 5,
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
        backgroundColor: DistributionChartSharedComponents.backgroundColor(context),
        minX: minX,
        maxX: maxX,
        baselineX: 0,
        minY: 0,
        maxY: maxY.toDouble() + 0.05,
        baselineY: 0,
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor:
                (touchedSpot) => DistributionChartSharedComponents.tooltipColor(context),
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((lineBarSpot) {
                late String text;
                if (infinities.contains(lineBarSpot.x)) {
                  text = 'f(${lineBarSpot.x.toStringAsFixed(3)}) = \u221E';
                } else {
                  text =
                      'f(${lineBarSpot.x.toStringAsFixed(3)}) = ${lineBarSpot.y.toStringAsFixed(5)}';
                }

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
        maxScale: 1 + maxX.abs(),
      ),
    );
  }
}
