import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:super_bullet_list/bullet_list.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_bulleted_list.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/ui/widget/component_views/distribution_description_paragraph_view.dart';
import 'package:zobmat25_2/feature/distribution_description/ui/widget/distribution_description_component_view.dart';

class DistributionDescriptionBulletedListView extends StatelessWidget {
  const DistributionDescriptionBulletedListView({super.key, required this.bulletList});

  final DistributionDescriptionBulletedList bulletList;

  @override
  Widget build(BuildContext context) {
    final componentViews = bulletList.items.map((component) {
      if (component is DistributionDescriptionParagraph) {
        return DistributionDescriptionParagraphView(
          paragraph: component,
          addBottomPadding: false,
        );
      }
      return DistributionDescriptionComponentView(component: component);
    });
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SuperBulletList(
        gap: 10,
        separator: Gap(9),
        items: componentViews.toList(),
        iconColor: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}
