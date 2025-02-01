import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_component.dart';

class DistributionAnalysisComponentDropdown extends StatelessWidget {
  const DistributionAnalysisComponentDropdown({
    super.key,
    required this.initialComponent,
    required this.components,
    required this.onSelected,
  });

  final DistributionAnalysisComponent initialComponent;
  final Iterable<DistributionAnalysisComponent> components;
  final Function(DistributionAnalysisComponent? component) onSelected;

  @override
  Widget build(BuildContext context) {
    final entries = {
      DropdownMenuEntry(
        value: DistributionAnalysisPredefinedComponents.continuousVariableBelonging,
        label: 'P(a ≤ X ≤ b)',
      ),
      DropdownMenuEntry(
        value: DistributionAnalysisPredefinedComponents.continuousVariableEquality,
        label: 'P(X = x)',
      ),
      DropdownMenuEntry(
        value: DistributionAnalysisPredefinedComponents.discreteVariableBelonging,
        label: 'P(a ≤ X ≤ b)',
      ),
      DropdownMenuEntry(
        value: DistributionAnalysisPredefinedComponents.discreteVariableEquality,
        label: 'P(X = x)',
      ),
    }.where((entry) => components.contains(entry.value));
    return DropdownMenu(
      initialSelection: initialComponent,
      label: Text('Co chcesz sprawdzić?'),
      enableFilter: false,
      enableSearch: false,
      requestFocusOnTap: false,
      dropdownMenuEntries: entries.toList(),
      onSelected: onSelected,
    );
  }
}
