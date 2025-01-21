import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/discrete_distribution_chart_type.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/discrete_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/discrete_distributions/discrete_distribution_cdf_chart_view.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/chart_view/discrete_distributions/discrete_distribution_pmf_chart_view.dart';

class DiscreteDistributionChartView extends StatelessWidget {
  const DiscreteDistributionChartView({
    super.key,
    required this.distribution,
    required this.chartType,
  });

  final DiscreteDistribution distribution;
  final DiscreteDistributionChartType chartType;

  @override
  Widget build(BuildContext context) {
    if (chartType == DiscreteDistributionChartType.pmf) {
      return DiscreteDistributionPmfChartView(distribution: distribution);
    } else {
      return DiscreteDistributionCdfChartView(distribution: distribution);
    }
  }
}
