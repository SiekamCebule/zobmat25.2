import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/distribution_dashboard/ui/bloc/distribution_dashboard_cubit.dart';
import 'package:zobmat25_2/feature/distribution_description/ui/widget/distribution_description_component_view.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/domain/entity/distribution_subtypes/distribution.dart';

class DistributionDescriptionView extends StatefulWidget {
  const DistributionDescriptionView({super.key, required this.distribution});

  final Distribution distribution;

  @override
  State<DistributionDescriptionView> createState() => _DistributionDescriptionViewState();
}

class _DistributionDescriptionViewState extends State<DistributionDescriptionView> {
  late StreamSubscription _distributionChangesSubscription;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    scheduleMicrotask(() {
      final dashboardStream = context.read<DistributionDashboardCubit>().stream;
      final appropriateStream = dashboardStream.distinct((prev, current) {
        if (prev is! DistributionDashboardDistributionSelected ||
            current is! DistributionDashboardDistributionSelected) {
          return false;
        }
        return prev.distribution == current.distribution;
      });
      _distributionChangesSubscription = appropriateStream.listen((state) async {
        await _scrollController.animateTo(
          0,
          duration: Durations.medium2,
          curve: Curves.easeOutCubic,
        );
        _scrollController.jumpTo(0);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _distributionChangesSubscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listViewChildren = widget.distribution.extendedDescription.components.map((
      component,
    ) {
      return DistributionDescriptionComponentView(component: component);
    });
    return ListView(controller: _scrollController, children: listViewChildren.toList());
  }
}
