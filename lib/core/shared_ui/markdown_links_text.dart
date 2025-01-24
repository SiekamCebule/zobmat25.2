import 'package:flutter/material.dart';
import 'package:hyperlink/hyperlink.dart';

class MarkdownLinksText extends StatelessWidget {
  const MarkdownLinksText(this.data, {super.key, this.style, this.linkStyle});

  final String data;
  final TextStyle? style;
  final TextStyle? linkStyle;

  @override
  Widget build(BuildContext context) {
    return HyperLink(text: data, textStyle: style, linkStyle: linkStyle);
  }
}
