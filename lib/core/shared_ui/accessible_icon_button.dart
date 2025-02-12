import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_accessibility_mode.dart';
import 'package:zobmat25_2/feature/theme/ui/bloc/theme_cubit.dart';

class AccessibleIconButton extends StatelessWidget {
  const AccessibleIconButton(
      {super.key,
      required this.onPressed,
      this.style,
      this.tooltip,
      this.isSelected,
      required this.child});

  final VoidCallback? onPressed;
  final String? tooltip;
  final ButtonStyle? style;
  final bool? isSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;

    if (themeState is ThemeInitial ||
        (themeState is ThemeAvaiable &&
            themeState.theme.accessibilityMode == AppAccessibilityMode.off)) {
      return IconButton.outlined(
        style: style,
        onPressed: onPressed,
        isSelected: isSelected,
        tooltip: tooltip,
        icon: child,
      );
    } else {
      return IconButton.outlined(
        style: style,
        onPressed: onPressed,
        isSelected: isSelected,
        tooltip: tooltip,
        icon: child,
      );
    }
  }
}
