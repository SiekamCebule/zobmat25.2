import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distribution_description/ui/widget/distirbution_description_view.dart';

class DistributionDescriptionCard extends StatelessWidget {
  const DistributionDescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardState =
        context.watch<DistributionDashboardCubit>().state
            as DistributionDashboardDistributionSelected;

    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: DistirbutionDescriptionView(distribution: dashboardState.distribution),
      ),
    );
  }
}
