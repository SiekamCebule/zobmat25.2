import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hyperlink/hyperlink.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:super_bullet_list/bullet_style.dart';
import 'package:zobmat25_2/feature/about/ui/widget/shared/about_page_card.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/bloc/distributions_catalogue_cubit.dart';

class AboutSiteCard extends StatelessWidget {
  const AboutSiteCard({super.key});

  @override
  Widget build(BuildContext context) {
    Widget body;
    final catalogueState = context.watch<DistributionsCatalogueCubit>().state;
    if (catalogueState is! DistributionsCatalogueAvailable) {
      body = Center(child: CircularProgressIndicator());
    } else {
      final distributionsCount = catalogueState.allDistributions.length;
      body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HyperLink(
            text:
                'Powyższa strona powstała na [XVII edycję konkursu "Zobaczyć Matematykę" organizowanego przez AGH w Krakowie](https://www.zobaczycmatematyke.agh.edu.pl/aktualnosci/detail?tx_news_pi1%5Baction%5D=detail&tx_news_pi1%5Bcontroller%5D=News&tx_news_pi1%5Bnews%5D=841&cHash=d69b5e66cdfeddbe9bdabb12e4fe657f). Co na niej znajdziesz?',
            textStyle: Theme.of(context).textTheme.bodyMedium,
            linkStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Gap(4),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SuperBulletList(
              separator: Gap(3),
              gap: 8,
              items: [
                Text(
                  'Listę $distributionsCount ciągłych i dyskretnych rozkładów prawdopodobieństwa',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Przystępny opis dla każdego z rozkładów i odnośniki do ważnych pojęć',
                ),
                Text('Wykresy funkcji gęstości i dystrybuanty dla rozkładów ciągłych'),
                Text('Wykresy funkcji masy i dystrybuanty dla rozkładów dyskretnych'),
                Text(
                  'Możliwość obliczenia prawdopodobieństwa, że zmienna losowa znajdzie się w danym przedziale lub że przyjmie określoną wartość',
                ),
                Text('Możliwość zmiany parametrów rozkładu'),
                Text(
                  'Automatyczne obliczanie właściwości rozkładu: średniej, wariancji, odchylenia standardowego, mody i mediany',
                ),
                Text('Możliwość wylosowania 10 liczb losowych według wybranego rozkładu'),
                Text('12 wyglądów strony (6 motywów kolorów i tryb jasny/ciemny)'),
              ],
              style: BulletStyle.dash,
            ),
          ),
          Gap(20),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Doprecyzowanie matematyczne: ',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  text:
                      'Na stronie możemy obliczyć prawdopodobieństwo, że zmienna losowa X przyjmie wartość z danego przedziału. Przedział ten jest domknięty, a mimo to możemy wpisać nieskończoność na jego końcu. Zastosowałem tutaj uproszczenie. W rzeczywistości przedział nie może być domknięty po tej stronie, gdzie występuje nieskończoność!',
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ],
            ),
          ),
          Gap(20),
        ],
      );
    }

    return AboutPageCard(title: 'O stronie', child: body);
  }
}
