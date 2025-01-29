import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hyperlink/hyperlink.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:super_bullet_list/bullet_style.dart';
import 'package:zobmat25_2/feature/about/ui/widget/shared/about_page_card.dart';

class UsedImagesCard extends StatelessWidget {
  const UsedImagesCard({super.key});

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

    return AboutPageCard(
      title: 'Zdjęcia',
      child: SingleChildScrollView(
        child: SuperBulletList(
          separator: Gap(3),
          style: BulletStyle.dash,
          items: [
            linkSpan(
              'Cap Cool, flaticon (https://www.flaticon.com/free-icon/histogram_11572027?term=normal+distribution&page=1&position=50&origin=search&related_id=11572027) - Ikona aplikacji',
            ),
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
            linkSpan(
              'Danvildanvil, CC BY-SA 3.0 <https://creativecommons.org/licenses/by-sa/3.0>, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:Probability_density_function_of_Pareto_distribution.svg)',
            ),
            linkSpan(
              'Tayste, domena publiczna, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:Binomial_distribution_pmf.svg)',
            ),
            linkSpan(
              'Skbkekas,  CC BY 3.0 <https://creativecommons.org/licenses/by/3.0>, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:Geometric_pmf.svg)',
            ),
            linkSpan(
              'Fuzzyrandom, CC BY-SA 4.0 <https://creativecommons.org/licenses/by-sa/4.0>, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:HypergeometricPDF.png)',
            ),
            linkSpan(
              'Skbkekas, CC BY 3.0 <https://creativecommons.org/licenses/by/3.0>, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:Poisson_pmf.svg)',
            ),
            linkSpan(
              'Stpasha, domena publiczna, via Wikimedia Commons (https://commons.wikimedia.org/wiki/File:Negbinomial.gif)',
            ),
          ],
        ),
      ),
    );
  }
}
