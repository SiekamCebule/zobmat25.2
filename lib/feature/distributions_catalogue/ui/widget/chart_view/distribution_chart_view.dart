import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/distribution_cdf_chart_view.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/distribution_pdf_chart_view.dart';

class DistributionChartView extends StatelessWidget {
  const DistributionChartView({
    super.key,
    required this.distribution,
    required this.chartType,
  });

  final Distribution distribution;
  final DistributionChartType chartType;

  @override
  Widget build(BuildContext context) {
    if (chartType == DistributionChartType.pdf) {
      return DistributionPdfChartView(distribution: distribution);
    } else {
      return DistributionCdfChartView(distribution: distribution);
    }
  }
}
