import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/feature/about/ui/widget/shared/about_page_card.dart';

class AboutSiteCard extends StatelessWidget {
  const AboutSiteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AboutPageCard(
      title: 'O stronie',
      child: Column(
        children: [
          Container(height: 300, color: Theme.of(context).colorScheme.tertiaryContainer),
          Gap(20),
        ],
      ),
    );
  }
}
