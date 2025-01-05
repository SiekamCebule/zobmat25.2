import 'package:zobmat25_2/feature/navigation/domain/entity/navigation_entry.dart';
import 'package:zobmat25_2/feature/navigation/domain/repository/navigation_repository.dart';

class GoToNavigationEntryIndexUseCase {
  const GoToNavigationEntryIndexUseCase({required this.navigationRepository});

  final NavigationRepository navigationRepository;

  Future<void> call(int index) async {
    final entry = NavigationEntry.values[index];
    await navigationRepository.goTo(entry);
  }
}
