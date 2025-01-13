import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_component.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_text_component.dart';

class DistributionDescriptionMathExpression extends DistributionDescriptionComponent
    with DistributionDescriptionTextComponent {
  const DistributionDescriptionMathExpression({
    this.title,
    required this.data,
    this.type = DistributionDescriptionExpressionType.display,
  });

  final String? title;
  final String data;
  final DistributionDescriptionExpressionType type;

  @override
  List<Object?> get props => [data, type];
}

enum DistributionDescriptionExpressionType { display, text }
