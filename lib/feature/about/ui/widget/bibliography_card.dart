import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:link_text/link_text.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:super_bullet_list/bullet_style.dart';
import 'package:zobmat25_2/feature/about/ui/widget/shared/about_page_card.dart';

class BibliographyCard extends StatelessWidget {
  const BibliographyCard({super.key});

  @override
  Widget build(BuildContext context) {
    Widget link(String data) {
      return LinkText(
        data,
        linkStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
      );
    }

    return AboutPageCard(
      title: 'Bibliografia',
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: SuperBulletList(
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
            link('https://pl.wikipedia.org/wiki/Standaryzacja_(statystyka)'),
            link('https://pl.wikipedia.org/wiki/Test_t_Studenta'),
            link('https://www.ttable.org'),
            link(
              'https://www.hwdoi.com/pl/math/what-is-the-student-t-distribution-and-how-do-i-use-it',
            ),
            link('https://en.wikipedia.org/wiki/Log-normal_distribution'),
            link('https://pl.wikipedia.org/wiki/Rozk%C5%82ad_Weibulla'),
            link('https://en.wikipedia.org/wiki/Pareto_distribution'),
            link('https://pl.wikipedia.org/wiki/Pr%C3%B3ba_Bernoulliego'),
            link('https://pl.wikipedia.org/wiki/Proces_Bernoulliego'),
            link('https://www.investopedia.com/terms/b/binomialdistribution.asp'),
            link('https://en.wikipedia.org/wiki/Geometric_distribution'),
            link('https://www.statisticshowto.com/hypergeometric-distribution-examples/'),
            link('https://en.wikipedia.org/wiki/Hypergeometric_distribution'),
            link('https://en.wikipedia.org/wiki/Poisson_distribution'),
            link('https://pl.wikipedia.org/wiki/Rozk%C5%82ad_Pascala'),
            link(
              'https://www.geeksforgeeks.org/negative-binomial-distribution-properties-applications-and-examples/',
            ),
            link('https://en.wikipedia.org/wiki/Zipf%27s_law#Occurrences'),
            link('https://en.wikipedia.org/wiki/Beta-binomial_distribution'),
          ],
        ),
      ),
    );
  }
}
