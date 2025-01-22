import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

abstract class DistributionChartSharedComponents {
  static Color tooltipColor(BuildContext context) {
    return Theme.of(context).colorScheme.tertiary;
  }

  static Color textColor(BuildContext context) {
    return Theme.of(context).colorScheme.onTertiary;
  }

  static TextStyle textStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(color: textColor(context));
  }

  static FlLine softFlGridLine(BuildContext context) {
    return FlLine(
      color: Theme.of(context).colorScheme.surfaceContainerHigh,
      strokeWidth: 0.75,
    );
  }

  static FlLine boldFlGridLine(BuildContext context) {
    return FlLine(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      strokeWidth: 1.75,
    );
  }

  static FlLine flGridNoLine(BuildContext context) => FlLine(strokeWidth: 0);
}
