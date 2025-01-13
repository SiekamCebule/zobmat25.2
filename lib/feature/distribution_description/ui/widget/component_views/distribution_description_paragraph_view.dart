import 'package:flutter/material.dart';
import 'package:link_text/link_text.dart';
import 'package:zobmat25_2/config/distribution_description_text_components_rendering_params.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';

class DistributionDescriptionParagraphView extends StatelessWidget {
  const DistributionDescriptionParagraphView({
    super.key,
    required this.paragraph,
    this.addBottomPadding = false,
  });

  final DistributionDescriptionParagraph paragraph;
  final bool addBottomPadding;

  @override
  Widget build(BuildContext context) {
    late Widget body;
    final textStyle = TextStyle(
      fontSize: DistributionDescriptionTextComponentsRenderingParams.fontSize(paragraph),
      fontFamily: DistributionDescriptionTextComponentsRenderingParams.fontFamily(
        paragraph,
      ),
      fontWeight: DistributionDescriptionTextComponentsRenderingParams.fontWeight(
        paragraph,
      ),
      fontStyle: DistributionDescriptionTextComponentsRenderingParams.fontStyle(
        paragraph,
      ),
      color: DistributionDescriptionTextComponentsRenderingParams.color(
        paragraph,
        colorScheme: Theme.of(context).colorScheme,
      ),
      letterSpacing: DistributionDescriptionTextComponentsRenderingParams.letterSpacing(),
      wordSpacing: DistributionDescriptionTextComponentsRenderingParams.wordSpacing(),
    );
    if (paragraph.websiteUrl == null) {
      body = SelectableText(
        paragraph.text,
        textAlign: DistributionDescriptionTextComponentsRenderingParams.textAlign(
          paragraph,
        ),
        style: textStyle,
      );
    } else {
      body = LinkText(
        paragraph.text,
        linkStyle: textStyle.copyWith(color: Theme.of(context).colorScheme.tertiary),
      );
    }
    return Padding(
      padding: addBottomPadding ? const EdgeInsets.only(bottom: 15) : EdgeInsets.zero,
      child: body,
    );
  }
}
