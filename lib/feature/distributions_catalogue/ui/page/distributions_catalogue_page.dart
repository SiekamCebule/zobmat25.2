import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/distribution_dashboard.dart';

class DistributionsCataloguePage extends StatelessWidget {
  const DistributionsCataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DistributionDashboard());
  }
}
