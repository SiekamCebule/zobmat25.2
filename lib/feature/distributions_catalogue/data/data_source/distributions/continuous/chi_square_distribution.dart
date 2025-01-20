import 'dart:math';

import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_bulleted_list.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_text_span.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

import 'package:data/data.dart' as data;

final chiSquareDistributionModel = ContinuousDistributionModel(
  id: 'chi_square_distribution',
  name: 'Rozkład chi-kwadrat',
  shortDescription:
      'Rozkład opisujący sumę kwadratów k niezależnych zmiennych losowych o rozkładzie normalnym standardowym. Jest powszechnie używany w testach statystycznych, takich jak test chi-kwadrat, oraz w analizie wariancji, gdzie ocenia zgodność danych z modelem teoretycznym.',

  parameters: [
    DistributionParameter(
      'degrees_of_freedom',
      'Stopnie swobody (k)',
      'Więcej stopni swobody (k) "rozciąga" rozkład. Stopnie swobody są związane z ilością zmiennych w teście chi-kwadrat (spójrz na opis rozkładu chi-kwadrat).', // TODO
      min: 0.7,
      max: 245,
      defaultValue: 1,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Rozkład chi-kwadrat można opisać jako rozkład sumy kwadratów zmiennej losowej o rozkładzie normalnym (μ=0, σ=1).\n\nWyobraź sobie, że masz taki zbiór: {125, 111, 113, 134.5, 125, 128.5}. Musimy go ["zestandaryzować"](https://en.wikipedia.org/wiki/Standard_score), czyli doprowadzić do rozkładu normalnego (μ=0, σ=1). Wyjdzie coś takiego: {0.24, −1.30, −1.08, 1.28, 0.24, 0.62}, gdzie poszczególne liczby oznaczają ilość odchyleń standardowych (σ) od średniej (czyli od zera).\n\nRozkład chi-kwadrat (czytaj: kaj-kwadrat) jest najbardziej użyteczny w kontekście testu chi-kwadrat.\nTest chi-kwadrat sprawdza, czy zależności pomiędzy kategoriami danych są istotne statystycznie (czy nie są przypadkowe). Na przykład możemy sprawdzić, czy narodowość skoczków narciarskich wpływa na ulubioną skocznię, albo czy wybór filmu zależy od płci.\nW skrócie, test chi-kwadrat wygląda następująco:',
        containsMarkdownLinks: true,
      ),
      DistributionDescriptionBulletedList(
        items: [
          DistributionDescriptionParagraph(
            text: 'Przygotowujemy tabelę z danymi (2 rodzaje kategorii)',
          ),
          DistributionDescriptionParagraph(
            text:
                'Określamy hipotezy (hipoteza zerowa najczęściej zakłada brak istotnej zależności między kategoriami).',
          ),
          DistributionDescriptionTextSpan(
            addBottomPadding: false,
            children: [
              DistributionDescriptionParagraph(
                text:
                    'Dla każdej komórki w tabeli obliczamy wartość oczekiwaną według wzoru (R*C/N), gdzie R to suma w danym wierszu, C to suma w danej kolumnie, a N to całkowita suma wszystkich komórek w tabeli.',
              ),
            ],
          ),
          DistributionDescriptionParagraph(
            text:
                'Obliczamy statystykę chi-kwadrat na podstawie danych w tabeli i wartości oczekiwanych. :',
          ),
          DistributionDescriptionParagraph(
            text: 'Obliczamy stopnie swobody (df) (liczba wierszy + liczba kolumn - 2).',
          ),
          DistributionDescriptionParagraph(
            text:
                'Obliczamy p-wartość na podstawie rozkładu chi-kwadrat, stopni swobody i statystyki chi-kwadrat. Istnieją [gotowe kalkulatory](https://www.socscistatistics.com/pvalues/chidistribution.aspx), które obliczają p-wartość.',
            containsMarkdownLinks: true,
          ),
          DistributionDescriptionParagraph(
            text:
                'Ustalamy poziom istotności (α), najczęściej 0.05. Im mniejszy, tym bardziej rygorystyczny test.',
          ),
          DistributionDescriptionParagraph(
            text:
                'Jeśli p > α, odrzucamy hipotezę zerową. Najczęściej oznacza to, że zależności między kategoriami są istotne.',
          ),
        ],
        bulletType: DistributionDescriptionBulletType.numbers,
      ),
      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data:
            r'f(x; k) = \frac{1}{2^{k/2} \Gamma(k/2)} x^{k/2 - 1} e^{-x/2}, \quad x > 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data: r'F(x; k) = \frac{\gamma(k/2, x/2)}{\Gamma(k/2)}, \quad x \geq 0',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data: r'\mathbb{E}[X] = k',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe',
        data: r'\sigma = \sqrt{2k}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wariancja',
        data: r'\text{Var}(X) = 2k',
      ),
      DistributionDescriptionMathExpression(
        title: 'Mediana',
        data: r'Me \approx k \left(1 - \frac{2}{9k}\right)^3',
      ),
      DistributionDescriptionMathExpression(
        title: 'Moda',
        data: r'Mo = \begin{cases} k - 2, & k \geq 2 \\ \text{BRAK}, & k < 2 \end{cases}',
      ),
      DistributionDescriptionParagraph(
        text:
            '[Kliknij tutaj](https://www.simplilearn.com/tutorials/statistics-tutorial/chi-square-test), aby wyświetlić pełniejszy przewodnik po teście chi-kwadrat (w języku angielskim).\nRozkład chi-kwadrat stosuje się w [testach dopasowania](https://en.wikipedia.org/wiki/Goodness_of_fit) i w [testach niezależności](https://pogotowiestatystyczne.pl/slowniki/chi-kwadrat-test-niezaleznosci/).\nRozkład chi-kwadrat jest kluczowym składnikiem rozkładu F, [który stosuje się w analizie wariancji (ANOVA)](https://en.wikipedia.org/wiki/Analysis_of_variance). Rozkład chi-kwadrat jest też używany w kryptoanalizie i w bioinformatyce.',
        containsMarkdownLinks: true,
      ),
    ],
  ),
);

