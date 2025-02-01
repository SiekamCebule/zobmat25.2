import 'dart:math';

import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/core/math/erf.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/data_source/distributions/continuous/normal_distribution.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

final logNormalDistributionModel = ContinuousDistributionModel(
  id: 'log_normal_distribution',
  name: 'Rozkład log-normalny',
  shortDescription:
      'Rozkład charakteryzujący się dodatnimi, asymetrycznymi wartościami, gdzie ogon rozkładu jest wydłużony w prawo. Modeluje zjawiska naturalne i ekonomiczne, takie jak ceny akcji, wielkości populacji czy koncentracje zanieczyszczeń, szczególnie gdy dane mają multiplikatywny charakter zmian.',

  parameters: [
    DistributionParameter(
      'mean',
      'Średnia (μ)',
      '"Przesuwa" rozkład w lewo (dla wartości ujemnych) lub w prawo (dla wartości dodatnich).',
      min: -10,
      max: 8,
      defaultValue: 0.0,
    ),
    DistributionParameter(
      'dev',
      'Odchylenie standardowe (σ)',
      'Zwiększa szanse wystąpienia wartości skrajnych.',
      min: 0.001,
      max: 24,
      defaultValue: 1.0,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Zmienna losowa z tego rozkładu pochodzi z odpowiedniego przekształcenia wartości z rozkładu normalnego. Rozkład log-normalny ma tylko wartości dodatnie, a ogon rozkładu jest dosyć duży.',
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data:
            r'f(x) = \frac{1}{x \sqrt{2\pi\sigma^2}} e^{-\frac{(\ln x - \mu)^2}{2\sigma^2}} \text{ dla } x > 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(x) = \frac{1}{2} \left[ 1 + \text{erf}\left(\frac{\ln x - \mu}{\sqrt{2}\sigma}\right) \right] \text{ dla } x > 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = e^{\mu + \frac{\sigma^2}{2}}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'\text{Mediana} = e^{\mu}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma_X = \sqrt{(e^{\sigma^2} - 1) e^{2\mu + \sigma^2}}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = (e^{\sigma^2} - 1) e^{2\mu + \sigma^2}',
      ),
      DistributionDescriptionMathExpression(title: 'Mediana', data: r'Me = e^{\mu}'),
      DistributionDescriptionMathExpression(
        title: 'Moda',
        data: r'Mo = e^{\mu - \sigma^2}',
      ),
      DistributionDescriptionParagraph(
        text:
            '[Kliknij tutaj](https://en.wikipedia.org/wiki/Log-normal_distribution#Occurrence_and_applications), aby zobaczyć zastosowania tego rozkładu z dziedziny zachowań ludzkich, biologii, medycyny, chemii, hydrologii, nauk społecznych, demografii i technologii (artykuł w języku angielskim).',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);

num logNormalDistributionPdf(num x, DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  final dev = params.getValue('dev');

  if (x < 0) {
    throw ArgumentError("Value (x) must be greater or equal 0.");
  }

  if (dev <= 0) {
    throw ArgumentError("Standard deviation (dev) must be greater than 0.");
  }

  final sqrt2Pi = sqrt(2 * pi);
  final logX = log(x);
  final exponent = -pow((logX - mean) / dev, 2) / 2;

  return (1 / (x * dev * sqrt2Pi)) * exp(exponent);
}

num logNormalDistributionCdf(num x, DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  final dev = params.getValue('dev');

  if (x < 0) {
    throw ArgumentError("Value (x) must be greater or equal 0.");
  }

  if (dev <= 0) {
    throw ArgumentError("Standard deviation (dev) must be greater than 0.");
  }

  final logX = log(x);
  final z = (logX - mean) / (dev * sqrt(2));

  return 0.5 * (1 + erf(z));
}

num logNormalDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final dev = params.getValue('dev');

  if (p < 0 || p > 1) {
    throw ArgumentError("Probability (p) must be in the range <0, 1>.");
  }

  if (dev <= 0) {
    throw ArgumentError("Standard deviation (dev) must be greater than 0.");
  }

  // Inverse CDF for the log-normal uses the inverse CDF of the normal distribution
  final normalInverseCdf = normalDistributionInverseCdf(p, params);

  // Convert back to the log-normal scale
  return exp(normalInverseCdf);
}

(num, num) logNormalDistributionRangeGetter(DistributionParamsSetup params) {
  final dev = params.getValue('dev').toDouble();
  late final double prob;

  prob = 0.002 + (dev / 50);

  return (
    findQuantile(cdf: logNormalDistributionCdf, params: params, targetProbability: prob),
    findQuantile(
      cdf: logNormalDistributionCdf,
      params: params,
      targetProbability: 1 - prob,
    ),
  );
}

num logNormalDistributionExpectedValue(DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  final dev = params.getValue('dev');
  return exp(mean + pow(dev, 2) / 2);
}

num logNormalDistributionVariance(DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  final dev = params.getValue('dev');
  return (exp(pow(dev, 2)) - 1) * exp(2 * mean + pow(dev, 2));
}

num logNormalDistributionStandardDeviation(DistributionParamsSetup params) {
  final variance = logNormalDistributionVariance(params);
  return sqrt(variance);
}

num logNormalDistributionMedian(DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  return exp(mean);
}

num logNormalDistributionMode(DistributionParamsSetup params) {
  final mean = params.getValue('mean');
  final dev = params.getValue('dev');
  return exp(mean - pow(dev, 2));
}
