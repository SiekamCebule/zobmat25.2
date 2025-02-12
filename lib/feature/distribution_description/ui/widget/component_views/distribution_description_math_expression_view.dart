import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';

class DistributionDescriptionMathExpressionView extends StatelessWidget {
  const DistributionDescriptionMathExpressionView({super.key, required this.expression});

  final DistributionDescriptionMathExpression expression;

  @override
  Widget build(BuildContext context) {
    final mathStyle = switch (expression.type) {
      DistributionDescriptionExpressionType.display => MathStyle.display,
      DistributionDescriptionExpressionType.text => MathStyle.text,
    };
    final latexWidget = SelectableMath.tex(expression.data, mathStyle: mathStyle);
    if (expression.title != null) {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(5),
              SelectableText(
                expression.title!,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              Gap(5),
              latexWidget,
              Gap(5),
            ],
          ),
        ),
      );
    } else {
      return FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(padding: EdgeInsets.only(bottom: 15), child: latexWidget));
    }
  }
}
