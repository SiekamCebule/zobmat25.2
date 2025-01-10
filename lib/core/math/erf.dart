import 'dart:math';

num erf(num z) {
  const a1 = 0.254829592;
  const a2 = -0.284496736;
  const a3 = 1.421413741;
  const a4 = -1.453152027;
  const a5 = 1.061405429;
  const p = 0.3275911;

  final sign = z >= 0 ? 1 : -1;
  final absZ = z.abs();

  final t = 1.0 / (1.0 + p * absZ);
  final y =
      1.0 - (((((a5 * t + a4) * t) + a3) * t + a2) * t + a1) * t * exp(-absZ * absZ);

  return sign * y;
}
