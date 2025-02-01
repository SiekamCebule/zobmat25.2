import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/dialog/drawed_numbers_dialog.dart';

class DrawNumbersByDistributionIconButton extends StatelessWidget {
  const DrawNumbersByDistributionIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dashboardState = context.watch<DistributionDashboardCubit>().state;
    final dashboardIsAvaiable =
        dashboardState is DistributionDashboardDistributionSelected;

    return IconButton(
      onPressed:
          dashboardIsAvaiable
              ? () async {
                context.read<DistributionDashboardCubit>().drawNumbers();
                final dashboardCubit = context.read<DistributionDashboardCubit>();
                await showDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider.value(
                      value: dashboardCubit,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 500),
                          child: DrawedNumbersDialog(),
                        ),
                      ),
                    );
                  },
                );
              }
              : null,
      icon: Icon(Symbols.casino_rounded),
      tooltip: 'Wylosuj 10 liczb',
    );
  }
}
