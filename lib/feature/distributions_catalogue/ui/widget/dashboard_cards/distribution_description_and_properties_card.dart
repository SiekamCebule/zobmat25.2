import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_knowledge_view_type.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distribution_description/ui/widget/distribution_description_view.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/properties_view/distribution_properties_view.dart';

class DistributionDescriptionAndPropertiesCard extends StatelessWidget {
  const DistributionDescriptionAndPropertiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardState =
        context.watch<DistributionDashboardCubit>().state
            as DistributionDashboardDistributionSelected;

    late final Widget knowledgeWidget;
    if (dashboardState.knowledgeViewType == DistributionKnowledgeViewType.description) {
      knowledgeWidget = DistributionDescriptionView(
        distribution: dashboardState.distribution,
      );
    } else {
      knowledgeWidget = DistributionPropertiesView(
        distribution: dashboardState.distribution,
        paramsSetup: dashboardState.paramsSetup,
      );
    }

    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SegmentedButton(
              segments: [
                ButtonSegment(
                  value: DistributionKnowledgeViewType.description,
                  label: Text('Opis rozkładu'),
                ),
                ButtonSegment(
                  value: DistributionKnowledgeViewType.properties,
                  label: Text('Właściwości'),
                ),
              ],
              selected: {dashboardState.knowledgeViewType},
              onSelectionChanged: (selection) {
                context.read<DistributionDashboardCubit>().changeKnowledgeViewType(
                  selection.single,
                );
              },
              showSelectedIcon: false,
            ),
            Gap(10),
            Expanded(child: knowledgeWidget),
          ],
        ),
      ),
    );
  }
}
