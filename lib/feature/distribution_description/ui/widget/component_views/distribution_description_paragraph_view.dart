import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hyperlink/hyperlink.dart';
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
    final renderingParams =
        context.watch<DistributionDescriptionTextComponentsRenderingParams>();

    late Widget body;
    final textStyle = TextStyle(
      fontSize: renderingParams.fontSize(paragraph),
      fontFamily: renderingParams.fontFamily(
        paragraph,
      ),
      fontWeight: renderingParams.fontWeight(
        paragraph,
      ),
      fontStyle: renderingParams.fontStyle(
        paragraph,
      ),
      color: renderingParams.color(
        paragraph,
        colorScheme: Theme.of(context).colorScheme,
      ),
      letterSpacing: renderingParams.wordSpacing(),
      height: renderingParams.height(),
    );
    if (paragraph.containsMarkdownLinks) {
      body = HyperLink(
        text: paragraph.text,
        textStyle: textStyle,
        linkStyle: textStyle.copyWith(
          color: Theme.of(context).colorScheme.primary,
          //fontWeight: FontWeight.w500,
        ),
      );
    } else if (paragraph.websiteUrl == null) {
      body = SelectableText(
        paragraph.text,
        textAlign: renderingParams.textAlign(
          paragraph,
        ),
        style: textStyle,
      );
    } else {
      body = LinkText(
        paragraph.text,
        linkStyle: textStyle.copyWith(color: Theme.of(context).colorScheme.primary),
      );
    }
    return Padding(
      padding: addBottomPadding ? const EdgeInsets.only(bottom: 15) : EdgeInsets.zero,
      child: body,
    );
  }
}
