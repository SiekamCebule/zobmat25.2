import 'package:flutter/material.dart';

class DistributionDescriptionCard extends StatelessWidget {
  const DistributionDescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox.expand(),
    );
  }
}
