import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/dashboard_cards/distribution_chart_card.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/dashboard_cards/distribution_description_and_properties_card.dart';

class DistributionDashboard extends StatelessWidget {
  const DistributionDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: Row(
          children: [
            Expanded(
              flex: 28,
              child: Column(
                children: [
                  Expanded(flex: 1, child: DistributionChartCard()),
                  /*ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 230),
                    child: DistributionAnalysisCard(),
                  ),*/
                ],
              ),
            ),
            SizedBox(width: 380, child: DistributionDescriptionAndPropertiesCard()),
          ],
        ),
      ),
    );
  }
}
