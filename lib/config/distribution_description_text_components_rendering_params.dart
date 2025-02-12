import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';

class DistributionDescriptionTextComponentsRenderingParams {
  const DistributionDescriptionTextComponentsRenderingParams({
    required this.textScaleFactor,
  });

  final double textScaleFactor;

  TextAlign textAlign(DistributionDescriptionParagraph paragraph) {
    return paragraph.justify ? TextAlign.justify : TextAlign.start;
  }

  double fontSize(DistributionDescriptionParagraph paragraph) {
    final fontSize = switch (paragraph.fontSize) {
      CourseLessonTextFontSize.big => 18.0,
      CourseLessonTextFontSize.medium => 15.5,
      CourseLessonTextFontSize.small => 13,
    };
    return fontSize * textScaleFactor;
  }

  FontWeight fontWeight(DistributionDescriptionParagraph paragraph) {
    return switch (paragraph.bold) {
      true => FontWeight.w500,
      false => FontWeight.w300,
    };
  }

  FontStyle fontStyle(DistributionDescriptionParagraph paragraph) {
    return paragraph.italic ? FontStyle.italic : FontStyle.normal;
  }

  Color color(
    DistributionDescriptionParagraph paragraph, {
    required ColorScheme colorScheme,
  }) {
    return switch (paragraph.color) {
      CourseLessonTextColor.themePrimary => colorScheme.primary,
      CourseLessonTextColor.themeSecondary => colorScheme.secondary,
      CourseLessonTextColor.themeTertiary => colorScheme.tertiary,
      CourseLessonTextColor.themeOnSurface => colorScheme.onSurface,
      CourseLessonTextColor.themeOnSurfaceVariant => colorScheme.onSurfaceVariant,
    };
  }

  String fontFamily(DistributionDescriptionParagraph paragraph) {
    return 'Raleway';
  }

  double wordSpacing() {
    return 0.15;
  }

  double letterSpacing() {
    return 0;
  }

  double height() {
    return 1.3;
  }
}
