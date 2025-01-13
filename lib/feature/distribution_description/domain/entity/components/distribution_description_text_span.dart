import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_component.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_text_component.dart';

class DistributionDescriptionTextSpan extends DistributionDescriptionComponent
    with DistributionDescriptionTextComponent {
  const DistributionDescriptionTextSpan({required this.children});

  final List<DistributionDescriptionTextComponent> children;

  @override
  List<Object?> get props => [children];
}
