import 'package:flutter/material.dart';
import 'package:hyperlink/hyperlink.dart';
import 'package:zobmat25_2/config/distribution_description_text_components_rendering_params.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_text_span.dart';

class DistributionDescriptionTextSpanView extends StatelessWidget {
  const DistributionDescriptionTextSpanView({super.key, required this.textSpan});

  final DistributionDescriptionTextSpan textSpan;

  @override
  Widget build(BuildContext context) {
    final children =
        textSpan.children.map((textComponent) {
          if (textComponent is DistributionDescriptionTextSpan) {
            throw UnsupportedError(
              'At the moment, app cannot handle nested DistributionDescriptionTextSpans',
            );
          } else if (textComponent is DistributionDescriptionParagraph) {
            final textStyle = TextStyle(
              fontSize: DistributionDescriptionTextComponentsRenderingParams.fontSize(
                textComponent,
              ),
              fontFamily: DistributionDescriptionTextComponentsRenderingParams.fontFamily(
                textComponent,
              ),
              fontWeight: DistributionDescriptionTextComponentsRenderingParams.fontWeight(
                textComponent,
              ),
              fontStyle: DistributionDescriptionTextComponentsRenderingParams.fontStyle(
                textComponent,
              ),
              color: DistributionDescriptionTextComponentsRenderingParams.color(
                textComponent,
                colorScheme: Theme.of(context).colorScheme,
              ),
              wordSpacing:
                  DistributionDescriptionTextComponentsRenderingParams.wordSpacing(),
              letterSpacing:
                  DistributionDescriptionTextComponentsRenderingParams.letterSpacing(),
              height: DistributionDescriptionTextComponentsRenderingParams.height(),
            );
            if (textComponent.containsMarkdownLinks) {
              return WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: HyperLink(
                  text: textComponent.text,
                  textStyle: textStyle,
                  linkStyle: textStyle.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              );
            } else if (textComponent.websiteUrl != null) {
              return WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: HyperLink(
                  text: '[${textComponent.text}](${textComponent.websiteUrl})',
                  linkStyle: textStyle.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              );
            } else {
              return TextSpan(text: textComponent.text, style: textStyle);
            }
          } else {
            return WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: SizedBox(),
            );
          }
        }).toList();

    return SelectableText.rich(TextSpan(children: children), textAlign: TextAlign.start);
  }
}