num chiSquareDistributionPdf(num x, DistributionParamsSetup params) {
  final k = params.getValue('degrees_of_freedom');

  if (k <= 0) {
    throw ArgumentError("Degrees of freedom must be greater than 0.");
  }

  if (x < 0) return 0.0;

  return pow(x, (k / 2) - 1) * exp(-x / 2) / (pow(2, k / 2) * gammaStirling(k / 2));
}

double gammaStirling(num x) {
  const double sqrtTwoPi = 2.5066282746310002; // sqrt(2 * pi)

  // Wyrazy poprawkowe Stirlinga
  final corrections = [
    1.0 / (12 * x),
    1.0 / (288 * x * x),
    -139.0 / (51840 * x * x * x),
    -571.0 / (2488320 * x * x * x * x),
    163879.0 / (209018880 * x * x * x * x * x),
    5246819.0 / (75246796800 * x * x * x * x * x * x),
  ];

  // Suma wyrazów poprawkowych
  double correctionSum = 1.0; // Początkowa wartość to 1 (stała w Stirlingu)
  for (final correction in corrections) {
    correctionSum += correction;
  }

  // Przybliżenie Stirlinga
  return sqrtTwoPi * pow(x, x - 0.5) * exp(-x) * correctionSum;
}

double gammaApprox(num x) {
  if (x < 0.5) {
    return pi / (sin(pi * x) * gammaApprox(1 - x));
  }
  return sqrt(2 * pi) * pow(x, x - 0.5) * exp(-x);
}

double autoOptimizedGamma(num x) {
  const eulerGamma = 0.5772156649015329;
  if (x > 0 && x < 1) {
    return (1 / x) - eulerGamma + (x / 2);
  }
  return gammaApprox(x); // W innych przypadkach użyj Lanczosa.
}

num chiSquareDistributionCdf(num x, DistributionParamsSetup params) {
  final k = params.getValue('degrees_of_freedom');

  if (k <= 0) {
    throw ArgumentError("Degrees of freedom must be greater than 0.");
  }

  if (x < 0) return 0.0;

  return data.lowRegGamma(k / 2, x / 2);
}

num chiSquareDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final k = params.getValue('degrees_of_freedom');

  if (k <= 0) {
    throw ArgumentError("Degrees of freedom must be greater than 0.");
  }

  if (p <= 0 || p >= 1) {
    throw ArgumentError("Probability (p) must be in the range (0, 1).");
  }

  return data.gammapInv(p, k / 2) * 2;
}
