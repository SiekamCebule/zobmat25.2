import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zobmat25_2/feature/navigation/domain/entity/navigation_entry.dart';
import 'package:zobmat25_2/feature/navigation/domain/use_case/get_navigation_entry_use_case.dart';
import 'package:zobmat25_2/feature/navigation/domain/use_case/go_to_navigation_entry_index_use_case.dart';
import 'package:zobmat25_2/feature/navigation/domain/use_case/go_to_navigation_entry_use_case.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit({
    required this.goToNavigationEntryUseCase,
    required this.goToNavigationEntryIndexUseCase,
    required this.getNavigationEntryUseCase,
  }) : super(NavigationInitial());

  final GoToNavigationEntryUseCase goToNavigationEntryUseCase;
  final GoToNavigationEntryIndexUseCase goToNavigationEntryIndexUseCase;
  final GetNavigationEntryUseCase getNavigationEntryUseCase;

  Future<void> initialize() async {
    emit(NavigationDefault(await getNavigationEntryUseCase()));
  }

  void goTo(NavigationEntry entry) async {
    await goToNavigationEntryUseCase(entry);
    emit(NavigationDefault(await getNavigationEntryUseCase()));
  }

  void goToIndex(int index) async {
    await goToNavigationEntryIndexUseCase(index);
    emit(NavigationDefault(await getNavigationEntryUseCase()));
  }
}

abstract class NavigationState extends Equatable {
  const NavigationState();
}

class NavigationInitial extends NavigationState {
  const NavigationInitial();

  @override
  List<Object?> get props => [];
}

class NavigationDefault extends NavigationState {
  const NavigationDefault(this.entry);

  final NavigationEntry entry;

  @override
  List<Object?> get props => [entry];
}
