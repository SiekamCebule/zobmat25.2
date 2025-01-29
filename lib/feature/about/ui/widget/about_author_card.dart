import 'package:flutter/material.dart';
import 'package:hyperlink/hyperlink.dart';
import 'package:zobmat25_2/feature/about/ui/widget/shared/about_page_card.dart';

class AboutAuthorCard extends StatelessWidget {
  const AboutAuthorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutPageCard(
      title: 'O autorze',
      child: Column(
        children: [
          HyperLink(
            text:
                'Nazywam się Konrad Król i w chwili tworzenia strony uczęszczam do [III Liceum Ogólnokształcącego im. Stefana Batorego w Chorzowie](https://www.facebook.com/3LoBatoryChorzow). Zastosowanie rozkładów prawdopodobieństwa widzę w symulacjach skoków narciarskich. Proident aliqua consequat non irure ea ea.Dolore consectetur aliquip ex deserunt voluptate nostrud tempor cillum anim.Eu commodo enim amet dolore pariatur in consequat aliquip magna deserunt.\nNajserdeczniej pozdrawiam mojego nauczyciela matematyki, profesora Jarosława Żaka.',
            textStyle: Theme.of(context).textTheme.bodyMedium,
            linkStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}

/*
(fragment kodu [tutaj](https://github.com/SiekamCebule/sj-manager/blob/a6c102d702269257d94da898843089b8b429d789/lib/features/career_mode/subfeatures/training/domain/training_engine/jumper_training_engine.dart#L67))
*/
