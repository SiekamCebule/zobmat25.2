import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_component.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_text_component.dart';

class DistributionDescriptionTextSpan extends DistributionDescriptionComponent
    with DistributionDescriptionTextComponent {
  const DistributionDescriptionTextSpan({
    required this.children,
    this.addBottomPadding = true,
  });

  final List<DistributionDescriptionTextComponent> children;
  final bool addBottomPadding;

  @override
  List<Object?> get props => [children, addBottomPadding];
}
