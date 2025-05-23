import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hyperlink/hyperlink.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:super_bullet_list/bullet_style.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zobmat25_2/feature/about/ui/widget/shared/about_page_card.dart';

class UsedTechnologiesCard extends StatelessWidget {
  const UsedTechnologiesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final linkStyle = textStyle!.copyWith(color: Theme.of(context).colorScheme.primary);

    Widget hyperLink(String data) {
      return HyperLink(text: data, textStyle: textStyle, linkStyle: linkStyle);
    }

    return AboutPageCard(
      title: 'Wykorzystane technologie',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hyperLink(
            'Aplikacja jest oparta na frameworku [Flutter](https://flutter.dev) i napisana w języku [Dart](https://dart.dev). Interfejs użytkownika (UI) został zaprojektowany w duchu [Material Design 3](https://m3.material.io) od Google. Wykorzystaną czcionką jest [Raleway](https://fonts.google.com/specimen/Raleway). Oto najważniejsze wykorzystane biblioteki:',
          ),
          Gap(5),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SuperBulletList(
              gap: 8,
              separator: Gap(3),
              items: [
                hyperLink('[fl_chart](https://pub.dev/packages/fl_chart) (wykresy)'),
                hyperLink(
                  '[flutter_bloc](https://pub.dev/packages/flutter_bloc) (tzw. state management)',
                ),
                hyperLink(
                  '[flex_color_scheme](https://pub.dev/packages/flex_color_scheme) (schematy kolorów)',
                ),
                hyperLink(
                  '[flutter_math_fork](https://pub.dev/packages/flutter_math_fork) (wyświetlanie wzorów matematycznych w LaTeX)',
                ),
                hyperLink(
                  '[hyper_link](https://pub.dev/packages/hyper_link) (hiperłącza)',
                ),
                hyperLink(
                  '[equatable](https://pub.dev/packages/equatable) (pomoc w pisaniu kodu)',
                ),
                hyperLink(
                  '[shared_preferences](https://pub.dev/packages/shared_preferences) (zapisywanie danych na urządzeniu, dzięki któremu motyw nie resetuje się po odświeżeniu strony)',
                ),
              ],
              style: BulletStyle.dash,
            ),
          ),
          Gap(5),
          hyperLink(
            'Dużą rolę w pracy nad aplikacją odegrał [ChatGPT](https://openai.com/chatgpt/overview/), którego wykorzystałem do nauki teorii i do pracy programistycznej (tworzenie funkcji matematycznych w kodzie, ekran ładowania w HTML). Wiedzę czerpałem również z artykułów internetowych, w tym artykułów na Wikipedii.',
          ),
          Gap(15),
          Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                  minimumSize: Size(0, 50),
                ),
                onPressed: () {
                  showLicensePage(
                    context: context,
                    applicationName: 'Katalog Rozkładów Prawdopodobieństwa',
                  );
                },
                child: Text('Pokaż wszystkie wykorzystane biblioteki'),
              ),
              FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                  minimumSize: Size(0, 50),
                ),
                onPressed: () async {
                  await launchUrlString('https://github.com/SiekamCebule/zobmat25.2');
                },
                child: Text('Zobacz kod źródłowy strony'),
              ),
            ],
          ),
          Gap(20),
        ],
      ),
    );
  }
}
