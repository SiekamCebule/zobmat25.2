import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:super_bullet_list/bullet_style.dart';
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
    return Scaffold(
      body: Center(
        child: Transform.translate(
          //offset: Offset(-UiConstants.catalogueMenuWidth / 2, 0),
          offset: Offset.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(70),
              Text(
                'Czy chcesz dowiedzieć się czegoś...',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              GradientText(
                'o rozkładach prawdopodobieństwa?',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
                gradientType: GradientType.linear,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                  //Theme.of(context).colorScheme.tertiary,
                ],
              ),
              Gap(15),
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
                                    'Opisy 23 rozkładów prawdopodobieństwa, wraz z ich zastosowaniami',
                                  ),
                                  Text('Wykresy funkcji gęstości rozkładów (PDF)'),
                                  Text('Wykresy funkcji rozkładu skumulowanego (CDF)'),
                                  Text('Możliwość wylosowania liczb wg rozkładu'),
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
                                    'Bardziej zaawansowanych zagadnień, takich jak "funkcja n rzędu"',
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
              Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Tooltip(
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
                  Gap(20),
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
        ),
      ),
    );
  }
}
