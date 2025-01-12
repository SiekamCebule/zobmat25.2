import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_description_ui.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_type.dart';
import 'package:data/data.dart' as data;
import 'package:dart_numerics/dart_numerics.dart' as dart_numerics;

final betaDistributionModel = DistributionModel(
  id: 'beta_distribution',
  name: 'Rozkład beta',
  shortDescription:
      'Modeluje prawdopodobieństwo wystąpienia liczb między 0 i 1, choć może być ono większe po jednej ze stron.',
  type: DistributionType.continuous,
  parameters: [
    DistributionParameter(
      'alpha',
      'Alfa (α)',
      'Wskazuje na prawdopodobieństwo wystąpienia wartości bliżej prawej strony.',
      min: 0.0001,
      max: 85.5,
      defaultValue: 1,
    ),
    DistributionParameter(
      'beta',
      'Beta (β)',
      'Wskazuje na prawdopodobieństwo wystąpienia wartości bliżej lewej strony.',
      min: 0.0001,
      max: 85.5,
      defaultValue: 1,
    ),
  ],
  extendedDescription: DistributionDescriptionUi(),
  applicationsDescription: DistributionDescriptionUi(),
);

num betaDistributionPdf(num x, DistributionParamsSetup params) {
  final alpha = params.getValue('alpha');
  final beta = params.getValue('beta');

  if (alpha <= 0 || beta <= 0) {
    throw ArgumentError("Alpha and beta must be greater than 0.");
  }

  if (x < 0 || x > 1) {
    return 0.0; // PDF poza zakresem [0, 1] jest 0
  }

  // Specjalna obsługa krawędzi
  if (x == 0) {
    return (alpha == 1) ? 1.0 / data.beta(alpha, beta) : 0.0; // Dla alpha = 1
  }
  if (x == 1) {
    return (beta == 1) ? 1.0 / data.beta(alpha, beta) : 0.0; // Dla beta = 1
  }

  // Obliczenia w przestrzeni logarytmicznej
  final lnPdf =
      (alpha - 1) * log(x) + (beta - 1) * log(1 - x) - log(data.beta(alpha, beta));

  // Konwersja z przestrzeni logarytmicznej
  final fx = exp(lnPdf);
  return fx;
}

num betaDistributionCdf(num x, DistributionParamsSetup params) {
  const int n = 1000; // liczba kroków do numerycznego całkowania
  final alpha = params.getValue('alpha');
  final beta = params.getValue('beta');

  if (alpha <= 0 || beta <= 0) {
    throw ArgumentError("Alpha and beta must be greater than 0.");
  }

  if (x < 0) {
    return 0.0; // CDF dla x < 0 wynosi 0
  }

  if (x > 1) {
    return 1.0; // CDF dla x > 1 wynosi 1
  }

  final fx = dart_numerics.betaRegularized(alpha, beta, x.toDouble());
  print(
    'F(${x.toStringAsFixed(2)}, alpha: ${alpha.toStringAsFixed(2)}, beta: ${beta.toStringAsFixed(2)}) = $fx',
  );
  return fx;

  // Numeryczne całkowanie (metoda prostokątów)
  double dx = x / n;
  double totalArea = 0.0;

  for (int i = 0; i < n; i++) {
    num t = i * dx; // Punkt na osi x
    // Wywołanie istniejącej funkcji PDF
    num pdfValue = betaDistributionPdf(t, params);
    totalArea += pdfValue * dx;
  }

  return totalArea;
}

num betaDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final alpha = params.getValue('alpha');
  final beta = params.getValue('beta');

  if (alpha <= 0 || beta <= 0) {
    throw ArgumentError("Alpha and beta must be greater than 0.");
  }

  if (p <= 0 || p >= 1) {
    throw ArgumentError("Probability (p) must be in the range (0, 1).");
  }

  // Approximation using binary search
  const epsilon = 1e-10;
  num lower = 0.0;
  num upper = 1.0;
  num mid = 0.5;

  while ((upper - lower) > epsilon) {
    mid = (lower + upper) / 2.0;
    if (betaDistributionCdf(mid, params) < p) {
      lower = mid;
    } else {
      upper = mid;
    }
  }

  return mid;
}
