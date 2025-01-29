import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';

typedef ContinuousDistributionPdf = num Function(num x, DistributionParamsSetup params);
typedef ContinuousDistributionCdf = num Function(num x, DistributionParamsSetup params);
typedef ContinuousDistributionInverseCdf =
    num Function(num x, DistributionParamsSetup params);
typedef ContinuousDistributionRangeGetter =
    (num, num) Function(DistributionParamsSetup params);

typedef DiscreteDistributionPmf = num Function(int x, DistributionParamsSetup params);
typedef DiscreteDistributionCdf = num Function(num x, DistributionParamsSetup params);
typedef DiscreteDistributionRangeGetter =
    (int, int) Function(DistributionParamsSetup params);
