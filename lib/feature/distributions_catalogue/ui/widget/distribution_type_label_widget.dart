import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';

class DistributionTypeLabelWidget extends StatefulWidget {
  const DistributionTypeLabelWidget({super.key, required this.distributionType});

  final DistributionType distributionType;

  @override
  State<DistributionTypeLabelWidget> createState() => _DistributionTypeLabelWidgetState();
}

class _DistributionTypeLabelWidgetState extends State<DistributionTypeLabelWidget> {
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
    final brightness = Theme.of(context).brightness;
    return switch (widget.distributionType) {
      DistributionType.continuous => switch (brightness) {
        Brightness.light => const Color.fromARGB(255, 249, 250, 210),
        Brightness.dark => const Color.fromARGB(255, 52, 54, 22),
      },
      DistributionType.discrete => switch (brightness) {
        Brightness.light => const Color.fromARGB(255, 211, 250, 210),
        Brightness.dark => const Color.fromARGB(255, 25, 54, 22),
      },
    };
  }

  Color getTextColor() {
    final brightness = Theme.of(context).brightness;
    return switch (widget.distributionType) {
      DistributionType.continuous => switch (brightness) {
        Brightness.light => const Color.fromARGB(255, 54, 54, 22),
        Brightness.dark => const Color.fromARGB(255, 250, 249, 210),
      },
      DistributionType.discrete => switch (brightness) {
        Brightness.light => const Color.fromARGB(255, 22, 54, 25),
        Brightness.dark => const Color.fromARGB(255, 210, 250, 212),
      },
    };
  }
}
