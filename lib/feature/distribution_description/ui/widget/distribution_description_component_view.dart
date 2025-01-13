import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_bulleted_list.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_text_span.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_component.dart';
import 'package:zobmat25_2/feature/distribution_description/ui/widget/component_views/distribution_description_bulleted_list_view.dart';
import 'package:zobmat25_2/feature/distribution_description/ui/widget/component_views/distribution_description_math_expression_view.dart';
import 'package:zobmat25_2/feature/distribution_description/ui/widget/component_views/distribution_description_paragraph_view.dart';
import 'package:zobmat25_2/feature/distribution_description/ui/widget/component_views/distribution_description_text_span_view.dart';

class DistributionDescriptionComponentView extends StatelessWidget {
  const DistributionDescriptionComponentView({super.key, required this.component});

  final DistributionDescriptionComponent component;

  @override
  Widget build(BuildContext context) {
    final component = this.component;
    if (component is DistributionDescriptionParagraph) {
      return DistributionDescriptionParagraphView(
        paragraph: component,
        addBottomPadding: true,
      );
    } else if (component is DistributionDescriptionTextSpan) {
      return DistributionDescriptionTextSpanView(textSpan: component);
    } else if (component is DistributionDescriptionMathExpression) {
      return DistributionDescriptionMathExpressionView(expression: component);
    } else if (component is DistributionDescriptionBulletedList) {
      return DistributionDescriptionBulletedListView(bulletList: component);
    } else {
      throw UnsupportedError(
        '${component.runtimeType} is not yet supported in distribution descriptions.',
      );
    }
  }
}
