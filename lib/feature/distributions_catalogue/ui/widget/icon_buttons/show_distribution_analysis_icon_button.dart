import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/core/shared_ui/accessible_icon_button.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_accessibility_mode.dart';
import 'package:zobmat25_2/feature/theme/ui/bloc/theme_cubit.dart';

class ShowDistributionAnalysisIconButton extends StatelessWidget {
  const ShowDistributionAnalysisIconButton({
    super.key,
    required this.isSelected,
    required this.onSelectionChange,
  });

  final bool isSelected;
  final void Function(bool selection) onSelectionChange;

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final double textFontSize = themeState is ThemeAvaiable
        ? themeState.theme.accessibilityMode == AppAccessibilityMode.on
            ? 20
            : 16
        : 16;
    final foregroundColor = isSelected
        ? Theme.of(context).colorScheme.surfaceContainer
        : Theme.of(context).colorScheme.onSurfaceVariant;
    final iconWidget = Text('P',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: foregroundColor, fontSize: textFontSize));
    final tooltip = 'Analizuj rozkład';
    return AccessibleIconButton(
      style: IconButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        backgroundColor:
            isSelected ? Theme.of(context).colorScheme.onSurfaceVariant : null,
      ),
      onPressed: () {
        onSelectionChange(isSelected);
      },
      isSelected: isSelected,
      tooltip: tooltip,
      child: iconWidget,
    );
  }
}
