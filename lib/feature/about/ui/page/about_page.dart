import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/feature/about/ui/widget/about_author_card.dart';
import 'package:zobmat25_2/feature/about/ui/widget/about_site_card.dart';
import 'package:zobmat25_2/feature/about/ui/widget/bibliography_card.dart';
import 'package:zobmat25_2/feature/about/ui/widget/used_images_card.dart';
import 'package:zobmat25_2/feature/about/ui/widget/used_technologies_card.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TabBar(tabs: [Tab(text: 'O stronie'), Tab(text: 'Bibliografia i zdjęcia')]),
              Gap(10),
              Expanded(
                child: TabBarView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 400, child: AboutSiteCard()),
                              Gap(10),
                              SizedBox(height: 415, child: UsedTechnologiesCard()),
                            ],
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [SizedBox(height: 400, child: AboutAuthorCard())],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: BibliographyCard()),
                          Gap(10),
                          Expanded(child: UsedImagesCard()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
