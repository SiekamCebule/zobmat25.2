import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_component.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description_text_component.dart';

class DistributionDescriptionParagraph extends DistributionDescriptionComponent
    with DistributionDescriptionTextComponent {
  const DistributionDescriptionParagraph({
    required this.text,
    this.italic = false,
    this.bold = false,
    this.justify = false,
    this.websiteUrl,
    this.containsMarkdownLinks = false,
    this.fontSize = CourseLessonTextFontSize.medium,
    this.color = CourseLessonTextColor.themeOnSurface,
  });

  final String text;
  final bool italic;
  final bool bold;
  final bool justify;
  final String? websiteUrl;
  final bool containsMarkdownLinks;
  final CourseLessonTextFontSize fontSize;
  final CourseLessonTextColor color;

  @override
  List<Object?> get props => [text, italic, bold, fontSize, color];
}

enum CourseLessonTextFontSize { big, medium, small }

enum CourseLessonTextColor {
  themePrimary,
  themeSecondary,
  themeTertiary,
  themeOnSurface,
  themeOnSurfaceVariant,
}
