import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:super_bullet_list/bullet_style.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/continuous_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/discrete_distribution.dart';

class DrawedNumbersDialog extends StatelessWidget {
  const DrawedNumbersDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardState =
        context.watch<DistributionDashboardCubit>().state
            as DistributionDashboardDistributionSelected;
    final drawedNumbers = dashboardState.drawedNumbers;
    late Widget drawedNumbersWidget;
    if (drawedNumbers != null) {
      late int precision;
      if (dashboardState.distribution is DiscreteDistribution) {
        precision = 0;
      } else if (dashboardState.distribution is ContinuousDistribution) {
        precision = 6;
      }
      drawedNumbersWidget = SizedBox.expand(
        child: SingleChildScrollView(
          child: Center(
            child: SuperBulletList(
              separator: Gap(10),
              style: BulletStyle.dash,
              items:
                  dashboardState.drawedNumbers!.map((number) {
                    return Text(number.toStringAsFixed(precision));
                  }).toList(),
            ),
          ),
        ),
      );
    } else {
      drawedNumbersWidget = Center(child: CircularProgressIndicator());
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 500, maxHeight: 400),
        child: Dialog(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(20),
              Text('Wylosowane liczby:', style: Theme.of(context).textTheme.titleLarge),
              Gap(20),
              Expanded(child: drawedNumbersWidget),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
