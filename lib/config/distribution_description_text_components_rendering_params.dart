import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';

abstract class DistributionDescriptionTextComponentsRenderingParams {
  static TextAlign textAlign(DistributionDescriptionParagraph paragraph) {
    return paragraph.justify ? TextAlign.justify : TextAlign.start;
  }

  static double fontSize(DistributionDescriptionParagraph paragraph) {
    return switch (paragraph.fontSize) {
      CourseLessonTextFontSize.big => 18.0,
      CourseLessonTextFontSize.medium => 15.5,
      CourseLessonTextFontSize.small => 13,
    };
  }

  static FontWeight fontWeight(DistributionDescriptionParagraph paragraph) {
    return switch (paragraph.bold) {
      true => FontWeight.w500,
      false => FontWeight.w300,
    };
  }

  static FontStyle fontStyle(DistributionDescriptionParagraph paragraph) {
    return paragraph.italic ? FontStyle.italic : FontStyle.normal;
  }

  static Color color(
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

  static String fontFamily(DistributionDescriptionParagraph paragraph) {
    return 'Raleway';
  }

  static double wordSpacing() {
    return 0.15;
  }

  static double letterSpacing() {
    return 0;
  }

  static double height() {
    return 1.3;
  }
}
