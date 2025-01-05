import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/config/distribution_image_urls.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';

class DistributionNavigationCard extends StatelessWidget {
  const DistributionNavigationCard({
    super.key,
    required this.distribution,
    this.isSelected = false,
    required this.onTap,
  });

  final Distribution distribution;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const borderRadius = 12.0;
    final imagePath =
        'assets/distribution_images/${distributionImageUrls[distribution.name]}';
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
      color:
          isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainer,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        hoverColor: Theme.of(context).colorScheme.primaryContainer,
        //focusColor: Theme.of(context).colorScheme.primaryContainer,
        hoverDuration: Durations.short2,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(imagePath, height: 100, fit: BoxFit.cover),
              ),
              Gap(10),
              Text(
                distribution.name,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.start,
              ),
              Gap(5),
              Text(
                distribution.shortDescription,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
