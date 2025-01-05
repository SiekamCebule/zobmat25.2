import 'package:zobmat25_2/feature/navigation/domain/entity/navigation_entry.dart';
import 'package:zobmat25_2/feature/navigation/domain/repository/navigation_repository.dart';

class GoToNavigationEntryUseCase {
  const GoToNavigationEntryUseCase({required this.navigationRepository});

  final NavigationRepository navigationRepository;

  Future<void> call(NavigationEntry entry) async {
    await navigationRepository.goTo(entry);
  }
}
