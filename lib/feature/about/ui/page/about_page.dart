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
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Gap(10),
                      Text(
                        'Wykorzystane technologie',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Gap(5),
                      FractionallySizedBox(widthFactor: 0.6, child: Placeholder()),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
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
                        separator: Gap(3),
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
                          link('https://pl.wikipedia.org/wiki/Proces_Poissona'),
                          link('https://builtin.com/data-science/gamma-distribution'),
                          link('https://pl.wikipedia.org/wiki/Rozk%C5%82ad_beta'),
                          link('https://en.wikipedia.org/wiki/Laplace_distribution'),
                          link('https://en.wikipedia.org/wiki/Chi-squared_test'),
                          link(
                            'https://pl.wikipedia.org/wiki/Standaryzacja_(statystyka)',
                          ),
                          link('https://pl.wikipedia.org/wiki/Test_t_Studenta'),
                          link('https://www.ttable.org'),
                          link(
                            'https://www.hwdoi.com/pl/math/what-is-the-student-t-distribution-and-how-do-i-use-it?utm_source=chatgpt.com',
                          ),
                          link('https://en.wikipedia.org/wiki/Log-normal_distribution'),
                          link('https://pl.wikipedia.org/wiki/Rozk%C5%82ad_Weibulla'),
                          link('https://pl.wikipedia.org/wiki/Pr%C3%B3ba_Bernoulliego'),
                          link('https://pl.wikipedia.org/wiki/Proces_Bernoulliego'),
                          link(
                            'https://www.investopedia.com/terms/b/binomialdistribution.asp',
                          ),
                          link('https://en.wikipedia.org/wiki/Geometric_distribution'),
                          link(
                            'https://www.statisticshowto.com/hypergeometric-distribution-examples/',
                          ),
                          link(
                            'https://en.wikipedia.org/wiki/Hypergeometric_distribution',
                          ),
                        ],
                      ),
                      Gap(15),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Zdjęcia',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Gap(5),
                      SuperBulletList(
                        separator: Gap(3),
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
                          linkSpan(
                            'The original uploader was Thorin at French Wikipedia., CC BY-SA 1.0 <https://creativecommons.org/licenses/by-sa/1.0>, via Wikimedia Commons, (https://commons.wikimedia.org/wiki/File:Student_densite_best.JPG)',
                          ),
                          linkSpan(
                            'Autor nieznany, CC BY-SA 3.0 <https://creativecommons.org/licenses/by-sa/3.0/deed.en>, via Wikimedia Commons, (https://commons.wikimedia.org/wiki/File:Lognormal_distribution_PDF.png)',
                          ),
                          linkSpan(
                            'Calimo, CC BY-SA 3.0 <https://creativecommons.org/licenses/by-sa/3.0>, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:Weibull_PDF.svg)',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
