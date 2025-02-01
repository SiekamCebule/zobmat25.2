import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:zobmat25_2/feature/navigation/ui/bloc/navigation_cubit.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_color_scheme.dart';
import 'package:zobmat25_2/feature/theme/domain/entities/app_theme_mode.dart';
import 'package:zobmat25_2/feature/theme/ui/bloc/theme_cubit.dart';

class MainNavigationRail extends StatelessWidget {
  const MainNavigationRail({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationState = context.watch<NavigationCubit>().state;
    final selectedIndex =
        navigationState is NavigationDefault ? navigationState.entry.index : 0;
    final themeState = context.watch<ThemeCubit>().state;

    return ColoredBox(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const Gap(10),
          Expanded(
            child: NavigationRail(
              minWidth: 100,
              backgroundColor: Colors.transparent,
              labelType: NavigationRailLabelType.all,
              unselectedLabelTextStyle: Theme.of(context).textTheme.bodyMedium,
              selectedLabelTextStyle: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
              extended: false,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Symbols.home_rounded),
                  label: Text('Dom'),
                ),
                NavigationRailDestination(
                  icon: Icon(Symbols.function_rounded),
                  label: Text('Katalog'),
                ),
                NavigationRailDestination(
                  icon: Icon(Symbols.info),
                  label: Text('O stronie'),
                ),
              ],
              onDestinationSelected: (index) async {
                context.read<NavigationCubit>().goToIndex(index);
              },
              selectedIndex: selectedIndex,
            ),
          ),
          if (themeState is ThemeAvaiable) ...[
            Builder(
              builder: (context) {
                return IconButton.outlined(
                  tooltip: 'Zmień motyw kolorów',
                  onPressed: () async {
                    final RenderBox button = context.findRenderObject() as RenderBox;
                    final RenderBox overlay =
                        Overlay.of(context).context.findRenderObject() as RenderBox;

                    final Offset position = button.localToGlobal(
                      Offset.zero,
                      ancestor: overlay,
                    );

                    await showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                        position.dx + 45, // Lewa krawędź
                        position.dy + 35, // Górna krawędź
                        position.dx + button.size.width + 45, // Prawa krawędź
                        position.dy + button.size.height + 35, // Dolna krawędź
                      ),
                      items: [
                        PopupMenuItem(
                          child: Text('Zieleń'),
                          onTap:
                              () => context.read<ThemeCubit>().changeAppColorScheme(
                                AppColorScheme.green,
                              ),
                        ),
                        PopupMenuItem(
                          child: Text('Błękit'),
                          onTap:
                              () => context.read<ThemeCubit>().changeAppColorScheme(
                                AppColorScheme.blue,
                              ),
                        ),
                        PopupMenuItem(
                          child: Text('Żółć'),
                          onTap:
                              () => context.read<ThemeCubit>().changeAppColorScheme(
                                AppColorScheme.yellow,
                              ),
                        ),
                        PopupMenuItem(
                          child: Text('Fiolet'),
                          onTap:
                              () => context.read<ThemeCubit>().changeAppColorScheme(
                                AppColorScheme.purple,
                              ),
                        ),

                        PopupMenuItem(
                          child: Text('Pomarańcz'),
                          onTap:
                              () => context.read<ThemeCubit>().changeAppColorScheme(
                                AppColorScheme.orange,
                              ),
                        ),

                        PopupMenuItem(
                          child: Text('Czerń i biel'),
                          onTap:
                              () => context.read<ThemeCubit>().changeAppColorScheme(
                                AppColorScheme.monochrome,
                              ),
                        ),
                      ],
                    );
                  },
                  icon: Icon(Symbols.colors),
                );
              },
            ),
            Gap(15),
            IconButton.outlined(
              tooltip:
                  themeState.theme.themeMode == AppThemeMode.light
                      ? 'Włącz tryb ciemny'
                      : 'Włącz tryb jasny',
              onPressed: () {
                context.read<ThemeCubit>().toggleThemeMode();
              },
              icon: Icon(
                themeState.theme.themeMode == AppThemeMode.light
                    ? Symbols.dark_mode_rounded
                    : Symbols.light_mode_rounded,
              ),
            ),
          ],

          const Gap(20),
        ],
      ),
    );
  }
}
