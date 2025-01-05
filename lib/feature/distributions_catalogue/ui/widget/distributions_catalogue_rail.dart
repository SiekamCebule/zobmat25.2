import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_filter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/bloc/distributions_catalogue_cubit.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/distribution_navigation_card.dart';

class DistributionsCatalogueRail extends StatelessWidget {
  const DistributionsCatalogueRail({super.key});

  @override
  Widget build(BuildContext context) {
    late Widget distributionsListWidget;
    final catalogueState = context.watch<DistributionsCatalogueCubit>().state;
    final dashboardState = context.watch<DistributionDashboardCubit>().state;
    if (catalogueState is! DistributionsCatalogueAvailable) {
      distributionsListWidget = Center(child: CircularProgressIndicator());
    } else if (catalogueState.filters.isNotEmpty) {
      final distributionCards = catalogueState.distributions.map((distribution) {
        bool isSelected = false;
        if (dashboardState is DistributionDashboardDistributionSelected) {
          isSelected = distribution == dashboardState.distribution;
        }
        return DistributionNavigationCard(
          distribution: distribution,
          isSelected: isSelected,
          onTap: () {
            context.read<DistributionDashboardCubit>().toggleDistributionSelection(
              distribution,
            );
          },
        );
      });
      distributionsListWidget = Padding(
        padding: EdgeInsets.only(left: 5, right: 10),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
          child: ListView(children: distributionCards.toList()),
        ),
      );
    } else {
      distributionsListWidget = FractionallySizedBox(
        widthFactor: 0.7,
        child: Center(
          child: Center(
            child: Text(
              'Zaznacz filtry, aby wyświetlić dostępne rozkłady',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }
    final selectedFilters =
        (catalogueState is DistributionsCatalogueAvailable)
            ? catalogueState.filters
            : {DistributionFilter.continuous, DistributionFilter.discrete};
    print('UI: selected filters: $selectedFilters');
    final filterChipsAreEnabled = catalogueState is DistributionsCatalogueAvailable;

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            VerticalDivider(),
            Expanded(
              child: Column(
                children: [
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilterChip(
                        showCheckmark: true,
                        label: Text('Ciągłe'),
                        onSelected:
                            filterChipsAreEnabled
                                ? (_) {
                                  context
                                      .read<DistributionsCatalogueCubit>()
                                      .toggleFilter(DistributionFilter.continuous);
                                }
                                : null,
                        selected: selectedFilters.contains(DistributionFilter.continuous),
                      ),
                      Gap(10),
                      FilterChip(
                        showCheckmark: true,
                        label: Text('Dyskretne'),
                        onSelected:
                            filterChipsAreEnabled
                                ? (_) {
                                  context
                                      .read<DistributionsCatalogueCubit>()
                                      .toggleFilter(DistributionFilter.discrete);
                                }
                                : null,
                        selected: selectedFilters.contains(DistributionFilter.discrete),
                      ),
                    ],
                  ),
                  Gap(10),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: Durations.short4,
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      child: distributionsListWidget,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
