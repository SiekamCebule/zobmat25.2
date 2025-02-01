import 'package:flutter/material.dart';

class ShowDistributionAnalysisIconButton extends StatelessWidget {
  const ShowDistributionAnalysisIconButton({
    super.key,
    required this.selected,
    required this.onSelectionChange,
  });

  final bool selected;
  final void Function(bool selection) onSelectionChange;

  @override
  Widget build(BuildContext context) {
    final iconWidget = Text('P', style: Theme.of(context).textTheme.titleMedium);
    final tooltip = 'Analizuj rozkład';
    if (selected) {
      return IconButton.filledTonal(
        style: IconButton.styleFrom(splashFactory: NoSplash.splashFactory),
        onPressed: () {
          onSelectionChange(selected);
        },
        icon: iconWidget,
        tooltip: tooltip,
      );
    } else {
      return IconButton(
        style: IconButton.styleFrom(splashFactory: NoSplash.splashFactory),
        onPressed: () {
          onSelectionChange(selected);
        },
        icon: iconWidget,
        tooltip: tooltip,
      );
    }
  }
}
