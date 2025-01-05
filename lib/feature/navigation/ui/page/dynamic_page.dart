import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/page/distributions_catalogue_page.dart';
import 'package:zobmat25_2/feature/distributions_catalogue/ui/widget/distributions_catalogue_rail.dart';
import 'package:zobmat25_2/feature/navigation/domain/entity/navigation_entry.dart';
import 'package:zobmat25_2/feature/navigation/ui/bloc/navigation_cubit.dart';
import 'package:zobmat25_2/feature/navigation/ui/widget/main_navigation_rail.dart';
import 'package:zobmat25_2/feature/home/ui/page/home_page.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({super.key});

  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> with SingleTickerProviderStateMixin {
  late Animation<Offset> _catalogueMenuSlide;
  late AnimationController _catalogueMenuSlideController;
  late StreamSubscription _navigationStateSubscription;

  @override
  void initState() {
    _catalogueMenuSlideController = AnimationController(
      vsync: this,
      duration: Durations.short4,
    );
    _catalogueMenuSlide = CurvedAnimation(
      parent: _catalogueMenuSlideController,
      curve: Curves.fastOutSlowIn,
    ).drive(Tween(begin: Offset(-1.0, 0), end: Offset(0.0, 0.0)));
    scheduleMicrotask(() {
      _navigationStateSubscription = context.read<NavigationCubit>().stream.listen((
        navigationState,
      ) {
        if (navigationState is! NavigationDefault) return;
        if (navigationState.entry == NavigationEntry.distributionsCatalogue) {
          _catalogueMenuSlideController.forward();
        } else {
          _catalogueMenuSlideController.reverse();
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _catalogueMenuSlideController.dispose();
    _navigationStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final navigationState = context.watch<NavigationCubit>().state;
    if (navigationState is! NavigationDefault) {
      return LinearProgressIndicator();
    }
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MainNavigationRail(),
          ClipRect(
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: 350,
              child: SlideTransition(
                position: _catalogueMenuSlide,
                child: DistributionsCatalogueRail(),
              ),
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: Durations.medium1,
              reverseDuration: Duration.zero,
              child: switch (navigationState.entry) {
                NavigationEntry.home => HomePage(),
                NavigationEntry.distributionsCatalogue => DistributionsCataloguePage(),
                //NavigationEntry.about => AboutPage(),
                _ =>
                  throw UnsupportedError(
                    'A page for ${navigationState.entry} has not been implemented yet',
                  ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
