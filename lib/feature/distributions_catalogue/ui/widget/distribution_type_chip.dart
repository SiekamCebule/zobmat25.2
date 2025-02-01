import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/distribution_chip_colors.dart';

class DistributionTypeChip extends StatefulWidget {
  const DistributionTypeChip({super.key, required this.distributionType});

  final DistributionType distributionType;

  @override
  State<DistributionTypeChip> createState() => _DistributionTypeChipState();
}

class _DistributionTypeChipState extends State<DistributionTypeChip> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: getBackgroundColor(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Text(
          widget.distributionType == DistributionType.discrete ? 'Dyskretny' : 'Ciągły',
          style: Theme.of(context).textTheme.labelSmall!.copyWith(color: getTextColor()),
        ),
      ),
    );
  }

  Color getBackgroundColor() {
    return widget.distributionType == DistributionType.continuous
        ? Theme.of(context).extension<DistributionChipColors>()!.continuousBackground
        : Theme.of(context).extension<DistributionChipColors>()!.discreteBackground;
  }

  Color getTextColor() {
    return widget.distributionType == DistributionType.continuous
        ? Theme.of(context).extension<DistributionChipColors>()!.continuousForeground
        : Theme.of(context).extension<DistributionChipColors>()!.discreteForeground;
  }
}
