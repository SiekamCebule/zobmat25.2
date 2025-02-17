import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/config/distribution_image_urls.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/distribution_type_chip.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/ui/bloc/theme_cubit.dart';

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
    final themeState = context.watch<ThemeCubit>().state as ThemeAvaiable;
    final imagePath =
        'assets/distribution_images/${distributionImageUrls[distribution.id]}';
    final imageShouldBeMonochrome =
        themeState.theme.colorScheme == AppColorScheme.monochrome;
    return Card(
      color:
          isSelected
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.surfaceContainerLow,
      child: InkWell(
        hoverColor:
            isSelected
                ? Theme.of(context).colorScheme.secondaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
        focusColor:
            isSelected
                ? Theme.of(context).colorScheme.secondaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
        hoverDuration: Durations.short2,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  imagePath,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  color: imageShouldBeMonochrome ? Colors.grey : null,
                  colorBlendMode: imageShouldBeMonochrome ? BlendMode.saturation : null,
                ),
              ),
              Gap(10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      distribution.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Gap(5),
                  DistributionTypeChip(distributionType: distribution.type),
                  Gap(5),
                ],
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
