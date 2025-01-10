import 'package:flutter/material.dart';

class DistributionAnalysisCard extends StatelessWidget {
  const DistributionAnalysisCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(mainAxisSize: MainAxisSize.max, children: []),
        ),
      ),
    );
  }
}
