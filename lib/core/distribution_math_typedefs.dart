import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';

typedef DistributionPdf = num Function(num x, DistributionParamsSetup params);
typedef DistributionCdf = num Function(num x, DistributionParamsSetup params);
typedef DistributionInverseCdf = num Function(num x, DistributionParamsSetup params);
