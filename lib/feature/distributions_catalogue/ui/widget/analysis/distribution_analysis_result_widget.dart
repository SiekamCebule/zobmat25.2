import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import 'package:gap/gap.dart';
import 'package:zobmat25_2/core/shared_ui/help_icon_button.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/distribution_analysis.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/analysis/setup/distribution_analysis_component.dart';

class DistributionAnalysisResultWidget extends StatefulWidget {
  const DistributionAnalysisResultWidget({
    super.key,
    required this.analysisComponent,
    required this.analysis,
  });

  final DistributionAnalysisComponent analysisComponent;
  final DistributionAnalysis? analysis;

  @override
  State<DistributionAnalysisResultWidget> createState() =>
      _DistributionAnalysisResultWidgetState();
}

class _DistributionAnalysisResultWidgetState
    extends State<DistributionAnalysisResultWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Durations.extralong2,
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.analysis?.results[widget.analysisComponent];
    if (result == null) {
      return Center(child: Text('Nie udało się zanalizować rozkładu...'));
    }

    const precision = 20;

    final latexExpression = switch (widget.analysisComponent) {
      DistributionAnalysisPredefinedComponents.continuousVariableBelonging =>
        'P(a \\leq X \\leq b) = ${result.toStringAsFixed(precision)}',
      DistributionAnalysisPredefinedComponents.continuousVariableEquality =>
        'P(X = x) = ${result.toStringAsFixed(precision)}',
      DistributionAnalysisPredefinedComponents.discreteVariableBelonging =>
        'P(a \\leq X \\leq b) = ${result.toStringAsFixed(precision)}',
      DistributionAnalysisPredefinedComponents.discreteVariableEquality =>
        'P(X = x) = ${result.toStringAsFixed(precision)}',
      _ =>
        throw UnsupportedError(
          'An unsupported DistributionAnalysisComponent type: ${widget.analysisComponent.runtimeType.toString()}',
        ),
    };
    final body = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SelectableMath.tex(
          latexExpression,
          textStyle: Theme.of(context).textTheme.bodyLarge,
          textScaleFactor: 1.15,
        ),
        if (widget.analysisComponent ==
            DistributionAnalysisPredefinedComponents.continuousVariableEquality) ...[
          Gap(10),
          HelpIconButton(
            tooltip: 'Dlaczego 0?',
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 500),
                        child: AlertDialog(
                          title: Text('Dlaczego wyszło 0?'),
                          content: Text(
                            'W rozkładach ciągłych prawdopodobieństwo wystąpienia pojedynczej wartości zawsze wynosi zero. Dzieje się tak dlatego, że mamy nieskończoną ilość możliwych wyników. Dla takich rozkładów prawdopodobieństwo musimy liczyć na przedziałach.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('Ok'),
                            ),
                          ],
                        ),
                      ),
                    ),
              );
            },
          ),
        ],
      ],
    );

    final opacityAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_animationController);

    return FadeTransition(opacity: opacityAnimation, child: body);
  }
}
