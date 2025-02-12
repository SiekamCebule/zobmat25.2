import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:super_bullet_list/bullet_style.dart';
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
      body: SizedBox.expand(
        child: FittedBox(
          alignment: Alignment.topCenter,
          fit: BoxFit.scaleDown,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(70),
              Text(
                'Czy chcesz dowiedzieć się czegoś',
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Co znajdziesz na stronie?',
                                style: Theme.of(
                                  context,
                                )
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              Gap(10),
                              SuperBulletList(
                                style: BulletStyle.dash,
                                crossAxisMargin: 0,
                                gap: 8,
                                separator: Gap(10),
                                items: [
                                  Text(
                                    'Opisy $distributionsCount rozkładów prawdopodobieństwa, a także ich zastosowania',
                                  ),
                                  Text(
                                    'Wykresy funkcji gęstości i funkcji rozkładu skumulowanego',
                                  ),
                                  Text('Możliwość wylosowania liczb wg rozkładu'),
                                  Text(
                                      'Odnośniki do stron internetowych, mogące posłużyć do zgłębienia używanych pojęć'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gap(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Czego nie znajdziesz na stronie?',
                                style: Theme.of(
                                  context,
                                )
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                              Gap(10),
                              SuperBulletList(
                                style: BulletStyle.dash,
                                crossAxisMargin: 0,
                                gap: 8,
                                separator: Gap(10),
                                items: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text:
                                            'Bardziej zaawansowanych zagadnień, takich jak: kurtoza, skośność rozkładu, funkcja tworząca momenty i entropia'),
                                  ])),
                                  Text(
                                    'Wszystkich odkrytych rozkładów prawdopodobieństwa (jest ich naprawdę wiele!)',
                                  ),
                                  Text(
                                    'Doskonałych wykresów funkcji gęstości (często "wariują" one przy skrajnych wartościach parametrów)',
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
                  Gap(350),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                      //shape: StadiumBorder(),
                      //shape:
                      //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
              Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}
