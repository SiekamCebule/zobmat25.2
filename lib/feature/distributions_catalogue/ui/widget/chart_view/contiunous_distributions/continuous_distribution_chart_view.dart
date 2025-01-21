import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/continuous_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/contiunous_distributions/continuous_distribution_cdf_chart_view.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/contiunous_distributions/continuous_distribution_pdf_chart_view.dart';

class ContinuousDistributionChartView extends StatelessWidget {
  const ContinuousDistributionChartView({
    super.key,
    required this.distribution,
    required this.chartType,
  });

  final ContinuousDistribution distribution;
  final ContinuousDistributionChartType chartType;

  @override
  Widget build(BuildContext context) {
    late Widget chartBody;
    if (chartType == ContinuousDistributionChartType.pdf) {
      chartBody = ContinuousDistributionPdfChartView(distribution: distribution);
    } else {
      chartBody = ContinuousDistributionCdfChartView(distribution: distribution);
    }
    return chartBody;
  }
}
