import 'dart:math';

import 'package:data/stats.dart';
import 'package:zobmat25_2/core/math/distribution_math_helpers.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_bulleted_list.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_math_expression.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_paragraph.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/components/distribution_description_text_span.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/data/model/distribution_model.dart';
import 'package:zobmat25_2/feature/distribution_description/domain/entity/distribution_description.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_functions/errors/distribution_property_undefined_exception.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_parameter.dart';

final tStudentDistributionModel = ContinuousDistributionModel(
  id: 't_student_distribution',
  name: 'Rozkład t-Studenta',
  shortDescription:
      'Rozkład zbliżony do rozkładu normalnego, ale posiadający grubsze ogony. Powszechnie używany w kontekście "testu t", który jest ważnym narzędziem statystyczym.',

  parameters: [
    DistributionParameter(
      'degrees_of_freedom',
      'Stopnie swobody (df)',
      'Im więcej stopni swobody, tym rozkład jest węższy i bardziej przypomina rozkład normalny. Stopnie swobody są powiązane z ilością próbek w teście t (spójrz na opis rozkładu t-studenta).',
      min: 0.6,
      max: 341.0,
      defaultValue: 3,
    ),
  ],
  extendedDescription: DistributionDescription(
    components: [
      DistributionDescriptionParagraph(
        text:
            'Rozkład t-Studenta jest pomocny, kiedy dysponujemy małą ilością próbek (np. wyniki tylko 20 testów). Jest podobny do rozkładu normalnego, ale ma grubsze ogony. Rozkład t-Studenta naturalnie dąży do rozkładu normalnego, w miarę jak zwiększamy stopnie swobody (df) (rozkładu normalnego warto użyć, kiedy ilość próbek > 30). [Kliknij tutaj](https://www.insfocus.com/resources/who-was-the-famous-student-from-the-t-student-distribution), aby dowiedzieć się trochę o samej historii rozkładu.',
        containsMarkdownLinks: true,
      ),

      DistributionDescriptionTextSpan(
        children: [
          DistributionDescriptionParagraph(
            text: 'Żeby przybliżyć sens rozkładu t-Studenta, warto zrozumieć ',
          ),
          DistributionDescriptionParagraph(
            text: '["test t"](https://pl.wikipedia.org/wiki/Test_t_Studenta) ',
            containsMarkdownLinks: true,
            bold: true,
          ),
          DistributionDescriptionParagraph(
            text:
                ', który jest powszechnie stosowany w statystyce.\nW dużym uproszczeniu wygląda to tak:',
          ),
        ],
      ),
      DistributionDescriptionBulletedList(
        bulletType: DistributionDescriptionBulletType.numbers,
        items: [
          DistributionDescriptionParagraph(
            text:
                'Ustalamy hipotezę zerową i hipotezę alternatywną (np. "Kamil Stoch nie poprawił swoich skoków po treningach" i "Kamil Stoch poprawił swoje skoki po treningach").',
          ),
          DistributionDescriptionParagraph(
            text:
                'Liczymy statystykę t (są różne wzory w zależności od rodzaju testu: dla jednej próbki (porównanie średniej odległości skoczka z oczekiwaną), dla dwóch niezależnych próbek (porównanie średniej odległości dwóch skoczków) i dla dwóch zależnych próbek (porównanie średniej odległości przed i po treningu skoczka).',
          ),
          DistributionDescriptionParagraph(
            text:
                'Ustalamy poziom istotności (od 0 do 1). Im mniej, tym test jest bardziej rygorystyczny.',
          ),
          DistributionDescriptionParagraph(
            text:
                'Ustalamy stopnie swobody, czyli jedyny parametr rozkładu t-Studenta. Ogólna zasada jest taka, że im więcej danych, tym wyższy stopień. Jednakże, różni się to w zależności od rodzaju testu.',
          ),
          DistributionDescriptionParagraph(
            text:
                'Ustalamy wartość krytyczną t (na podstawie poziomu istotności i stopni swobody. Istnieją do tego [gotowe tabele i kalkulatory](https://www.ttable.org))',
            containsMarkdownLinks: true,
          ),
          DistributionDescriptionParagraph(
            text:
                'Odrzucamy jedną z hipotez na podstawie statystyki t i wartości krytycznej t.',
          ),
        ],
      ),
      DistributionDescriptionParagraph(
        text:
            '[Kliknij tutaj](https://datatab.net/tutorial/t-test), aby otworzyć kompletny przewodnik po teście t (w języku angielskim).',
        containsMarkdownLinks: true,
      ),

      DistributionDescriptionMathExpression(
        title: 'Gęstość prawdopodobieństwa',
        data:
            r'f(x) = \frac{\Gamma\left(\frac{\nu + 1}{2}\right)}{\sqrt{\nu \pi} \, \Gamma\left(\frac{\nu}{2}\right)} \left(1 + \frac{x^2}{\nu}\right)^{-\frac{\nu + 1}{2}}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Dystrybuanta',
        data:
            r'F(x) = \int_{-\infty}^{x} \frac{\Gamma\left(\frac{\nu + 1}{2}\right)}{\sqrt{\nu \pi} \, \Gamma\left(\frac{\nu}{2}\right)} \left(1 + \frac{t^2}{\nu}\right)^{-\frac{\nu + 1}{2}} \, dt',
      ),
      DistributionDescriptionMathExpression(
        title: 'Odwrotna dystrybuanta',
        data: r'F^{-1}(p) = \text{BRAK (brak zamkniętej formy analitycznej)}',
      ),
      DistributionDescriptionMathExpression(
        title: 'Wartość oczekiwana',
        data:
            r'\mathbb{E}[X] = \begin{cases} 0, & \nu > 1 \\ \text{BRAK}, & \nu \leq 1 \end{cases}',
      ),
      DistributionDescriptionMathExpression(title: 'Mediana', data: r'Me = 0'),
      DistributionDescriptionMathExpression(title: 'Moda', data: r'Mo = 0'),

      DistributionDescriptionMathExpression(
        title: 'Odchylenie standardowe, wariancja',
        data: r"""
\text{BRAK, jeśli } \nu \leq 2
\begin{cases}
\sigma = \sqrt{\frac{\nu}{\nu - 2}}, & \text{dla } \nu > 2 \\
\text{Var}(X) = \frac{\nu}{\nu - 2}, & \text{dla } \nu > 2
\end{cases}
""",
      ),

      DistributionDescriptionParagraph(
        text:
            'Kluczowym zastosowaniem rozkładu t-Studenta jest testowanie hipotez statystycznych. Przydaje się w modelowaniu rynków finansowych, w analizie ryzyka i w kontroli jakości. Przydaje się tam, gdzie ilość danych jest ograniczona, a potrzebujemy analizy.',
      ),
    ],
  ),
);

