import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/core/shared_ui/transitions.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/distribution_dashboard.dart';

class DistributionsCataloguePage extends StatelessWidget {
  const DistributionsCataloguePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.watch<DistributionDashboardCubit>().state;
    if (dashboardState is DistributionDashboardInitial) {
      return Center(child: CircularProgressIndicator());
    }
    final emptyStateWidget = Center(
      child: Text(
        'Po wybraniu rozkładu prawdopodobieństwa pokażą się tu ciekawe informacje',
      ),
    );
    final mainBody =
        dashboardState is DistributionDashboardNoDistribution
            ? emptyStateWidget
            : DistributionDashboard();

    return SizedBox.expand(
      child: AnimatedSwitcher(
        duration: Durations.short3,
        reverseDuration: Duration.zero,
        // switchInCurve: Curves.easeOut,
        //switchOutCurve: Curves.easeIn,
        transitionBuilder: defaultFadeSlideTransition,
        child: mainBody,
      ),
    );
  }
}
