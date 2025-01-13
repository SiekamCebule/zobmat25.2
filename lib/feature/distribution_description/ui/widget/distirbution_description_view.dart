import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distribution_description/ui/widget/distribution_description_component_view.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution.dart';

class DistirbutionDescriptionView extends StatelessWidget {
  const DistirbutionDescriptionView({super.key, required this.distribution});

  final Distribution distribution;

  @override
  Widget build(BuildContext context) {
    final listViewChildren = distribution.extendedDescription.components.map((component) {
      return DistributionDescriptionComponentView(component: component);
    });
    return ListView(children: listViewChildren.toList());
  }
}