num tStudentDistributionPdf(num x, DistributionParamsSetup params) {
  final df = params.getValue('degrees_of_freedom').toDouble();

  final distribution = StudentDistribution(df);

  return distribution.probability(x.toDouble());
}

num tStudentDistributionCdf(num t, DistributionParamsSetup params) {
  final df = params.getValue('degrees_of_freedom').toDouble();

  final distribution = StudentDistribution(df);

  return distribution.cumulativeProbability(t.toDouble());
}

num tStudentDistributionInverseCdf(num p, DistributionParamsSetup params) {
  final df = params.getValue('degrees_of_freedom').toDouble();

  final distribution = StudentDistribution(df);

  return distribution.inverseCumulativeProbability(p.toDouble());
}

(num, num) tStudentDistributionRangeGetter(DistributionParamsSetup params) {
  const prob = 0.00001;

  return (
    findQuantile(cdf: tStudentDistributionCdf, params: params, targetProbability: prob),
    findQuantile(
      cdf: tStudentDistributionCdf,
      params: params,
      targetProbability: 1 - prob,
    ),
  );
}

num tStudentDistributionExpectedValue(DistributionParamsSetup params) {
  final df = params.getValue('degrees_of_freedom');

  if (df > 1) {
    return 0;
  }
  throw DistributionPropertyUndefinedException();
}

num tStudentDistributionVariance(DistributionParamsSetup params) {
  final df = params.getValue('degrees_of_freedom');

  if (df > 2) {
    return df / (df - 2);
  }
  throw DistributionPropertyUndefinedException();
}

num tStudentDistributionStandardDeviation(DistributionParamsSetup params) {
  final variance = tStudentDistributionVariance(params);

  return sqrt(variance);
}

num tStudentDistributionMedian(DistributionParamsSetup params) {
  return 0;
}

num tStudentDistributionMode(DistributionParamsSetup params) {
  return 0;
}
