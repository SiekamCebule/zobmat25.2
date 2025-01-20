import 'dart:math';
import 'dart:typed_data';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';
import 'package:data/data.dart' as data;

final betaDistributionModel = ContinuousDistributionModel(
  id: 'beta_distribution',
  name: 'Rozkład beta',
  shortDescription:
      'Modeluje prawdopodobieństwo wystąpienia liczb między 0 i 1, choć może być ono większe po jednej ze stron.',
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
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Rozkład beta opisuje zakres wartości od 0 do 1. Prawdopodobieństwem tym możemy sterować za pomocą dwóch parametrów.\nAlfa (α) wpływa na prawdopodobieństwo wartości bliskiej 1.\nBeta (β) wpływa na prawdopodobieństwo wartości bliskiej 0.\n\nDla lepszego zrozumienia, pobaw się wykresem po lewej stronie. Ustawienie obu parametrów poniżej 1 skutkuje ciekawym kształtem.\n\nUWAGA: wykres zawiesza się dla małych wartości w stylu 0.2, a w dodatku jedna ze stron nie pokazuje się do końca prawidłowo (wykres powinien mieć kształt odwróconego "U", jeśli obie wartości są poniżej 1 i są sobie równe).',
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data:
            r'f(x; \alpha, \beta) = \frac{\Gamma(\alpha + \beta)}{\Gamma(\alpha) \Gamma(\beta)} x^{\alpha - 1} (1 - x)^{\beta - 1}, \, 0 < x < 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data: r'F(x; \alpha, \beta) = I_x(\alpha, \beta), \, 0 \leq x \leq 1',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odwrotna dystrybuanta',
        data: r'F^{-1}(p; \alpha, \beta) = x \text{, gdzie } F(x; \alpha, \beta) = p',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = \frac{\alpha}{\alpha + \beta}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data:
            r'\sigma = \sqrt{\frac{\alpha \beta}{(\alpha + \beta)^2 (\alpha + \beta + 1)}}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data:
            r'\text{Var}(X) = \frac{\alpha \beta}{(\alpha + \beta)^2 (\alpha + \beta + 1)}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'Me \approx I^{-1}(0.5, \alpha, \beta)',
      ),
      DistributionDescriptionMathExpression(
        title: 'Moda',
        data:
            r'Mo = \begin{cases} \frac{\alpha - 1}{\alpha + \beta - 2}, & \alpha > 1, \beta > 1 \\ \text{BRAK}, & \alpha \leq 1 \text{ lub } \beta \leq 1 \end{cases}',
      ),
      DistributionDescriptionParagraph(
        text:
            'Rozkład beta może modelować prawdopodobieństwo sukcesu w [procesie Bernoulliego](https://pl.wikipedia.org/wiki/Proces_Bernoulliego). Proces Bernoulliego jest serią zdarzeń typu sukces/porażka. Załóżmy, że rzucamy nieuczciwą monetą. Kiedy 10 razy wypadnie orzeł, a 22 razy reszka, możemy oszacować prawdopodobieństwo orła poprzez rozkład beta(11, 23). Dodaliśmy 1, ponieważ rozkład beta(1,1) był początkowym rozkładem, do którego dokładamy informacje.\n\nRozkład beta jest stosowany także w genetyce (częstotliwość alleli w populacji), w statystyce sportowej (prawdopodobieństwo trafienia do kosza przez zawodnika NBA), w zarządzaniu projektami czy w marketingu (współczynnik klikalności CTR).',
        containsMarkdownLinks: true,
      ),
    ],
  ),
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

  final fx = betaRegularized(alpha, beta, x.toDouble());
  return fx;
}

double betaRegularized(double a, double b, double x) {
  var bt =
      (x == 0.0 || x == 1.0)
          ? 0.0
          : exp(
            data.gammaLn(a + b) -
                data.gammaLn(a) -
                data.gammaLn(b) +
                (a * log(x)) +
                (b * log(1.0 - x)),
          );

  var symmetryTransformation = x >= (a + 1.0) / (a + b + 2.0);

  var eps = doublePrecision;
  var fpmin = increment(0.0) / eps;

  if (symmetryTransformation) {
    x = 1.0 - x;
    var swap = a;
    a = b;
    b = swap;
  }

  var qab = a + b;
  var qap = a + 1.0;
  var qam = a - 1.0;
  var c = 1.0;
  var d = 1.0 - (qab * x / qap);

  if (d.abs() < fpmin) {
    d = fpmin;
  }

  d = 1.0 / d;
  var h = d;

  for (int m = 1, m2 = 2; m <= 50000; m++, m2 += 2) {
    var aa = m * (b - m) * x / ((qam + m2) * (a + m2));
    d = 1.0 + (aa * d);

    if (d.abs() < fpmin) {
      d = fpmin;
    }

    c = 1.0 + (aa / c);
    if (c.abs() < fpmin) {
      c = fpmin;
    }

    d = 1.0 / d;
    h *= d * c;
    aa = -(a + m) * (qab + m) * x / ((a + m2) * (qap + m2));
    d = 1.0 + (aa * d);

    if (d.abs() < fpmin) {
      d = fpmin;
    }

    c = 1.0 + (aa / c);

    if (c.abs() < fpmin) {
      c = fpmin;
    }

    d = 1.0 / d;
    var del = d * c;
    h *= del;

    if ((del - 1.0).abs() <= eps) {
      return symmetryTransformation ? 1.0 - (bt * h / a) : bt * h / a;
    }
  }

  return symmetryTransformation ? 1.0 - (bt * h / a) : bt * h / a;
}

final double doublePrecision = pow(2, -doubleWidth) as double;
const int doubleWidth = 53;

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

double increment(double value, [int count = 1]) {
  if (value.isInfinite || value.isNaN || count == 0) {
    return value;
  }

  if (count < 0) {
    return decrement(value, -count);
  }

  var bytes = ByteData(8);
  bytes.setFloat64(0, value);
  int intValue = bytes.getInt64(0);
  if (intValue < 0) {
    intValue -= count;
  } else {
    intValue += count;
  }

  if (intValue == int64MinValue) {
    return 0.0;
  }

  bytes.setInt64(0, intValue);
  return bytes.getFloat64(0);
}

double decrement(double value, [int count = 1]) {
  if (value.isInfinite || value.isNaN || count == 0) {
    return value;
  }

  if (count < 0) {
    return decrement(value, -count);
  }

  var bytes = ByteData(8);
  bytes.setFloat64(0, value);
  int intValue = bytes.getInt64(0);

  if (intValue == 0) {
    intValue = int64MinValue;
  }

  if (intValue < 0) {
    intValue += count;
  } else {
    intValue -= count;
  }

  bytes.setInt64(0, intValue);
  return bytes.getFloat64(0);
}

const int int64MinValue = -9007199254740991;
const int int64MaxValue = 9007199254740991;
