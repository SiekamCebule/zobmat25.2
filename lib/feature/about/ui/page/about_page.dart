import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hyperlink/hyperlink.dart';
import 'package:link_text/link_text.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:super_bullet_list/bullet_style.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget linkSpan(String data) {
      final linkPattern = RegExp(r'<(https?://[^>]+)>|\((https?://[^)]+)\)');
      final formattedText = data.replaceAllMapped(linkPattern, (match) {
        if (match.group(1) != null) {
          // Link w <...>
          final link = match.group(1)!;
          return '[$link]($link)';
        } else if (match.group(2) != null) {
          // Link w (...)
          final link = match.group(2)!;
          return '([$link]($link))';
        }
        return match[0]!;
      });

      return HyperLink(
        textStyle: Theme.of(context).textTheme.bodyMedium,
        linkStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.tertiary),
        text: formattedText,
      );
    }

    Widget link(String data) {
      return LinkText(
        data,
        linkStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.tertiary),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Gap(10),
                    Text(
                      'Wykorzystane technologie',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Placeholder(),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(10),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Bibliografia',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Gap(5),
                    SuperBulletList(
                      separator: Gap(5),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      style: BulletStyle.dash,
                      items: [
                        link('https://pl.wikipedia.org/wiki/Rozk%C5%82ad_normalny'),
                        link(
                          'https://www.linkedin.com/pulse/normal-distribution-its-applications-quality-control-process-shaikh/',
                        ),
                        link(
                          'https://pl.wikipedia.org/wiki/Rozk%C5%82ad_jednostajny_ci%C4%85g%C5%82y',
                        ),
                        link('https://en.wikipedia.org/wiki/Cauchy_distribution'),
                        link(
                          'https://www.quora.com/What-are-the-uses-of-the-Cauchy-distribution-Why-is-it-so-important',
                        ),
                        link(
                          'https://stats.stackexchange.com/questions/229474/practical-applications-of-the-laplace-and-cauchy-distributions',
                        ),
                        link('https://en.wikipedia.org/wiki/Exponential_distribution'),
                      ],
                    ),
                    Gap(5),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Zdjęcia',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    Gap(5),
                    SuperBulletList(
                      separator: Gap(5),
                      style: BulletStyle.dash,
                      items: [
                        linkSpan(
                          'M. W. Toews, CC BY 2.5 <https://creativecommons.org/licenses/by/2.5>, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:Standard_deviation_diagram.svg)',
                        ),
                        linkSpan(
                          'Skbkekas, CC BY 3.0 <https://creativecommons.org/licenses/by/3.0>, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:Cauchy_pdf.svg)',
                        ),
                        linkSpan(
                          'EvgSkv, CC0, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:Exponential_distribution_pdf_-_public_domain.svg)',
                        ),
                        linkSpan(
                          'Autor nieznany, domena publiczna, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:Uniform_distribution_PDF.png)',
                        ),
                        linkSpan(
                          'Cburnett, CC BY-SA 3.0 <http://creativecommons.org/licenses/by-sa/3.0/>, via Wikimedia Commons, (https://commons.wikimedia.org/wiki/File:Gamma_distribution_pdf.png)',
                        ),
                        linkSpan(
                          'Autor nieznany, GNU GPL 3.0 <https://www.gnu.org/copyleft/gpl-3.0.html>, via Wikimedia Commons, (https://commons.wikimedia.org/wiki/File:Gamma_distribution_pdf.png)',
                        ),
                        linkSpan(
                          'IkamusumeFan, CC BY-SA 4.0 <https://creativecommons.org/licenses/by-sa/4.0>, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:Laplace_pdf_mod.svg)',
                        ),
                        linkSpan(
                          'Autor nieznany, domena publiczna, via Wikimedia Commons, (https://commons.wikimedia.org/wiki/File:Chi-square_distributionPDF.png)',
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
    );
  }
}
