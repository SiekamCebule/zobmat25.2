import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_accessibility_mode.dart';
import 'package:zobmat25_2/feature/theme/ui/bloc/theme_cubit.dart';

abstract class DistributionChartSharedComponents {
  static Color backgroundColor(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  static Color chartColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static double lineChartWidth(BuildContext context) {
    final themeState = context.read<ThemeCubit>().state;
    if (themeState is ThemeInitial ||
        (themeState is ThemeAvaiable &&
            themeState.theme.accessibilityMode == AppAccessibilityMode.off)) {
      return 2.0;
    } else {
      return 3.5;
    }
  }

  static double barChartWidth(BuildContext context) {
    final themeState = context.read<ThemeCubit>().state;
    if (themeState is ThemeInitial ||
        (themeState is ThemeAvaiable &&
            themeState.theme.accessibilityMode == AppAccessibilityMode.off)) {
      return 7.0;
    } else {
      return 12.0;
    }
  }

  static Color tooltipColor(BuildContext context) {
    return Theme.of(context).colorScheme.primary;
  }

  static Color textColor(BuildContext context) {
    return Theme.of(context).colorScheme.onPrimary;
  }

  static TextStyle textStyle(BuildContext context) {
    return Theme.of(context).textTheme.labelSmall!.copyWith(color: textColor(context));
  }

  static FlLine softFlGridLine(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHigh;
    final themeState = context.read<ThemeCubit>().state;
    if (themeState is ThemeInitial ||
        (themeState is ThemeAvaiable &&
            themeState.theme.accessibilityMode == AppAccessibilityMode.off)) {
      return FlLine(
        color: color,
        strokeWidth: 0.75,
      );
    } else {
      return FlLine(
        color: color,
        strokeWidth: 3,
      );
    }
  }

  static FlLine boldFlGridLine(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondaryContainer;
    final themeState = context.read<ThemeCubit>().state;
    if (themeState is ThemeInitial ||
        (themeState is ThemeAvaiable &&
            themeState.theme.accessibilityMode == AppAccessibilityMode.off)) {
      return FlLine(
        color: color,
        strokeWidth: 1.75,
      );
    } else {
      return FlLine(
        color: color,
        strokeWidth: 3,
      );
    }
  }

  static FlLine flGridNoLine(BuildContext context) => FlLine(strokeWidth: 0);
}
