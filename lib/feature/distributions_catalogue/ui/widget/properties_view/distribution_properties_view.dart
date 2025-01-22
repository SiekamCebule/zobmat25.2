import 'package:flutter/material.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/domain/entity/distribution_params_setup.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';

class DistributionPropertiesView extends StatelessWidget {
  const DistributionPropertiesView({
    super.key,
    required this.distribution,
    required this.paramsSetup,
  });

  final Distribution distribution;
  final DistributionParamsSetup paramsSetup;

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}
