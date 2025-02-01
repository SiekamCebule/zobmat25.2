import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:super_bullet_list/bullet_style.dart';
import 'package:zobmat25_2/core/shared_ui/navigation_link_text_button.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/bloc/distributions_catalogue_cubit.dart';
import 'package:zobmat25_2/feature/navigation/domain/entity/navigation_entry.dart';
import 'package:zobmat25_2/feature/navigation/ui/bloc/navigation_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final dashboardState = context.watch<DistributionsCatalogueCubit>().state;
    var distributionsCount = 24;
    if (dashboardState is DistributionsCatalogueAvailable) {
      distributionsCount = dashboardState.allDistributions.length;
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(70),
          Text(
            'Czy chcesz dowiedzieć się czegoś...',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          GradientText(
            'o rozkładach prawdopodobieństwa?',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
            gradientType: GradientType.linear,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
          Gap(30),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 580),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Co znajdziesz na stronie?',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                          Gap(10),
                          SuperBulletList(
                            style: BulletStyle.dash,
                            crossAxisMargin: 0,
                            gap: 8,
                            separator: Gap(10),
                            items: [
                              Text(
                                'Opisy $distributionsCount rozkładów prawdopodobieństwa, wraz z ich zastosowaniami',
                              ),
                              Text(
                                'Wykresy funkcji gęstości i wykresy funkcji rozkładu skumulowanego',
                              ),
                              Text('Możliwość wylosowania liczb wg rozkładu'),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          'Odnośniki do stron internetowych, służące do głebszego zgłębienia pojęć. Odnośniki znajdują się w niektórych opisach i w sekcji ',
                                    ),
                                    WidgetSpan(
                                      baseline: TextBaseline.alphabetic,
                                      alignment: PlaceholderAlignment.middle,
                                      child: NavigationLinkTextButton(
                                        text: '"O stronie"',
                                        navigationEntry: NavigationEntry.about,
                                      ),
                                    ),
                                    TextSpan(text: ''),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Czego NIE znajdziesz na stronie?',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                          Gap(10),
                          SuperBulletList(
                            style: BulletStyle.dash,
                            crossAxisMargin: 0,
                            gap: 8,
                            separator: Gap(10),
                            items: [
                              Text(
                                'Bardziej zaawansowanych zagadnień, takich jak funkcja n rzędu, kurtoza, czy współczynnik skośności.',
                              ),
                              Text(
                                'Wykresy PDF często "wariują" przy skrajnych wartościach parametrów (szczególnie rozkład beta i rozkład chi-kwadrat)',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* Tooltip(
                message: 'Jeszcze nad tym pracujemy...',
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                    shape: StadiumBorder(),
                  ),
                  onPressed: null, // TODO

                  child: Text('Ale... czym w ogóle są te rozkłady?'),
                ),
              ),
              Gap(20),*/
              Gap(350),
              FilledButton(
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  context.read<NavigationCubit>().goTo(
                    NavigationEntry.distributionsCatalogue,
                  );
                },
                child: Text('Przejdź do katalogu'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
